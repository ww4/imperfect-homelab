+++
title = "A bridge the firewall could not see"
weight = 7
+++

A container needed to reach a service on the host, the host's firewall allowed that port on the LAN interface, and the firewall dropped the connection. NixOS scopes firewall rules to the interfaces you name; traffic from a Docker bridge arrives on `br-<id>`, which no rule named. The fix is a rule for the port on the `br-+` interface pattern, so the rule covers any bridge Docker creates. Every container-to-host port on the reference machine has one, and the library's container modules add theirs.

