+++
title = "silverbullet"
description = "SilverBullet markdown notes/tasks, optionally a two-writer space."
[extra]
generated = true
+++

SilverBullet markdown notes/tasks, optionally a two-writer space.

Memory: about 128 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.silverbullet` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `notes.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.silverbullet.indexPage`

`null or string` — default `null` — example `"Home"`

Space page to open on launch (a capture dashboard beats the space map for quick capture).

#### `homelab.silverbullet.package`

`null or package` — default `null`

SilverBullet package override (e.g. from a newer nixpkgs); null = pkgs.silverbullet.

#### `homelab.silverbullet.secondWriter`

`null or string` — default `null` — example `"agent"`

Unix user granted full mutual write access to the space; null = single-writer.

