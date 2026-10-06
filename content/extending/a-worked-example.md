+++
title = "A worked example"
description = "A small web service, from an empty file to a vhost behind the gate"
weight = 1
+++

At the end of this you will have added a service to the library: one module file, one catalog entry, two export lines, and a build that proves the machine still evaluates. The example is a service with one process, one port and one state directory, which is the shape a system monitor with a web UI takes. It needs no secret and no option of its own beyond the domain.

## Prerequisites

- A checkout of the module library.
- A NixOS machine you can build, with the library as an input you can override.
- `nix` with flakes enabled.

## Step 1 — Write the module file

The file goes in `modules/services/`. Open it with a header comment saying what the service is for and which lesson shaped it, because the header is what the next person reads before the code.

The body enables the NixOS service and binds it to `127.0.0.1` on its port. Nothing in the file names a host, a path on the reference machine, or a person; every site fact comes in through `homelab.*`.

## Step 2 — Declare the vhost with the shared helper

One line gives the service a name behind the gate:

```nix
services.nginx.virtualHosts."glances.${config.homelab.domain}" =
  import ../lib/proxy-vhost.nix { port = 61208; };
```

The helper adds TLS from the ACME defaults and the forward-auth hook when the name is in the protected list. Declaring the vhost here, next to the service, is what keeps the web server out of a central file that every module has to edit.

## Step 3 — Create the state directory and get it backed up

If the service writes state, a tmpfiles rule in the module creates the directory. Backing it up is the consumer's call, so add that directory to `homelab.backup.paths` in your values file.

## Step 4 — Register the module twice

`flake.nix` exports it under `nixosModules.<name>`. Then `modules/catalog.nix` gets an entry:

- a one-line description
- `enable = "import"`
- the options it reads, here `homelab.domain`
- what it requires: `acme` and `nginx-access`, because every vhost assumes them
- the vhost it claims
- an empty secrets list

The library's flake check refuses to evaluate when the export list and the catalog disagree, so neither half can be forgotten.

## Step 5 — Run the checks

```sh
tools/leak-scan.sh
nix flake check
```

The first looks for identifiers that belong to one household. The second checks the catalog against the exported modules in both directions.

## Step 6 — Build a machine that imports it

Add the module to your own host's imports and build the whole system without touching it:

```sh
nix build .#nixosConfigurations.<host>.config.system.build.toplevel
```

A store path comes out. [Proving a change](@/extending/proving-a-change.md) is what to do with it when the change is supposed to be a no-op.

## Step 7 — Deploy and add the DNS record

Deploy by merging; the daemon rebuilds from `main`. The DNS record for the new name is the one thing you add by hand, and [DNS and the gate](@/day-two/dns-and-the-gate.md) has the probe from outside that confirms the vhost is where you think it is.

## Conclusion

The service is in the library, the catalog describes it, and the Services section of this site will carry a generated page for it on the next refresh. [The option contract](@/extending/the-option-contract.md) is the next chapter, for when a value in your module has to become an option every household can set.
