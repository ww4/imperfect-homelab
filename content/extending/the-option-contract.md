+++
title = "The option contract"
description = "When a value becomes an option, how it is declared, and what the catalog says about it"
weight = 2
+++

A value becomes an option the moment a second household would set it differently. Domain, users, paths, schedules, sizes, and every secret are options; the port a service listens on usually is not, because nothing outside the module cares. Options live in `modules/options.nix` under a group named for the module (`homelab.backup.*`), each with a type, a default where a sensible one exists, and a description written for the person reading the generated reference, because that description is the Services page. An option with no default is a required value, and the configurator will ask for it.

Three option shapes recur: a plain value (`homelab.domain`); a feature group with its own `enable` (`homelab.backup.remote.enable`), where a nullable secret under the group only has to be set when the group is on; and a `File` option for a secret, which is a path and nothing else. For that last one the module reads the file, the header says what it must contain, and the catalog entry classes it as something the tooling can mint, something only you can supply, or something a service used to mint on its first run.

The catalog entry is the contract's machine-readable half. Its fields are the description, the enable mechanism, the option prefixes the module reads, the modules it requires, the vhosts it claims, and the secrets with their class. Tooling reads this instead of the module: the configurator builds its question set from it, this site generates the Services section from it, and a future check will enforce that a module touches no `homelab.*` prefix it did not list. Keep the description to one line that says what the module is for; the header comment in the module is where the reasoning goes.

Two rules cost the reference machine time to learn. A module that assumes a group or user exists must declare it (`jellyfin` once assumed a `media` group only the reference box had). And an option added to the library needs a value or a default on every host that imports the module, which the build will tell you about.

