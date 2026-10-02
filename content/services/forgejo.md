+++
title = "forgejo"
description = "Forgejo git forge."
[extra]
generated = true
+++

Forgejo git forge.

Memory: about 320 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.forgejo` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `git.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.forgejo.oidcSecretFile` | `<OIDC client secret, plaintext>` | `forgejo` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.forgejo.oidcSecretFile`

`null or string` — default `null`

OIDC client secret path (owner = forgejo); null = no SSO wiring.

