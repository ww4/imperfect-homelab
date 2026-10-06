+++
title = "What this does not claim"
description = "The limits of the model, stated"
weight = 4
+++

Stating the limits is part of the model; a threat model with no exclusions is one nobody has examined. The gates constrain what the agent can apply, not what it can read. It reads everything on the machine that group permissions allow, secret values excepted, other users' service data included. If that is not acceptable for your data, the fix is file permissions, and the chapter on principles says where they live. A compromised Tailscale account is inside the network perimeter regardless of the agent, and single sign-on covers only the applications that support it. The limits that belong to the machine rather than to the agent are in [The trust model](@/principles/the-trust-model.md).

The design does not assume the model is trustworthy. The working assumption is that it is capable and sometimes wrong, and each gate sits where a confidently wrong agent produces a rejected pull request instead of an outage. Nothing here stops it from proposing a bad change; the owner's review does that, and the review is only as good as the diff is readable. That is one reason the library insists on one concern per file and on pull requests scoped to one topic. The guard stops the catastrophic class, the review stops the merely wrong one, and the rehearsal branch catches the change that looks right and is not.
