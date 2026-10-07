+++
title = "ollama"
description = "Run open-weight language models on this machine."
[extra]
generated = true
+++

Run open-weight language models on this machine.

Memory: about 300 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.ollama` enables it; there is no switch.


## Secrets

None.

## Options

#### `homelab.ollama.acceleration`

`null or one of "cuda", "rocm"` — default `null`

How the models are run. `null` means the processor does the work, which is correct and slow. "cuda" is for NVIDIA cards and "rocm" for AMD; both pull a large vendor-specific build, and the CUDA one is unfree. The installer sets this from the card it found. 

#### `homelab.ollama.models`

`list of string` — default `[ ]` — example `[   "llama3.2:3b"   "qwen2.5-coder:7b" ]`

Models pulled when the service first starts, so the machine is useful without a second step. Each one is a download of several gigabytes. What a card can comfortably hold is what the installer reports from the published card list. 

