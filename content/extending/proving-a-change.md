+++
title = "Proving a change"
description = "Build the machine both ways and compare the closure; what the diff should and should not contain"
weight = 3
+++

The proof for any library change is a build of a real machine that imports the module, compared against the same machine built from the pinned library. The reference machine is the consumer the library came out of, so every library pull request builds it twice: once with the working checkout as an override (`--override-input homelab-modules path:/path/to/checkout --no-write-lock-file`) and once with the committed pin. Two store paths come out. If they are equal the change is a no-op on that machine, and if they differ, `nix store diff-closures` and a diff of `/etc/systemd/system` say how.

What the diff should contain depends on the change. Moving a module out of a private flake into the library should produce an identical toplevel, or a delta you can list in one line (a unit's Description string, a comment in a script). Adding a feature should add the units the feature creates and nothing else. A change that restarts a running container on the deploy that introduces it needs another look, and the usual fix is `Before=` declared from the new unit's side rather than `Requires=` on the old one. The backup module's move produced one Description string and one comment. The API-key seeder produced four new oneshots and one changed wrapper. Both numbers went in the pull request.

For the enabled path of something the reference machine has turned off, render the configuration rather than the closure. `nix eval` with `extendModules` can force an option on and print the resulting `/etc` file or a unit's `serviceConfig` as JSON, and a diff against the same render from the old module proves the port without a parity drive you do not own. The SnapRAID module's proof was that render: `snapraid.conf` and the sync and scrub units were byte-identical with the module force-enabled, and the deployed delta was one tmpfiles line.

`nixos-rebuild build-vm` is the step for a change you cannot prove by comparison, because it is new behaviour. It boots the configuration in QEMU with a throwaway disk, and you can log in, start the service, and probe the vhost. The configurator's end-to-end test is this at larger scale: a VM booted from the installer ISO, the generated flake installed into it, every chosen service probed. A proof that reads "looks fine" is not one. The pull request says which store paths, which units, which lines.

