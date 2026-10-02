+++
title = "DNS and the gate"
description = "Point the names at the machine, then prove the gate from outside"
weight = 1
+++

The generator printed the names the chosen modules claim (`jellyfin.<domain>`, `grafana.<domain>`, and so on). Create one record per name pointing at the machine's tailnet address, or its LAN address if you will only ever use it at home. ACME issues a certificate per name over DNS-01 on the first boot, which needs the DNS API token you supplied and nothing inbound. Until ACME issues a certificate, nginx serves a self-signed placeholder, so a browser warning in the first minutes is expected and a browser warning an hour later is not.

Then prove the gate from outside it; that is the one test the Principles chapter cannot run for you. From a device not on your LAN and not on your tailnet (a phone on mobile data will do), try your connection's public IPv6 address, if it has one, with a `Host` header for one of your vhosts. The answer must be a 403 from nginx, not a login page.

