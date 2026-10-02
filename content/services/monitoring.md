+++
title = "monitoring"
description = "Prometheus + Grafana + Alertmanager with alerting provisioned declaratively."
[extra]
generated = true
+++

Prometheus + Grafana + Alertmanager with alerting provisioned declaratively.

## Enabling it

Import `nixosModules.monitoring` and set `homelab.monitoring.enable = true`.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `grafana.<homelab.domain>`, `prometheus.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.monitoring.grafanaOidcSecretFile` | `<OIDC client secret, plaintext>` | `grafana` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.monitoring.alertWebhookUrl`

`string` — default `"http://127.0.0.1:9095/alert"`

Webhook that both Alertmanager and Grafana alerting deliver to — typically a small local shim that forwards to ntfy. 

#### `homelab.monitoring.enable`

`boolean` — default `false` — example `true`

Whether to enable the Prometheus + Grafana + Alertmanager stack.

#### `homelab.monitoring.extraAlertRuleFiles`

`list of absolute path` — default `[ ]`

Extra Grafana alert-rule files (provisioning format, {apiVersion, groups}) merged after the library's generic rules. Site-specific rules — anything whose expressions reference your own exporters — live in your flake and merge in here. 

#### `homelab.monitoring.extraAlertmanagerRoutes`

`list of (attribute set)` — default `[ ]`

Additional Alertmanager routes (matched before the catch-all). The "nights" mute time interval is available to reference. 

#### `homelab.monitoring.extraDatasources`

`list of (attribute set)` — default `[ ]`

Additional Grafana datasources (site-specific).

#### `homelab.monitoring.extraPlugins`

`list of package` — default `[ ]`

Additional declarative Grafana plugins.

#### `homelab.monitoring.extraScrapeConfigs`

`list of (attribute set)` — default `[ ]`

Additional Prometheus scrape configs (site-specific exporters).

#### `homelab.monitoring.grafanaOidcSecretFile`

`null or string` — default `null`

Path to the plaintext OIDC client secret for Grafana's generic_oauth (e.g. a sops secret path). When set, a "Sign in with SSO" button is added, pointing at auth.&lt;domain&gt; (Authelia-style endpoints); the matching pbkdf2 HASH belongs in homelab.authelia.oidcClients. null disables OIDC login (anon viewer + admin form remain). 

#### `homelab.quietHours.end`

`integer between 0 and 23 (both inclusive)` — default `7`

Hour (local time) when non-critical notifications resume.

#### `homelab.quietHours.start`

`integer between 0 and 23 (both inclusive)` — default `22`

Hour (local time) when non-critical notifications stop.

