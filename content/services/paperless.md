+++
title = "paperless"
description = "Paperless-ngx OCR-indexed document archive."
[extra]
generated = true
+++

Paperless-ngx OCR-indexed document archive.

## Enabling it

Importing `nixosModules.paperless` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `paperless.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.paperless.adminPasswordFile` | `<initial admin password>` | `paperless` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.paperless.adminPasswordFile`

`string` — **required**

Path to the initial admin password (a sops secret owned by paperless).

#### `homelab.paperless.oidcEnvFile`

`null or string` — default `null`

environmentFile carrying the OIDC provider JSON; null disables SSO.

