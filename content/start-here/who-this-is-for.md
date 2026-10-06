+++
title = "Who this is for"
description = "What you need, what you do not, and what to skip if you already run one"
weight = 2
+++

You need a machine, a domain you control, and an evening. The machine can be anything that boots the NixOS installer and has a disk for the system and at least one for data; the Hardware chapter says what matters and what does not. The domain is for DNS-01 certificates and for naming services, and this release speaks to one DNS provider, Cloudflare; [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) is the walkthrough for getting a domain there and making the token. A Tailscale account is the simplest way to reach the box from outside your LAN, and the guide assumes it. Backblaze B2 is the tested offsite backup target and costs a few dollars a month at household scale.

You do not need to know Nix. The configurator asks questions and writes the configuration; the Install chapter walks through the output file by file so you can see what it wrote and why. You will need to be comfortable in a terminal over SSH, and you will read more configuration than you write. By the Extending chapter you will be writing a module of your own, and the guide teaches the Nix you need along the way.

If you already run a homelab, the install path still applies, but you will probably skim Start Here and Principles and spend your time in Tech Stack and Extending. The library is a set of modules you can import one at a time into an existing NixOS flake; you do not have to adopt the whole machine to use the storage watchdog or the monitoring.

