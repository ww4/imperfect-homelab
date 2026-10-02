+++
title = "authelia"
description = "Authelia SSO: forward-auth gateway + OIDC provider."
[extra]
generated = true
+++

Authelia SSO: forward-auth gateway + OIDC provider.

## Enabling it

Import `nixosModules.authelia` and set `homelab.authelia.enable = true`.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `auth.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.adminDisplayName`

`string` — default `"Admin"`

Display name for the administrator.

#### `homelab.adminUser`

`string` — default `"admin"`

Username of the human administrator (SSO seed user, etc.).

#### `homelab.authelia.displayName`

`string` — default `"Homelab"`

WebAuthn display name shown during passkey enrolment.

#### `homelab.authelia.enable`

`boolean` — default `false` — example `true`

Whether to enable Authelia forward-auth + OIDC SSO.

#### `homelab.authelia.oidcClients`

`list of (attribute set)` — default `[ ]`

Authelia OIDC client definitions, passed through verbatim to identity_providers.oidc.clients. Client secrets in these attrsets must be one-way HASHES (authelia crypto hash generate pbkdf2) — the plaintext belongs in the consuming app's sops secret. 

#### `homelab.authelia.protectedVhosts`

`list of string` — default `[ ]` — example `[   "prometheus"   "glances" ]`

Bare subdomain names to put behind forward-auth (two-factor). ONE list drives BOTH the nginx auth_request wiring and the Authelia access-control rule — they must always agree, and making them two separate edits is exactly how a vhost ends up with the auth hook but no rule (result: a bare 403 instead of a login redirect). 

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

