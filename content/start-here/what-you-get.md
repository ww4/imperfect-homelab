+++
title = "What you get"
description = "The reference machine, service by service, and the half of it that is yours"
weight = 1
+++

The reference machine runs about fifty services on one NixOS box. The ones most people come for are media (Jellyfin, with Sonarr, Radarr, Lidarr and a torrent client inside a VPN namespace), photos (Immich), documents (Paperless), a password vault (Vaultwarden), a git forge (Forgejo), recipes, notes, and an audiobook server. Under them sit a MergerFS pool with SnapRAID parity, single sign-on through Authelia, and TLS certificates from Let's Encrypt over DNS-01 so nothing has to listen on the internet. Monitoring is Prometheus, Grafana and Alertmanager, with every alert rule and quiet-hours window provisioned from the configuration. Backups are restic to a local pool and to Backblaze B2, with a restore the owner has tested.

Nothing on it is reachable from the public internet. Every web service sits behind an nginx allow list that admits the LAN and the Tailscale network and denies everyone else, and the rule lives in one place so a new service inherits it. The Principles chapter explains why a homelab whose DNS points at private addresses is not protected by that.

The part most homelabs skip is the operating side. Deployment is GitOps: a daemon on the machine polls the git forge and rebuilds when a pull request merges, so nobody runs a rebuild by hand. Two watchdogs compare what the forge holds against what the machine deployed and what the offsite mirror holds, because a deploy pipeline that reads a stale source looks healthy from every dashboard. Drives that drop off the USB bus are remounted by a service that only ever remounts and never repairs. An AI agent does routine operations work as its own Unix user, through pull requests a human merges. That last part has its own chapter.

The library is the reusable half. About forty NixOS modules hold the implementation, every one of them reading your domain, your users, your pool layout and your secret paths from a single `homelab.*` option set, and your own flake is mostly that values file. The reference box keeps a few things private (its hardware scan, a home radio station, some automation that is one family's business), and nothing in this guide depends on them.

