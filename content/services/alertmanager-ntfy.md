+++
title = "alertmanager-ntfy"
description = "Alertmanager webhook → ntfy phone notifications."
[extra]
generated = true
+++

Alertmanager webhook → ntfy phone notifications.

## Enabling it

Importing `nixosModules.alertmanager-ntfy` enables it; there is no switch.

**Requires:** [monitoring](@/services/monitoring.md), [ntfy](@/services/ntfy.md)

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.ntfy.topic`

`string` — default `"alerts"`

The alert topic name (subscriber access is granted on it).

