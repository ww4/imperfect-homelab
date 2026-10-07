+++
title = "Compatibility"
description = "What this release supports: the NixOS version, CPU architectures, memory per kit, storage layouts, DNS, boot mode, and what happens when upstream moves"
weight = 3
+++

This page is the support matrix for the release. A security review asked for it; the numbers come from the library's own catalog and the installer's own kit lists, not from a wiki page that drifted.

## NixOS release

The library targets NixOS 26.05. The installer's flake pins `nixos-26.05`, and the private flake it writes for you pins the exact nixpkgs revision the installer binary was built against, so the machine you install is the machine the library was validated on. The generated host sets `system.stateVersion = "26.05"`.

Moving off that pin is `nix flake update nixpkgs` in your own flake, done on purpose. Nothing moves it for you.

## CPU architecture

| Architecture | State |
|---|---|
| `x86_64-linux` | Supported. The published installer image targets it, and every change installs the three test profiles on it in a virtual machine. |
| `aarch64-linux` | The configurator package builds for it. There is no installer image, no test coverage, and the answers file defaults `host.system` to `x86_64-linux`. Treat it as unproven. |
| 32-bit x86, armv7 | Not supported. |

## Memory

Every entry in the library's catalog carries an integer: rough steady-state resident memory in MiB at household load, with no burst in it. The installer adds 1024 MiB underneath for the kernel, systemd and the container runtime, adds up whatever you have ticked, and compares the total against the memory of the machine it is running on. On the Kit screen, the installer flags a kit that does not fit before it writes anything.

| Kit | Modules | Sum of the module figures | Plus the 1024 MiB base | Total |
|---|---|---|---|---|
| Minimal | 2 | 0 MiB | 1024 | 1.0 GiB |
| Starter | 10 | 1760 MiB | 1024 | 2784 MiB, 2.7 GiB |
| Media box | 19 | 4048 MiB | 1024 | 5072 MiB, 5.0 GiB |
| Docs and forge | 19 | 5664 MiB | 1024 | 6688 MiB, 6.5 GiB |
| AI box | 10 | 1664 MiB | 1024 | 2688 MiB, 2.6 GiB |
| Everything | 40 | 9272 MiB | 1024 | 10296 MiB, 10.1 GiB |

The module counts include the two foundation modules every install gets, `system` and `boot`, both of which carry a zero. The largest single figures are the ones to know when you are trimming a kit to fit: Immich at 1536 MiB, the download stack at 1280, Paperless at 1024, Nextcloud at 768, the monitoring stack at 640, Jellyfin at 512.

Those are steady-state numbers. A transcode, Immich's machine-learning pass or a SnapRAID sync adds a gigabyte or two for as long as it runs, so size the machine above the total. [What matters](@/hardware/what-matters.md) has the buying advice.

## Storage

The installer writes one fixed layout per disk role, through disko. It erases everything on every disk you give it.

| Role | What the installer writes |
|---|---|
| System | GPT, a 512 MiB ESP at `/boot/efi`, a 4 GiB swap partition, ext4 root |
| Data | One ext4 filesystem, mounted at `/mnt/disks/<name>` |
| Parity | The same ext4 filesystem, held out of the pool to hold SnapRAID parity |

Marking any disk as data turns on `mergerfs-pools`, which unions the data disks into one pool. Marking a parity disk turns on `snapraid`. You decide the pool shape at install, and the installer refuses to remove `mergerfs-pools` on a later reconfigure, because changing it is a data migration, not a setting.

Not supported in this release: ZFS, btrfs, LUKS or any full-disk encryption, mdadm, hardware RAID, and LVM; the disk picker filters out device-mapper, LVM and md devices instead of offering them and failing later. Nothing on the machine is encrypted at rest.

## DNS

The installer supports Cloudflare DNS and nothing else. It asks for a Cloudflare API token, verifies it against Cloudflare's API while you are still on the screen, and creates the DNS records your chosen vhosts need through that same API. The `acme` module's `dnsProvider` option takes any lego provider name and defaults to `cloudflare`, so you can set another provider by hand in your flake afterwards, but the installer will not mint it, will not check it, and nothing in the test runs covers it. The project plans a local-only path, with no domain and no public DNS at all, and has not shipped it. Until it does, a domain on Cloudflare is a requirement of the install and not a preference.

## Graphics cards

Nothing in this release needs a graphics card, and one kit can use one. The AI box runs language models on the machine itself, so the installer offers that kit only where it can both identify the card and say how much video memory it has, and six gigabytes is the floor. Identification comes from a list published alongside this library, built from the PCI device database with memory recorded per card family. A card newer than the list, or any machine the list cannot be fetched on, reads as unknown, and the kit is then shown greyed with that reason rather than hidden. Management chips — the ASPEED and Matrox parts on server boards, and the virtual adapters a hypervisor presents — are marked in the list as not graphics cards, so they never qualify.

The assistant is a separate question and has no such requirement: it runs on any machine, and a card is one of the two places it can get a model from rather than a condition of having one. [A model for the assistant](@/accounts/model-provider.md) covers the other.

Acceleration is not guessed. The installer sets `homelab.ollama.acceleration` from the card it found, `cuda` for NVIDIA and `rocm` for AMD, and each pulls a large vendor build; the CUDA one is unfree. Left unset, the processor does the work, which is correct and slow.

## The VPN account

Only the download stack needs one, and this documentation covers only two providers end to end: Mullvad and Proton VPN. Mullvad forwards no ports, which means slower seeding and trouble with any tracker that wants an open one. Proton VPN forwards a port on its paid plans. Both hand you a WireGuard configuration file to copy a private key and an address out of, and the installer's own screen names the fields it wants from it. The installer checks only the Cloudflare token against its provider while you wait; the download client finds a wrong VPN key after the install.

## Boot mode

UEFI only: the library's `boot` module enables systemd-boot and lets it touch EFI variables, and the disko layout puts the ESP at `/boot/efi` where that module expects it. Legacy BIOS and CSM-only machines are not supported, and neither is Secure Boot: the library ships no signing. The boot menu's kernel command-line editor stays disabled, which closes the no-tooling path from console access to a root shell on a machine whose disks are not encrypted.

## When upstream changes under you

Nothing upstream reaches your machine until you move a pin. Services that come from nixpkgs come from the revision your flake pins. Services that run as containers carry a digest pin, written as `tag@sha256:…`, so a vendor pushing a new build over the same tag does not change what you run.

Upstream arrives on a `nix flake update`, in one of three shapes. An option that nixpkgs renamed or removed fails at evaluation, before nix builds anything. A package that no longer builds fails the build. The third is the awkward one: the service starts and behaves differently, usually a database schema that migrated forward and will not migrate back. That last case is what the rehearsal branch is for, and [GitOps with a rehearsal](@/principles/gitops-with-a-rehearsal.md) describes it.

The library catches the first shape on its own side. Its `nix flake check` builds a machine with every module enabled and real values set, so an option rename in nixpkgs breaks the library's own check rather than your install. Catching the second and third is what a rehearsal and a restore you have already run are for.
