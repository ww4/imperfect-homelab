+++
title = "Three kinds of action, three gates"
description = "Read, propose, apply, and what stands in front of each"
weight = 1
+++

The agent's actions fall into three kinds (reading and diagnosing, proposing a change, applying one), and each kind meets a different gate:

| What the agent does | Gate |
|---|---|
| Read and diagnose | Standing, read-only: the journal, plus a few scoped read commands |
| Propose a change | Standing: it edits its own clone and opens a pull request; nothing is applied |
| Apply a change | A human: a pull-request merge, or a short sudo allowlist for a few safe imperative operations |

Reading is standing access. The agent's user is in the `systemd-journal` group, so it can read every service's log without asking. Where a read needs root (SMART data from a drive, a restic snapshot listing), it gets a wrapper with a closed vocabulary: the SMART wrapper enumerates the drives itself and issues only reads, because `smartctl` with free arguments can start a self-test or rewrite drive settings. The restic wrapper accepts `snapshots`, `ls`, `stats` and `find` and nothing else, so it can prove a backup exists but cannot forget or prune one. Diagnosis is most of what an operator does, and all of it is on this row.

Proposing is also standing access, and it is where the agent spends its day. It has its own clone of the configuration, pushes branches, and opens pull requests through the forge's API under its own bot identity. A pull request is a diff and a description, and it has no effect until someone merges it. The agent can also push to a `testing` branch, which the deploy daemon applies with `nixos-rebuild test` (real, but gone on reboot), so it can check its own work on the running machine before asking for a merge.

Applying needs a human. The `main` branch is protected: one approval, merge restricted to the owner, and the agent's account cannot approve its own work. The deploy daemon only ever rebuilds from `main`. The one exception is a sudo allowlist of exact commands for operations that are safe to repeat (restart this named service, run this named job), with no wildcards on dangerous verbs and no `nixos-rebuild`, so the agent cannot apply configuration by a side door. That list is itself configuration, which means widening it is a pull request the owner reads. The next chapter is the pieces that make each gate hold, and none of them is a policy the agent is asked to respect.

