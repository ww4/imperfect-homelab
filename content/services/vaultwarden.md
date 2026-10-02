+++
title = "vaultwarden"
description = "Vaultwarden (Bitwarden-compatible) password server."
[extra]
generated = true
+++

Vaultwarden (Bitwarden-compatible) password server.

Memory: about 96 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.vaultwarden` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `<homelab.vaultwarden.subdomain>.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.vaultwarden.envFile` | `ADMIN_TOKEN (argon2 hash)`, `SMTP_* (optional)` | `root` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.vaultwarden.envFile`

`string` — **required**

environmentFile with ADMIN_TOKEN (+ SMTP creds if used).

#### `homelab.vaultwarden.extraConfig`

`attribute set` — default `{ }`

Extra non-secret vaultwarden config (e.g. the SMTP block).

#### `homelab.vaultwarden.subdomain`

`string` — default `"vault"`

Vhost subdomain. (Tip from the field: Chrome Safe Browsing has been known to flag "vault.*" names — pick something else if that bites.) 

