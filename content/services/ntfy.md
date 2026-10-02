+++
title = "ntfy"
description = "Self-hosted ntfy: write-only anonymous access, self-provisioning subscriber."
[extra]
generated = true
+++

Self-hosted ntfy: write-only anonymous access, self-provisioning subscriber.

## Enabling it

Importing `nixosModules.ntfy` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `ntfy.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.adminUser`

`string` — default `"admin"`

Username of the human administrator (SSO seed user, etc.).

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.ntfy.baseUrl`

`string` — default `"http://localhost:8090"`

The URL clients (the phone app) use to reach the ntfy server — typically the host's tailnet IP + port. 

#### `homelab.ntfy.topic`

`string` — default `"alerts"`

The alert topic name (subscriber access is granted on it).

#### `homelab.ntfy.url`

`string` — default `"http://localhost:8090/alerts"`

Full URL (server + topic) that library modules POST notifications to, in ntfy.sh format. Point it at your own ntfy instance/topic. 

