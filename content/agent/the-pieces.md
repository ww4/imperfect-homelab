+++
title = "The pieces"
description = "The user, the guard, the allowlist, the applier, the settings tier, and the secrets it cannot read"
weight = 2
+++

A dedicated user. The agent runs as its own system user with its own home directory and does not inherit the owner's SSH keys, wallets, browser sessions, or desktop. Read access to logs comes from group membership, and a root-owned file lists everything else it can do.

A root-owned command guard. Every shell command the agent runs first passes through a guard script installed in `/etc` at mode 0555, owned by root, outside the agent's write access. It denies catastrophic operations however they are phrased: recursive deletes near the root, raw disk writes, force-pushing `main`. It parses git commands instead of pattern-matching them, so it gates a push on the destination ref: `git push origin HEAD:testing` passes and `git push origin main` does not. That precision is a security property. A guard that blocks safe work teaches the operator to route around it, and an operator with a habit of routing around the guard is the thing you were trying to avoid.

A scoped sudo allowlist with fixed-purpose wrappers. The allowlist names exact commands. Where the agent needs a privileged capability, the entry is a wrapper with a closed vocabulary, and the wrapper refuses any argument that would reach the underlying tool. The reference box has three: one for SMART reads, one for read-only restic, one for a handful of network diagnostics. Adding a fourth is a pull request.

The GitOps applier. A daemon on the machine polls the forge, rebuilds when `main` advances, and applies the `testing` branch as a rehearsal that reverts on reboot. Nobody runs `nixos-rebuild` by hand, including the owner, and the agent is not permitted to.

Managed settings. The agent runs under its tool's managed-settings tier, the highest-precedence configuration layer, unwritable by the agent's user, with bypass modes disabled and hooks accepted only from the managed file. It cannot grant itself new powers. Widening its access means editing root-owned files, which means a pull request, which means a human merge.

No secret access. The agent is not a recipient of the encrypted secrets. It can wire a secret's plumbing (the declaration, the file path, the service that reads it) but cannot read any value. When the owner has to hand over a credential, the agent templates a file in an inbox directory and the owner fills in the value. The agent encrypts it from there and deletes the plaintext.

