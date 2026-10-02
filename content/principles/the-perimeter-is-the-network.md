+++
title = "The perimeter is the network"
description = "An nginx allow list every vhost inherits, certificates with no inbound path, and what this does not cover"
weight = 4
+++

Nothing on the machine listens to the public internet. Every web service is reachable over Tailscale or the trusted LAN, and an nginx allow/deny block that every virtual host inherits from one place enforces it. Adding a source range is a reviewed commit; adding a vhost needs no gate of its own, because the rule lives in the shared `http` block and a per-vhost gate is a gate someone eventually forgets.

The mistake this prevents is relying on DNS as access control. A homelab whose records point at private addresses feels private, and DNS is not a perimeter. Many residential connections now carry a public IPv6 address. If nginx listens on all interfaces with no allow/deny, anything that can route to the box reaches the backend with a forged `Host` header, and only each application's login stands in the way. The reference machine had that gap until the gate went in. The library module `nginx-access` closes it, and the Day two chapter has you test the closed state from outside before you trust it.

Certificates come from Let's Encrypt over DNS-01. The challenge is answered by a DNS record your API token creates, so issuance needs no inbound path at all, and a service that nobody outside your network can reach still gets a real certificate. The ACME module's defaults are the library's; your flake supplies the email and the token file.

Some things the gate does not cover: a compromised Tailscale account is inside the perimeter, single sign-on covers only the applications that support it, and disks are not encrypted at rest. The Security chapter in Operating with an agent lists the rest.

