+++
title = "A worked example"
description = "A small web service, from an empty file to a vhost behind the gate"
weight = 1
+++

Take a service with one process, one port and one state directory; a system monitor with a web UI is the shape. It needs a NixOS service, a vhost that proxies to it, and a line in the catalog. It needs no secret and no option of its own beyond the domain.

The module file goes in `modules/services/`, and its header comment says what the service is for and which lesson shaped it, because the header is what the next person reads before the code. The body enables the NixOS service, binds it to `127.0.0.1` on its port, and declares the vhost with the shared helper: `services.nginx.virtualHosts."glances.${config.homelab.domain}" = import ../lib/proxy-vhost.nix { port = 61208; }`. The helper adds TLS from the ACME defaults and the forward-auth hook if the name is in the protected list. Nothing in the file names a host, a path on the reference machine, or a person. If the service writes state, a tmpfiles rule in the module creates the state directory, and you add that directory to `homelab.backup.paths` in your values file to get it backed up.

Register it twice. `flake.nix` exports it under `nixosModules.<name>`, and `modules/catalog.nix` gets an entry: a one-line description, `enable = "import"`, the options it reads (`homelab.domain`), what it requires (`acme` and `nginx-access`, because every vhost assumes them), the vhost it claims, and an empty secrets list. The library's flake check refuses to evaluate if the two disagree, so you cannot forget either.

Then run the checks: `tools/leak-scan.sh` for identifiers, `nix flake check` for the catalog, and a build of a machine that imports it. On the reference machine that last step is the proof in the next-but-one chapter. On your own machine it is `nix build .#nixosConfigurations.<host>.config.system.build.toplevel` with the module added to your imports. Deploy by merging. The DNS record for the new name is the one thing you add by hand, and the Day two chapter's probe (every path class, from outside the gate) confirms the vhost is where you think it is.

