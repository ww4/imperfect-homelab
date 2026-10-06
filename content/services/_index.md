+++
title = "Services"
description = "Every module in the library — what it does, what it reads, what it needs"
weight = 8
sort_by = "title"
template = "section.html"
page_template = "page.html"
[extra]
generated = true
+++

One page per module, generated from the library's catalog and option
declarations at the pinned commit. The catalog is checked against the
library's exported modules at evaluation time, and this section is checked
against the catalog, so what you read here is what the code does.

| Module | Purpose | Memory | Enable | Serves |
|---|---|---|---|---|
| [acme](@/services/acme.md) | Let's Encrypt via DNS-01, the TLS default for every vhost. | — | import |  |
| [alertmanager-ntfy](@/services/alertmanager-ntfy.md) | Alertmanager webhook → ntfy phone notifications. | 64 MiB | import |  |
| [arr](@/services/arr.md) | Prowlarr + Sonarr + Radarr + Jellyseerr + qBittorrent inside a Gluetun VPN namespace. | 1280 MiB | import | `prowlarr.<domain>`, `sonarr.<domain>`, `radarr.<domain>`, `requests.<domain>`, `qbittorrent.<domain>` |
| [arr-missing-sweep](@/services/arr-missing-sweep.md) | Weekly search for what is still missing in Sonarr/Radarr, with a metadata-mismatch skip rule. | 8 MiB | import |  |
| [audiobookshelf](@/services/audiobookshelf.md) | Audiobookshelf audiobook / podcast server. | 192 MiB | import | `abs.<domain>` |
| [aurral](@/services/aurral.md) | Aurral music discovery/request UI in front of Lidarr. | 96 MiB | import | `music.<domain>` |
| [authelia](@/services/authelia.md) | Authelia SSO: forward-auth gateway + OIDC provider. | 160 MiB | `homelab.authelia.enable` | `auth.<domain>` |
| [backup](@/services/backup.md) | restic snapshots of the irreplaceable small state: a local repo on the pool plus an optional offsite one, same paths and retention; optional SFTP push target for a second machine. | 64 MiB | import |  |
| [boot](@/services/boot.md) | Bootloader and power behaviour for an always-on server. | — | import |  |
| [decluttarr](@/services/decluttarr.md) | Reap stalled/failed downloads from Sonarr/Radarr and re-search. | 64 MiB | import |  |
| [deploy-drift-watch](@/services/deploy-drift-watch.md) | Alert when the forge has commits the box never deployed. | 8 MiB | `homelab.deployDriftWatch.enable` |  |
| [disk-io-watch](@/services/disk-io-watch.md) | Count kernel I/O errors and USB resets per device; alert on a device that starts failing. | 8 MiB | import |  |
| [drive-temps](@/services/drive-temps.md) | Drive temperature + SMART-health exporter for spinning disks. | 8 MiB | import |  |
| [forgejo](@/services/forgejo.md) | Forgejo git forge. | 320 MiB | import | `git.<domain>` |
| [glances](@/services/glances.md) | Glances system monitor with a REST/web API. | 96 MiB | import | `glances.<domain>` |
| [immich](@/services/immich.md) | Immich photo & video management. | 1536 MiB | import | `photos.<domain>` |
| [jellyfin](@/services/jellyfin.md) | Jellyfin media server. | 512 MiB | import | `jellyfin.<domain>` |
| [lazylibrarian](@/services/lazylibrarian.md) | LazyLibrarian ebook/audiobook automation on the shared /data tree. | 192 MiB | import | `lazylibrarian.<domain>` |
| [lidarr](@/services/lidarr.md) | Lidarr music manager on the shared /data tree. | 320 MiB | import | `lidarr.<domain>` |
| [mergerfs-pools](@/services/mergerfs-pools.md) | Assemble homelab.pools into mounted MergerFS pools. | 96 MiB | import |  |
| [meshagent](@/services/meshagent.md) | MeshCentral MeshAgent so a MeshCentral server can manage this host. | 48 MiB | import |  |
| [metube](@/services/metube.md) | MeTube web GUI for yt-dlp one-off downloads. | 192 MiB | import | `metube.<domain>` |
| [mirror-drift-watch](@/services/mirror-drift-watch.md) | Alert when a git mirror stops tracking its source. | 8 MiB | import |  |
| [monitoring](@/services/monitoring.md) | Prometheus + Grafana + Alertmanager with alerting provisioned declaratively. | 640 MiB | `homelab.monitoring.enable` | `grafana.<domain>`, `prometheus.<domain>` |
| [nextcloud](@/services/nextcloud.md) | Nextcloud with Postgres + Redis, curated apps, optional OIDC SSO. | 768 MiB | import | `cloud.<domain>` |
| [nginx-access](@/services/nginx-access.md) | nginx source-access gate: allow/deny inherited by every vhost from one place. | 64 MiB | import |  |
| [nginx-log-paths-check](@/services/nginx-log-paths-check.md) | Build-time guard: nginx may only be told to write logs where it can write. | 8 MiB | import |  |
| [ntfy](@/services/ntfy.md) | Self-hosted ntfy: write-only anonymous access, self-provisioning subscriber. | 32 MiB | import | `ntfy.<domain>` |
| [paperless](@/services/paperless.md) | Paperless-ngx OCR-indexed document archive. | 1024 MiB | import | `paperless.<domain>` |
| [pinchflat](@/services/pinchflat.md) | PinchFlat YouTube archiver. | 320 MiB | import | `pinchflat.<domain>` |
| [pool-autoremount](@/services/pool-autoremount.md) | Self-healing remount for pool members that drop off the bus; detects zombie mounts with real I/O. | 8 MiB | import |  |
| [qbit-vpn-watchdog](@/services/qbit-vpn-watchdog.md) | Self-heal the gluetun-IP-change qBittorrent wedge. | 8 MiB | import |  |
| [recyclarr](@/services/recyclarr.md) | Sync TRaSH-Guides quality profiles into Sonarr & Radarr daily (bring your own profile YAML). | 16 MiB | import |  |
| [remote-desktop](@/services/remote-desktop.md) | xrdp + XFCE remote desktop, Tailscale-only. | 256 MiB | import |  |
| [silverbullet](@/services/silverbullet.md) | SilverBullet markdown notes/tasks, optionally a two-writer space. | 128 MiB | import | `notes.<domain>` |
| [smart-dump](@/services/smart-dump.md) | Dump the full SMART table for every drive to world-readable files. | 8 MiB | import |  |
| [snapraid](@/services/snapraid.md) | SnapRAID parity for a MergerFS pool's member disks: nightly sync, weekly partial scrub; any one member recoverable per parity disk. | 64 MiB | `homelab.snapraid.enable` |  |
| [system](@/services/system.md) | Locale, Nix settings, nixpkgs config for an always-on server. | — | import |  |
| [tandoor](@/services/tandoor.md) | Tandoor Recipes. | 384 MiB | import | `recipes.<domain>` |
| [unpackerr](@/services/unpackerr.md) | Extract RAR'd releases in place so the *arrs can import them; seeds untouched. | 48 MiB | import |  |
| [uptime-kuma](@/services/uptime-kuma.md) | Uptime Kuma status wall-board. | 192 MiB | import | `uptime.<domain>` |
| [vaultwarden](@/services/vaultwarden.md) | Vaultwarden (Bitwarden-compatible) password server. | 96 MiB | import | `<homelab.vaultwarden.subdomain>.<domain>` |
