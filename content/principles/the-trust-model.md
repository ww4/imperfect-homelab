+++
title = "The trust model"
description = "The internet denied, the network trusted, containers on the opt-in list, and an installer form that configures but cannot erase"
weight = 6
+++

A trust model is the list of who gets to do what without being asked again. This homelab has four entries on that list, and until a security review asked for them in one place you had to infer them from five chapters. The internet is denied, the local network and the tailnet are trusted as networks, containers on the machine reach the vhosts that opt in, and the installer's browser form can decide everything about an install except when to erase a disk. Each entry costs something.

## The internet is denied

Nothing on the machine accepts a connection from the public internet. The `nginx-access` module puts one allow/deny block in the shared `http` section, every virtual host inherits it, and a source outside the listed ranges gets a 403 before any backend sees the request. Certificates come from Let's Encrypt over DNS-01, so issuing one means writing a DNS record with your API token rather than answering a challenge on port 80. There is no router port to forward, and forwarding one anyway changes nothing, because the filter rejects a public source address however the packet arrived, and that matters more than it sounds like it should now that many home connections hand out a routable IPv6 address. [The perimeter is the network](@/principles/the-perimeter-is-the-network.md) has the longer version.

## The local network and the tailnet are trusted

The machine treats a device on your LAN and a device on your tailnet as devices that belong there. nginx answers them. What happens after that depends on which service they asked for. Authelia protects the vhosts you name in `homelab.authelia.protectedVhosts`, and the default for that list is empty. Jellyfin, Nextcloud, Immich, Forgejo and Vaultwarden each carry their own accounts and ask on their own, so a login stands in front of them whether or not you list them. Prometheus and Glances ask nothing at all; if you want a login in front of them, those two are the first names to put in the list. The network is the perimeter, and a guest on your wifi reaches a Prometheus holding every metric on the machine unless you said otherwise.

A compromised Tailscale account is inside the perimeter, because being on the tailnet is the whole credential. So is a phone on your wifi with something nasty on it.

## Containers can reach the vhosts that opt in

Several services in the library run as containers, on docker bridge networks on the same host. Each gets two kinds of reach, both of them deliberate.

The first is a handful of host services that open a port to the container bridges and to nothing else. Jellyfin opens 8096 so a container that authenticates against it can; ntfy opens 8090 so a dashboard can post a notification; Prometheus opens 9090 and Glances 61208 so a dashboard can query them. Each hole is opened by the module that needs it, scoped to `br-+` interfaces, and invisible to the LAN and the tailnet, which still arrive through the vhost. A module that does not need it opens nothing.

The second is the one the review asked to see stated plainly: containers can reach the vhosts that opt in, and the allow-list is per vhost. A vhost that opts in treats a request from a container bridge the way it treats a request from a laptop in the next room. The opt-in does not skip the application's own login and does not skip Authelia where that vhost is protected, so what a container gains is what a device already on your LAN has. In the bad case, a container somebody has taken over is a device on your network, with whatever that is worth on the vhosts that let it in. Turning it off everywhere is not free, which is why the decision is per vhost instead of one switch for the machine. Uptime Kuma runs in a container and checks the vhosts you tell it to watch, and a dashboard tile that shows a service's status fetches it server-side from a container too. Opt in the vhosts those need and leave the rest closed.

## The browser form decides; the machine consents

The installer is one wizard with two front ends: a console program on the machine's own screen, and a page served on port 8099 to any computer on the network. The browser front end exists because a Cloudflare API token is forty characters of random text and a console has no clipboard. It holds configuration authority in full: every answer, every secret, every module, and which disk gets which role. It does not hold destructive authority.

### The pairing code

The console shows an eight-character code, and the page must present it before the API answers anything at all. The alphabet it is drawn from leaves out every pair that gets read wrong off a screen: no O or 0, no I, 1 or l, no S or 5, no B or 8, no Z or 2. Twenty-five characters survive that, and eight of them is about 37 bits, which is the part doing the work. The server counts wrong codes per source address. It answers the first three immediately. After that it answers each further attempt from the same address about two seconds slower, which turns a guessing loop into something that runs for days. After ten wrong codes it refuses the address outright, and the address stays refused until somebody at the machine clears it; typing the correct code afterwards does not lift the lockout. One address guessing does not shut any other address out, and one correct code resets that address's count to nothing.

### Who may connect at all

Before the server reads a byte of a request it looks at the peer's address and closes the connection if the address is not on a local network. Loopback counts, the private ranges count, link-local counts, IPv6 unique-local and link-local count, and so does `100.64.0.0/10`, the range Tailscale assigns from. A household router that forwards port 8099 to the installer, deliberately or by accident, does not thereby put the form on the internet. The installer image carries the same ranges in its own firewall, so a foreign packet is dropped before the server sees it as well as refused after.

### Pressing Install

Pressing Install in the browser does not start an install. The machine's own screen shows a six-digit number and the list of disks it is about to erase, and typing that number into the browser is what goes ahead. The number is never sent to the page, which is what makes it a second channel rather than a second password: whoever types it has seen the machine's screen. Three wrong numbers cancel the request. Pressing Install again produces a fresh number, and there is no second try at the old one. Pressing Escape at the machine refuses the request outright.

An install started at the console needs no number. The person pressing Install there is standing at the machine, which is what the number exists to prove.

### What this does not protect

The browser form is plain HTTP. The Cloudflare token, the VPN credentials and the admin password you type into it cross your local network unencrypted, and anything on that network that can watch traffic can read them. This is a known limitation of the release and it is not solved. The alternative available to an installer with no name and no certificate authority is a self-signed certificate, which would encrypt the form and would also teach a beginner, in the first ten minutes of their first install, that a browser security warning is a thing you click through. That habit costs more over a year than this exposure costs in the hour the installer is running. Either way, the tokens alone do not build anything: an install cannot be completed without someone at the machine reading the number off its screen.

## Updating the installer itself

A stick burned in March runs March's installer unless something replaces it, so the installer checks the project's binary cache for a newer build of itself and can fetch and run it before the wizard opens. That is a real trust decision, so it has three bounds on it.

The build must be signed by the key baked into the image, named `homelab-installer-1`. Nix checks that signature itself and refuses a build that key did not sign, no matter what the cache claims about it. The fetch runs with `--max-jobs 0`, which means it downloads a finished build or it fails, and never compiles one on a live USB. A failure of any kind falls back to the installer already on the stick.

Before it fetches anything, it prints what it is about to run: the commit, the exact store path, when that build was published, and the name of the key it will require. "It is signed" says nothing without saying by whom, so the name of the key is printed next to the store path it is about to run. Those four lines are read out of the cache's own index and are only as honest as the cache is. The signature check is the part that does not depend on that.

If you would rather not trust the project's cache at all, build the installer yourself from the published commit. A stock NixOS ISO plus `nix run 'github:ww4/homelab-modules?dir=configurator' -- tui` compiles the configurator from source in a few minutes, with no installer cache configured as a substituter and nothing signed by that key in the result.
