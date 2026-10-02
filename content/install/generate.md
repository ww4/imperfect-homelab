+++
title = "Generate"
description = "What comes out, what was minted, and the two files to deal with before you commit"
weight = 2
+++

Secrets never go in the answers file. The ones only you can supply come in by `--secret homelab.acme.credentialsFile=@dns.env` (a file) or `=env:VAR`; the generator refuses to run without them and names the flag to pass. Everything else it mints.

```sh
homelab-configure generate --answers my.json --out ./my-homelab \
  --secret homelab.acme.credentialsFile=@dns.env
```

What comes out is a flake you own. `flake.nix` pins nixpkgs to the rev the library was validated on and imports your modules one line each. `homelab-values.nix` holds every value and one sops declaration per secret. `hosts/<name>/` has the host file (your user, SSH, sops), the disko layout, and a placeholder `hardware.nix` the installer fills. `secrets/` holds the encrypted files, each readable by the host's key and by yours. `answers.json` is the copy a later reconfigure starts from. The generator then evaluates the whole system to prove it builds, and prints the DNS names the chosen modules claim.

Two files need you before the first commit. `FIRST-LOGIN.md` holds every show-once value in plaintext: the admin's console password, the application admin passwords, the restic passphrase. Move them to your password manager and delete the file; it is git-ignored, but that is not storage. `keys/admin-age-key.txt`, if the generator made one, is the key that lets you edit secrets later; move it to `~/.config/sops/age/keys.txt` and delete it from the flake directory. Lose it and the host key, and the secrets are gone with them. Commit the rest; from here every change to the machine is a commit to this repository.

