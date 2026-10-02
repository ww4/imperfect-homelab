+++
title = "Install"
description = "The configurator: answers in, a private flake out, nixos-anywhere does the rest"
weight = 5
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

The install is an answers file, one `generate`, and one `nixos-anywhere` command. The answers file is where the decisions are: which modules, your domain, your disks, your pool. `generate` turns it into a private flake with every secret minted or supplied and encrypted. `nixos-anywhere` installs that flake onto a machine booted from the NixOS ISO, over SSH, and the first boot decrypts the secrets with the host key the generator made for it.

This chapter describes that path as the library's own test runs it, in a virtual machine, for three canned profiles. Your run differs in the disk names and the domain.

