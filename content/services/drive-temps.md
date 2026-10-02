+++
title = "drive-temps"
description = "Drive temperature + SMART-health exporter for spinning disks."
[extra]
generated = true
+++

Drive temperature + SMART-health exporter for spinning disks.

## Enabling it

Importing `nixosModules.drive-temps` enables it; there is no switch.

**Requires:** [monitoring](@/services/monitoring.md)

## Secrets

None.

## Options

#### `homelab.driveTemps.metricPrefix`

`string` — default `"drive_"`

Prefix for the exported metric names (&lt;prefix&gt;temp_celsius etc.). Keep whatever you already dashboard/alert on if migrating. 

#### `homelab.driveTemps.spindownDriveIds`

`list of string` — default `[ ]`

/dev/disk/by-id names of drives that are allowed to spin down AND whose USB bridges misreport power state (so `smartctl -n standby` would wake them). These are SMART-read only while doing block I/O; an idle drive makes ~no heat, so there's nothing to monitor anyway. 

