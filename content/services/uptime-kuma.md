+++
title = "uptime-kuma"
description = "Uptime Kuma status wall-board."
[extra]
generated = true
+++

Uptime Kuma status wall-board.

Memory: about 192 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.uptime-kuma` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `uptime.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

