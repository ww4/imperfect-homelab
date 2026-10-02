+++
title = "meshagent"
description = "MeshCentral MeshAgent so a MeshCentral server can manage this host."
[extra]
generated = true
+++

MeshCentral MeshAgent so a MeshCentral server can manage this host.

Memory: about 48 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.meshagent` enables it; there is no switch.


## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.meshagent.mshFile` | `<server-generated .msh identity file>` | `root` | supply |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.meshagent.mshFile`

`string` — **required**

The server-generated .msh identity file (server URL + MeshID + cert hash; enrollment-capable, so a sops secret). Read by root at start. 

