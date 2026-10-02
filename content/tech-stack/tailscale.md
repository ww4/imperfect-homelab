+++
title = "Tailscale"
description = "The only way in from outside, and the perimeter the allow list enforces"
weight = 5
+++

Tailscale is how you reach the machine from anywhere that is not your LAN, and the allow list in nginx admits the tailnet's address range along with the LAN's. There is no port forwarding, no reverse proxy on a VPS, and no public IP that answers. Your DNS records point at the machine's tailnet address, so a name resolves from anywhere and connects only from a device on your tailnet. The module library assumes this; it does not install Tailscale for you, because joining a tailnet is an interactive step on each device.

Two things to know. Tailscale's MagicDNS, if turned on for the machine, replaces the resolver containers see and breaks their outbound DNS while names inside the tailnet keep working; the Field notes chapter has the fix. And Tailscale's Funnel feature, which publishes a service to the internet, binds port 443 on the tailnet address and takes every other vhost down with it on a machine where nginx expects that port. Nothing in this guide uses Funnel.

