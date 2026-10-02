+++
title = "acme"
description = "Let's Encrypt via DNS-01, the TLS default for every vhost."
[extra]
generated = true
+++

Let's Encrypt via DNS-01, the TLS default for every vhost.

## Enabling it

Importing `nixosModules.acme` enables it; there is no switch.


## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.acme.credentialsFile` | `<DNS provider API credential, lego variable name>` | `root` | supply |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.acme.credentialsFile`

`string` — **required**

environmentFile with the DNS provider API credential (a sops secret).

#### `homelab.acme.dnsProvider`

`string` — default `"cloudflare"`

lego DNS provider name for DNS-01 challenges.

#### `homelab.acme.email`

`string` — **required**

Contact email for Let's Encrypt.

