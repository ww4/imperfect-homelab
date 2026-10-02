+++
title = "Funnel took every vhost down"
weight = 4
+++

Tailscale Funnel publishes one service to the internet, and turning it on for a single port looked harmless. It binds port 443 on the machine's tailnet address. nginx on the same machine bound 443 on every interface, and a wildcard bind fails when any address on that port is taken, so nginx did not start, and every vhost on the box went dark together. Nothing in this guide uses Funnel; a service that has to be reachable from the public internet belongs on another machine, with this one pushing to it.

