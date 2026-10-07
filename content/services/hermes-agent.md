+++
title = "hermes-agent"
description = "A self-hosted agent harness that runs code and acts on its own; talks to local or paid models."
[extra]
generated = true
+++

A self-hosted agent harness that runs code and acts on its own; talks to local or paid models.

Memory: about 700 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.hermes-agent` enables it; there is no switch.


## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.hermes.environmentFile` | `OPENAI_API_KEY=…  # or the provider you use; none is needed for local models` | `root` | supply |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.hermes.environmentFile`

`null or absolute path` — default `null`

A file of `KEY=value` lines carrying whichever provider credentials Hermes should use. Not needed at all when it is talking to the models on this machine: with this unset and `ollama` imported, Hermes is pointed at them. Setting it hands the choice of address back to the container, so a file for a provider other than OpenAI should carry that provider's `OPENAI_BASE_URL` as well. 

#### `homelab.hermes.extraMounts`

`list of string` — default `[ ]` — example `[   "/mnt/media/photos:/photos:ro" ]`

Anything else Hermes may see, in docker's `host:container[:ro]` form. ⚠️ This is the whole of its reach. Hermes runs code and acts on what it finds, so each line here is a deliberate decision about what an agent is allowed to touch. Read-only unless it genuinely needs to write. 

#### `homelab.hermes.memoryMax`

`string` — default `"4g"`

A ceiling on the container's memory, so a runaway cannot take the machine with it.

#### `homelab.hermes.stateDir`

`string` — default `"/var/lib/hermes"`

Everything Hermes keeps, and everything it can see unless you add to `extraMounts`.

