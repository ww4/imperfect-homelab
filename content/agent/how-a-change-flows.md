+++
title = "How a change flows"
description = "From an edit in the agent's clone to a rebuilt machine, and the rehearsal step in between"
weight = 3
+++

A change starts as an edit in the agent's own clone. The agent commits on a branch, pushes it, and opens a pull request through the forge's API with a description of what changed and how the agent validated it. Validation before the PR is the agent's job: it builds the new system closure and compares it against the running one, and the description says what differed. For a change to the module library it builds the consumer machine both ways, with the library checkout as an override and with the real pinned input, and expects the same store path. The owner reads the diff, approves it in the forge's web interface, and merges.

The rehearsal branch is the step in between. Before asking for a merge, the agent can push the same commit to `testing`, and the deploy daemon applies it with `nixos-rebuild test`: the new configuration is live, services restart, and nothing touches the bootloader, so a reboot returns the machine to the last merged state. The agent then checks the real thing (does the vhost answer, did the timer fire, is the metric present) and reports what it saw in the pull request rather than what it expected.

What it has done through this flow: migrated every secret into encrypted storage, stood up single sign-on across six applications, split the module library out of the private flake over two days and some twenty pull requests, and fixed its own guard when the guard blocked a legitimate push. Scheduled headless runs write a status digest, so the machine also reports on itself.

