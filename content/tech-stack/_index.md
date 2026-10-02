+++
title = "Tech stack"
description = "NixOS and flakes, MergerFS and SnapRAID, sops-nix, nginx and ACME, Authelia, Tailscale, the monitoring stack, containers on NixOS, restic"
weight = 2
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

Each layer here fits the principles, and where two tools would both have done the job, the one that could be declared in a file won. The storage layer is the one whose choices cost the most to learn, so it has the longest chapter. Monitoring and containers come next, because they are where a declarative setup differs most from what the usual guides show. The rest are short.

Nothing in this section is a tutorial for the tool itself. Each chapter says what the library does with the tool, which settings matter, and which lesson from the reference machine shaped them.

