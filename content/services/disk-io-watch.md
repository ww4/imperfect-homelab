+++
title = "disk-io-watch"
description = "Count kernel I/O errors and USB resets per device; alert on a device that starts failing."
[extra]
generated = true
+++

Count kernel I/O errors and USB resets per device; alert on a device that starts failing.

## Enabling it

Importing `nixosModules.disk-io-watch` enables it; there is no switch.

**Requires:** [monitoring](@/services/monitoring.md)

## Secrets

None.

## Options

#### `homelab.ntfy.url`

`string` — default `"http://localhost:8090/alerts"`

Full URL (server + topic) that library modules POST notifications to, in ntfy.sh format. Point it at your own ntfy instance/topic. 

#### `homelab.quietHours.end`

`integer between 0 and 23 (both inclusive)` — default `7`

Hour (local time) when non-critical notifications resume.

#### `homelab.quietHours.start`

`integer between 0 and 23 (both inclusive)` — default `22`

Hour (local time) when non-critical notifications stop.

