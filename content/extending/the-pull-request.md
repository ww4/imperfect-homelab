+++
title = "The pull request"
description = "One topic per PR, the proof in the description, and the testing branch if you want to see it run first"
weight = 4
+++

One topic per pull request. A library change and its consumer change are two pull requests in two repositories, the library's first; the consumer's bumps the pin to the merged commit and carries the values. The description says what changed on the machine in one paragraph a reviewer can check, and then the validation: the store paths, the unit diff, which tests ran. A PR that mixes a refactor with a feature gets reviewed as neither. The reference machine's convention is that one open pull request per topic absorbs follow-up tweaks until it merges.

If you want to see it run before anyone merges, push the same commit to `testing`. The deploy daemon applies it with `nixos-rebuild test`, live but gone on reboot, and you probe the real thing. Report in the PR what you saw there. `testing` has to descend from `main` or the daemon ignores it; reset it first if it has drifted.

Merge, and the daemon rebuilds. Check the deployed commit against the forge head, and check the one unit your change added, because a green deploy proves only that the build succeeded.
