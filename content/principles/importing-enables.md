+++
title = "Importing enables"
description = "One concern per file, one import line per service, and a catalog that cannot drift"
weight = 3
+++

Importing a module enables it. There is no `enable = true` to remember, except for the few modules that document one because turning them on has a cost or a prerequisite: the monitoring stack, single sign-on, SnapRAID (whose first sync is a manual, hours-long step). One concern, one file, one import line: the reference machine's configuration is a list of imports with a comment on each line saying what it is for, and it reads top to bottom as a description of the machine. The import list is the inventory, and removing a line removes the service. If you can name a thing you can find its file, and its file is the only place you configure it. A module that needs to touch nginx does so through a shared helper, so the module declares its vhost next to the service and not in one central web-server file.

The catalog is the machine-readable index. `nix eval --json .#catalog` returns every module with its one-line purpose, the options it reads, the secrets it needs and their class, the modules it requires, and the vhost it claims. The library's flake checks the catalog against its exported modules at evaluation time, in both directions, so nobody can add a module without an entry and an entry cannot outlive its module. The configurator reads the catalog instead of parsing module headers, and so does the Services section of this site, which the build generates from it and checks for freshness.

A module reads only its own options and the shared ones. It never reaches into another module's configuration except through a declared `requires`, which is what lets you add and remove modules later with no effect on the others.

