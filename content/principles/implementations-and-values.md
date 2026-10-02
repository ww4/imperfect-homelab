+++
title = "Implementations and values"
description = "A public library of modules, a private flake of facts, and the option set between them"
weight = 1
+++

The configuration is two repositories, and the line between them is a single option set. The library holds the implementation: about forty NixOS modules for services, storage, monitoring, single sign-on and the download stack. Your flake holds the values: your domain, your admin user, your pool layout, the paths to your secrets, and whatever per-service settings you change from the defaults. The library's `modules/options.nix` declares every `homelab.*` option with a type, a default where one makes sense, and a description, and that file is the whole interface. Another household imports the same modules and writes a different values file.

A module never hardcodes a fact about a site. It reads `config.homelab.domain` for its vhost name, `config.homelab.adminUser` for the account it seeds, `config.homelab.pools` for where the data lives. Where the reference machine needed a personal value during the split, the value became an option with a documented default and the module kept working for everyone else. The rule has a test: the library's leak scan fails the build if a hostname, a path from the reference box, or a tracker name appears anywhere in the public tree. The reference machine's own values file is the proof that the interface is complete, because it builds the real box from the public modules plus that file and nothing else. After the split, the owner compared the box's system closure before and after, module by module, and the two matched.

The library has no inputs of its own. It does not pin a nixpkgs; your flake does, and the modules evaluate against whatever you pinned. That keeps the library out of your lock file's dependency graph and means a library update changes nothing on your machine until you bump the input yourself.

What stays private is a short list. Hardware scans and disk layouts, because they are one machine's. Secrets, because they are yours. A few modules that are one household's business: a home radio station, a dashboard full of personal links, tooling around private trackers. Everything in this guide builds without them.

