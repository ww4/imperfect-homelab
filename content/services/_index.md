+++
title = "Services"
description = "Every module in the library — what it does, what it reads, what it needs"
weight = 6
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

| Module | Purpose | Enable | Serves |
|---|---|---|---|
| [acme](@/services/acme.md) | Let's Encrypt via DNS-01, the TLS default for every vhost. | import |  |
| [alertmanager-ntfy](@/services/alertmanager-ntfy.md) | Alertmanager webhook → ntfy phone notifications. | import |  |
| [arr](@/services/arr.md) | Prowlarr + Sonarr + Radarr + Jellyseerr + qBittorrent inside a Gluetun VPN namespace. | import | `prowlarr.<domain>`, `sonarr.<domain>`, `radarr.<domain>`, `requests.<domain>`, `qbittorrent.<domain>` |
| [arr-missing-sweep](@/services/arr-missing-sweep.md) | Weekly search for what is still missing in Sonarr/Radarr, with a metadata-mismatch skip rule. | import |  |
| [audiobookshelf](@/services/audiobookshelf.md) | Audiobookshelf audiobook / podcast server. | import | `abs.<domain>` |
| [aurral](@/services/aurral.md) | Aurral music discovery/request UI in front of Lidarr. | import | `music.<domain>` |
| [authelia](@/services/authelia.md) | Authelia SSO: forward-auth gateway + OIDC provider. | `homelab.authelia.enable` | `auth.<domain>` |
| [boot](@/services/boot.md) | Bootloader and power behaviour for an always-on server. | import |  |
| [decluttarr](@/services/decluttarr.md) | Reap stalled/failed downloads from Sonarr/Radarr and re-search. | import |  |
| [deploy-drift-watch](@/services/deploy-drift-watch.md) | Alert when the forge has commits the box never deployed. | `homelab.deployDriftWatch.enable` |  |
| [disk-io-watch](@/services/disk-io-watch.md) | Count kernel I/O errors and USB resets per device; alert on a device that starts failing. | import |  |
| [drive-temps](@/services/drive-temps.md) | Drive temperature + SMART-health exporter for spinning disks. | import |  |
| [forgejo](@/services/forgejo.md) | Forgejo git forge. | import | `git.<domain>` |
| [glances](@/services/glances.md) | Glances system monitor with a REST/web API. | import | `glances.<domain>` |
| [immich](@/services/immich.md) | Immich photo & video management. | import | `photos.<domain>` |
| [jellyfin](@/services/jellyfin.md) | Jellyfin media server. | import | `jellyfin.<domain>` |
| [lazylibrarian](@/services/lazylibrarian.md) | LazyLibrarian ebook/audiobook automation on the shared /data tree. | import | `lazylibrarian.<domain>` |
| [lidarr](@/services/lidarr.md) | Lidarr music manager on the shared /data tree. | import | `lidarr.<domain>` |
| [mergerfs-pools](@/services/mergerfs-pools.md) | Assemble homelab.pools into mounted MergerFS pools. | import |  |
| [meshagent](@/services/meshagent.md) | MeshCentral MeshAgent so a MeshCentral server can manage this host. | import |  |
| [metube](@/services/metube.md) | MeTube web GUI for yt-dlp one-off downloads. | import | `metube.<domain>` |
| [mirror-drift-watch](@/services/mirror-drift-watch.md) | Alert when a git mirror stops tracking its source. | import |  |
| [monitoring](@/services/monitoring.md) | Prometheus + Grafana + Alertmanager with alerting provisioned declaratively. | `homelab.monitoring.enable` | `grafana.<domain>`, `prometheus.<domain>` |
| [nextcloud](@/services/nextcloud.md) | Nextcloud with Postgres + Redis, curated apps, optional OIDC SSO. | import | `cloud.<domain>` |
| [nginx-access](@/services/nginx-access.md) | nginx source-access gate: allow/deny inherited by every vhost from one place. | import |  |
| [nginx-log-paths-check](@/services/nginx-log-paths-check.md) | Build-time guard: nginx may only be told to write logs where it can write. | import |  |
| [ntfy](@/services/ntfy.md) | Self-hosted ntfy: write-only anonymous access, self-provisioning subscriber. | import | `ntfy.<domain>` |
| [paperless](@/services/paperless.md) | Paperless-ngx OCR-indexed document archive. | import | `paperless.<domain>` |
| [pinchflat](@/services/pinchflat.md) | PinchFlat YouTube archiver. | import | `pinchflat.<domain>` |
| [pool-autoremount](@/services/pool-autoremount.md) | Self-healing remount for pool members that drop off the bus; detects zombie mounts with real I/O. | import |  |
| [qbit-vpn-watchdog](@/services/qbit-vpn-watchdog.md) | Self-heal the gluetun-IP-change qBittorrent wedge. | import |  |
| [recyclarr](@/services/recyclarr.md) | Sync TRaSH-Guides quality profiles into Sonarr & Radarr daily (bring your own profile YAML). | import |  |
| [remote-desktop](@/services/remote-desktop.md) | xrdp + XFCE remote desktop, Tailscale-only. | import |  |
| [silverbullet](@/services/silverbullet.md) | SilverBullet markdown notes/tasks, optionally a two-writer space. | import | `notes.<domain>` |
| [smart-dump](@/services/smart-dump.md) | Dump the full SMART table for every drive to world-readable files. | import |  |
| [system](@/services/system.md) | Locale, Nix settings, nixpkgs config for an always-on server. | import |  |
| [tandoor](@/services/tandoor.md) | Tandoor Recipes. | import | `recipes.<domain>` |
| [unpackerr](@/services/unpackerr.md) | Extract RAR'd releases in place so the *arrs can import them; seeds untouched. | import |  |
| [uptime-kuma](@/services/uptime-kuma.md) | Uptime Kuma status wall-board. | import | `uptime.<domain>` |
| [vaultwarden](@/services/vaultwarden.md) | Vaultwarden (Bitwarden-compatible) password server. | import | `<homelab.vaultwarden.subdomain>.<domain>` |
