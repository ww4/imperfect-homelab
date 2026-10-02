+++
title = "jellyfin"
description = "Jellyfin media server."
[extra]
generated = true
+++

Jellyfin media server.

Memory: about 512 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.jellyfin` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `jellyfin.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

