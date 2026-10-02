+++
title = "mirror-drift-watch"
description = "Alert when a git mirror stops tracking its source."
[extra]
generated = true
+++

Alert when a git mirror stops tracking its source.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.mirror-drift-watch` enables it; there is no switch.

**Requires:** [monitoring](@/services/monitoring.md)

## Secrets

None.

## Options

#### `homelab.mirrorDriftWatch.pairs`

`list of (submodule)` — default `[ ]`

Source/mirror repo pairs to watch (anonymous read — public repos only).

#### `homelab.mirrorDriftWatch.pairs.*.branch`

`string` — default `"main"`

Branch to compare.

#### `homelab.mirrorDriftWatch.pairs.*.mirror`

`string` — **required**

Mirror clone URL.

#### `homelab.mirrorDriftWatch.pairs.*.name`

`string` — **required**

Metric label.

#### `homelab.mirrorDriftWatch.pairs.*.source`

`string` — **required**

Source-of-truth clone URL.

