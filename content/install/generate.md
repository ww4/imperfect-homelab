+++
title = "Generate"
description = "Supply the secrets only you have, run generate, and deal with the two files before you commit"
weight = 2
+++

At the end of this you will have a private flake that builds your machine, with every secret either minted for you or supplied by you, and all of them encrypted. Two files in it need your attention before the first commit, and both of them are files you move somewhere else and delete.

## Prerequisites

- An answers file. [The answers file](@/install/the-answers-file.md) is how to write one.
- The supply-class secrets your module list needs, each in a file. `homelab-configure schema --modules …` lists them with the variable names each file must carry.
- Nothing else. The generator mints the rest.

## Step 1 — Put each supplied secret in a file

Secrets never go in the answers file. The ones only you can supply arrive on the command line as a path or an environment variable:

```
--secret homelab.acme.credentialsFile=@dns.env
--secret homelab.acme.credentialsFile=env:CF_TOKEN
```

The generator refuses to run without them and names the exact flag to pass, so a missing one costs you a rerun rather than a broken machine. [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) and [A VPN account for the download client](@/accounts/vpn.md) are the two walkthroughs for getting those values.

## Step 2 — Run generate

```sh
homelab-configure generate --answers my.json --out ./my-homelab \
  --secret homelab.acme.credentialsFile=@dns.env
```

It writes the flake, mints and encrypts every generated secret, then evaluates the whole system to prove it builds, and prints the DNS names your chosen modules claim. Exit 2 means it found problems and listed all of them at once; exit 3 means the result failed to evaluate.

## Step 3 — Read what came out

```
my-homelab/
├── flake.nix              nixpkgs pinned to the rev the library was validated on,
│                          your modules imported one line each
├── homelab-values.nix     every value, plus one sops declaration per secret
├── hosts/<name>/          the host file, the disko layout, a placeholder hardware.nix
├── secrets/               the encrypted files, readable by the host key and by yours
├── answers.json           the copy a later reconfigure starts from
├── FIRST-LOGIN.md         every show-once value, in plaintext
└── keys/admin-age-key.txt the key that lets you edit secrets later, if one was made
```

The flake is yours. Nothing in it points back at the library except the pinned input.

## Step 4 — Empty FIRST-LOGIN.md

`FIRST-LOGIN.md` holds every show-once value in plaintext: the admin's console password, the application admin passwords, the restic passphrase. Move them into your password manager and delete the file. It is git-ignored, which is not the same as being stored safely.

## Step 5 — Move the admin age key off the flake directory

If the generator made one, `keys/admin-age-key.txt` is the key that lets you decrypt and edit secrets later. Move it to `~/.config/sops/age/keys.txt` and delete it from the flake directory:

```sh
mkdir -p ~/.config/sops/age
mv ./my-homelab/keys/admin-age-key.txt ~/.config/sops/age/keys.txt
```

Lose this key and the host key together and the secrets are gone with them. Keep a copy somewhere that is not the machine you are about to install.

## Step 6 — Commit the rest

```sh
cd my-homelab && git init && git add -A && git commit -m "initial configuration"
```

From here, every change to the machine is a commit to this repository.

## Conclusion

You have a flake that describes a machine, with its secrets encrypted to a host key that does not exist yet. [nixos-anywhere](@/install/nixos-anywhere.md) installs it onto hardware and puts that host key in place before the first boot.
