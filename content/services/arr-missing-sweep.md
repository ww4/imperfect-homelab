+++
title = "arr-missing-sweep"
description = "Weekly search for what is still missing in Sonarr/Radarr, with a metadata-mismatch skip rule."
[extra]
generated = true
+++

Weekly search for what is still missing in Sonarr/Radarr, with a metadata-mismatch skip rule.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.arr-missing-sweep` enables it; there is no switch.

**Requires:** [arr](@/services/arr.md)

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.arrMissingSweep.apiEnvFile` | `SONARR_API_KEY`, `RADARR_API_KEY` | `<homelab.arrMissingSweep.user>` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.arrMissingSweep.apiEnvFile`

`string` — **required**

Shell-sourceable file exporting SONARR_API_KEY and RADARR_API_KEY (a sops secret owned by `user`). 

#### `homelab.arrMissingSweep.user`

`string` — default `"root"`

User the weekly *arr missing-sweep runs as. Set it to whichever user owns the secret behind apiEnvFile. 

#### `homelab.ntfy.url`

`string` — default `"http://localhost:8090/alerts"`

Full URL (server + topic) that library modules POST notifications to, in ntfy.sh format. Point it at your own ntfy instance/topic. 

