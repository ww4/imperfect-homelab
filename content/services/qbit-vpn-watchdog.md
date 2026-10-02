+++
title = "qbit-vpn-watchdog"
description = "Self-heal the gluetun-IP-change qBittorrent wedge."
[extra]
generated = true
+++

Self-heal the gluetun-IP-change qBittorrent wedge.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.qbit-vpn-watchdog` enables it; there is no switch.

**Requires:** [arr](@/services/arr.md)

## Secrets

None.

## Options

#### `homelab.ntfy.url`

`string` — default `"http://localhost:8090/alerts"`

Full URL (server + topic) that library modules POST notifications to, in ntfy.sh format. Point it at your own ntfy instance/topic. 

