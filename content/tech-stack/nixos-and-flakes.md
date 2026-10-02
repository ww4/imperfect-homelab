+++
title = "NixOS and flakes"
description = "One flake, three machines, a pinned library, and an installer you do not write"
weight = 1
+++

One flake builds every machine. The reference fleet is three hosts (a storage and services box, a compute node that does builds and ML inference, a laptop), each a `nixosConfigurations` entry in one `flake.nix`, sharing the library and the values file where they overlap. The library is an input pinned by commit in `flake.lock`, so a library change deploys nothing until a pull request bumps the pin. Your configurator-generated flake has the same shape with one host in it. Adding a second host later is a second entry and a second hardware file.

The system closure is the unit of proof. `nix build .#nixosConfigurations.<host>.config.system.build.toplevel` evaluates and builds the whole machine without touching it, and the resulting store path is a hash of everything in it. Two configurations that produce the same path are the same machine, and that is the check behind every change in this guide: build before, build after, compare. `nix store diff-closures` lists what changed between two builds, down to the package version.

Installation is nixos-anywhere with disko. The configurator writes the disk layout and the flake; nixos-anywhere installs it over SSH onto anything booted from the NixOS ISO. Nothing in that path is custom.

