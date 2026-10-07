+++
title = "open-webui"
description = "A browser front end for the models ollama is serving."
[extra]
generated = true
+++

A browser front end for the models ollama is serving.

Memory: about 500 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.open-webui` enables it; there is no switch.

**Requires:** [ollama](@/services/ollama.md), [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `chat.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

