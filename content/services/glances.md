+++
title = "glances"
description = "Glances system monitor with a REST/web API."
[extra]
generated = true
+++

Glances system monitor with a REST/web API.

## Enabling it

Importing `nixosModules.glances` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `glances.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

