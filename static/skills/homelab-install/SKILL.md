---
name: homelab-install
description: Install, reconfigure, or extend an Imperfect Homelab (a NixOS homelab from the homelab-modules library) for the user, driving homelab-configure headlessly. Use when the user points at ww4.github.io/imperfect-homelab or asks to set up "the imperfect homelab", or when a machine is booted from its installer ISO.
---

# Installing an Imperfect Homelab for someone

You drive `homelab-configure`, the headless tool the TUI itself calls. It
takes an answers file in and writes a private NixOS flake out; nothing is
installed until `install` (on the box) or `nixos-anywhere` (from elsewhere)
runs. Every command takes `--json`. Exit codes: 0 ok · 2 answers rejected,
with every problem listed · 3 validation failed · 1 anything else.

## Rules that are not yours to relax

- Secrets never go in the answers file or in chat. Supplied secrets come in
  by `--secret <option>=@<file>` or `=env:VAR`. Ask the user to put the
  value in a file (or type it on the TUI's Domain screen); never ask them to
  paste it to you.
- `install` erases disks. Run it only with the user's explicit go-ahead for
  the exact device names, and prefer letting them type the confirmation.
- The foundation set is enforced by the tool (system, boot always; backup
  must be chosen and configured; mergerfs-pools and backup cannot be
  removed later). Do not argue with a rejection; fix the answers.
- A `--remove` that `requires` pulls back in is reported, not applied.

## Two ways to run it

**On the box, from the installer ISO** (the user is at the machine): they
boot the ISO, run `passwd` on the console, tell you the IP. `ssh nixos@<ip>`
(sudo needs no password there). The tool is on the PATH as
`homelab-configure`. Work in `/home/nixos`.

**From any machine with nix** (installing a different box over SSH):
`nix run 'github:ww4/homelab-modules?dir=configurator' -- <command>`,
then `nixos-anywhere` as the generated README says.

## Procedure

1. `homelab-configure schema --json` — the catalog: modules, their options
   (type, default, required?), their secrets (class: generate / supply).
   Start from a canned profile (`profiles/media-box.json`, `docs-forge.json`,
   `everything.json` in the library's `configurator/` directory) and ask only
   about what differs: domain, admin user, time zone, which modules.
2. Disks: on the box, `ls -l /dev/disk/by-id/` (or `lsblk -d -o NAME,SIZE,MODEL`);
   never choose the disk the live system booted from. Put stable
   `/dev/disk/by-id/…` names in `host.disk` (system, erased) and
   `host.dataDisks` (each `{name, device}`; a parity disk is named `parity`
   and the pool's `branches` then lists the data disks explicitly).
3. Write `answers.json` (shape in the configurator README). SSH keys: a
   GitHub username's keys are at `https://github.com/<user>.keys`.
4. Supplied secrets: for each `supply`-class secret in the schema, ask the
   user to create the file (the schema's `keys` say the variable names; the
   site's Secrets guidance covers Cloudflare, VPN providers, B2). Verify a
   Cloudflare token with `GET https://api.cloudflare.com/client/v4/zones?name=<domain>`
   before relying on it.
5. `homelab-configure generate --answers answers.json --out my-homelab --secret … --json`.
   On exit 2, fix what it lists and rerun. It evaluates the result; a `warnings`
   array and `next_steps` are in the JSON. `FIRST-LOGIN.md` holds show-once
   passwords: tell the user to read and delete it, do not read it to them.
6. On the box: `sudo homelab-configure install my-homelab` (the user types
   the host name to confirm; `--yes` only if they said so explicitly). It
   writes hardware.nix, partitions, installs, places the host key, and copies
   the flake to `/root/homelab` on the new system. Then `reboot`.
   Elsewhere: the `nixos-anywhere` command from the generated README.
7. After first boot, once Tailscale is joined (or with `--ip`):
   `homelab-configure dns my-homelab` creates the vhost A records with the
   ACME token. Then the Day-two chapter: first logins, a restore drill, the phone.

## Later

`homelab-configure generate --out my-homelab --add <module> --remove <module> --set homelab.x=<json>`
reconfigures an existing output: secrets, keys and the console password are
kept; removals are checked. Commit the directory; every change is a commit.
