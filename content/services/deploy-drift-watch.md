+++
title = "deploy-drift-watch"
description = "Alert when the forge has commits the box never deployed."
[extra]
generated = true
+++

Alert when the forge has commits the box never deployed.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Import `nixosModules.deploy-drift-watch` and set `homelab.deployDriftWatch.enable = true`.

**Requires:** [monitoring](@/services/monitoring.md)

## Secrets

None.

## Options

#### `homelab.deployDriftWatch.branch`

`string` — default `"main"`

Branch the applier deploys.

#### `homelab.deployDriftWatch.cominMetricsUrl`

`string` — default `"http://127.0.0.1:4243/metrics"`

comin's metrics endpoint (source of the deployed commit id).

#### `homelab.deployDriftWatch.enable`

`boolean` — default `false` — example `true`

Whether to enable the forge-vs-deployed drift watcher.

#### `homelab.deployDriftWatch.repoUrl`

`string` — default `""` — example `"https://git.example.com/me/flakes.git"`

The flake repo the GitOps applier deploys from. Empty (the default) means there is no repo yet: the check does nothing until you set it.

