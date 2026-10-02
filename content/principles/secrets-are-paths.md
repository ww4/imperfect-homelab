+++
title = "Secrets are paths"
description = "The library names no secret; your flake declares them, encrypted, and hands over a file path"
weight = 2
+++

The library never declares a secret and never reads one by name. Where a module needs a credential, it exposes an option ending in `File` (`homelab.acme.credentialsFile`, `homelab.backup.passwordFile`) and reads whatever path you put there. The module's header says what the file must contain, down to the variable names. How the file gets to that path is your flake's business.

In the consumer's flake, sops-nix keeps every credential encrypted in the repository and decrypts it at activation with the machine's own SSH host key. The configuration is therefore self-contained: a host whose key is a recipient can rebuild from a bare clone, and no plaintext credential exists in the repository or its history. The values file declares each secret once (`sops.secrets."restic-password"`) and points the module's option at `config.sops.secrets."restic-password".path`, which resolves to a root-owned file under `/run/secrets` at boot. Each secret declares its own owner and mode, so a service that runs as its own user gets a file it can read and nothing else can. The recipient list is the access boundary. Two keys can decrypt: the machine's host key, and an administrator key you keep somewhere that is not the machine. Lose both and the secrets are gone with them, which is why the install writes the admin key to a file it tells you to move. The agent that operates the reference machine is not a recipient, so it can wire a secret's plumbing but cannot read a value. The configurator writes all of this for you on a fresh install, and the pattern is the same one you follow by hand when you add a service later.

Secrets come in three classes, and the catalog records which is which. Some the tooling can mint for you (admin passwords, OIDC client secrets, the restic passphrase). Some only you can supply (a DNS API token, a VPN configuration). The third class, values a service used to mint for itself on its first run, is empty now: the download stack's modules seed the API keys into each application before it starts, so they are values the configuration owns.

