+++
title = "GitOps, with a rehearsal branch"
description = "A merge deploys; a push to testing rehearses; two watchdogs watch the pipeline itself"
weight = 5
+++

Nobody runs `nixos-rebuild` on the reference machine, including its owner. A daemon ([comin](https://github.com/nlewo/comin)) polls the git forge and rebuilds the machine when `main` advances; `main` is branch-protected, so a reviewed merge is the only thing that advances it. Git holds the history and the NixOS generation list holds the rollback. The forge is self-hosted, and a mirror on GitHub is both an offsite copy of the configuration and a fallback source the daemon can deploy from. The library is a flake input pinned by commit, so a library change deploys nothing until a pull request bumps the lock.

The rehearsal branch is the part that makes an agent operator workable, and it is useful to a human for the same reason. The daemon applies a push to the unprotected `testing` branch with `nixos-rebuild test`: the configuration goes live and services restart, and it writes nothing to the bootloader, so a reboot returns the machine to the last merged state. You check the real thing (the vhost answers, the timer fired, the metric is there) before you ask anyone to merge. The one rule is that `testing` must descend from `main`; a diverged branch is ignored by design, and the reference machine's push hook refuses it.

Two watchdogs watch the pipeline itself. One compares the forge's branch head with the commit the daemon last deployed, because a deploy pipeline that looks healthy while reading a stale source is a failure the dashboards miss. The other compares the forge with its mirror, so a mirror that stopped tracking is an alert instead of a surprise found during a disaster. Both ship their own alert rules. The reference machine lost its deploys for two days once to an expired mirror token and found out by accident; the watchdogs are the result. A failed check publishes a failure, never stale data that reads as healthy. The library's exporters and watchdogs follow that rule, and the Field notes chapter has the incidents that taught it.
