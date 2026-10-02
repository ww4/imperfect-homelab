+++
title = "pinchflat"
description = "PinchFlat YouTube archiver."
[extra]
generated = true
+++

PinchFlat YouTube archiver.

## Enabling it

Importing `nixosModules.pinchflat` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `pinchflat.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.pinchflat.mediaDir`

`string` — **required** — example `"/mnt/media/pinchflat"`

Where PinchFlat stores downloaded media.

