+++
title = "nextcloud"
description = "Nextcloud with Postgres + Redis, curated apps, optional OIDC SSO."
[extra]
generated = true
+++

Nextcloud with Postgres + Redis, curated apps, optional OIDC SSO.

Memory: about 768 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.nextcloud` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `cloud.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.nextcloud.adminPasswordFile` | `<initial admin password>` | `nextcloud` | generate |
| `homelab.nextcloud.oidcSecretFile` | `<OIDC client secret, plaintext>` | `nextcloud` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.nextcloud.adminPasswordFile`

`string` — **required**

Initial admin password file (sops; owner = nextcloud).

#### `homelab.nextcloud.oidcSecretFile`

`null or string` — default `null`

OIDC client secret path (owner = nextcloud); null = no SSO wiring.

