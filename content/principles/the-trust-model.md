+++
title = "The trust model"
description = "The internet denied, the network trusted, containers on the opt-in list, and an installer form that configures but cannot erase"
weight = 6
+++

A trust model is the list of who gets to do what without being asked again. This homelab has four entries on that list, and until a security review asked for them in one place you had to infer them from five chapters. The internet is denied, the local network and the tailnet are trusted as networks, containers on the machine are trusted the way the local network is, and the installer's browser form can decide everything about an install except when to erase a disk. Each entry costs something.

## The internet is denied

Nothing on the machine accepts a connection from the public internet. The `nginx-access` module puts one allow/deny block in the shared `http` section, every virtual host inherits it, and a source outside the listed ranges gets a 403 before any backend sees the request. Certificates come from Let's Encrypt over DNS-01, so issuing one means writing a DNS record with your API token rather than answering a challenge on port 80. There is no router port to forward, and forwarding one anyway changes nothing, because the filter rejects a public source address however the packet arrived, and that matters more than it sounds like it should now that many home connections hand out a routable IPv6 address. [The perimeter is the network](@/principles/the-perimeter-is-the-network.md) has the longer version.

## The local network and the tailnet are trusted

The machine treats a device on your LAN and a device on your tailnet as devices that belong there. nginx answers them. What happens after that depends on which service they asked for. Authelia protects the vhosts you name in `homelab.authelia.protectedVhosts`, and the default for that list is empty. Jellyfin, Nextcloud, Immich, Forgejo and Vaultwarden each carry their own accounts and ask on their own, so a login stands in front of them whether or not you list them. Prometheus and Glances ask nothing at all; if you want a login in front of them, those two are the first names to put in the list. The network is the perimeter, and a guest on your wifi reaches a Prometheus holding every metric on the machine unless you said otherwise.

A compromised Tailscale account is inside the perimeter, because being on the tailnet is the whole credential. So is a phone on your wifi with something nasty on it.

## Containers can reach the vhosts

Several services in the library run as containers, on docker bridge networks on the same host. Each gets two kinds of reach, both of them deliberate.

The first is a handful of host services that open a port to the container bridges and to nothing else. Jellyfin opens 8096 so a container that authenticates against it can; ntfy opens 8090 so a dashboard can post a notification; Prometheus opens 9090 and Glances 61208 so a dashboard can query them. Each hole is opened by the module that needs it, scoped to `br-+` interfaces, and invisible to the LAN and the tailnet, which still arrive through the vhost. A module that does not need it opens nothing.

The second is the one the review asked to see stated plainly: containers can reach every vhost. The source allow-list in front of nginx includes the container bridge range, so a vhost treats a request from a container the way it treats a request from a laptop in the next room. That is one switch for the whole machine, `homelab.nginxAccess.containerBridges`, and not a decision you make per service.

It does not skip the application's own login and does not skip Authelia where a vhost is protected, so what a container gains is what a device already on your LAN has. In the bad case, a container somebody has taken over is a device on your network.

We would rather it were narrower and it cannot be, for a reason worth knowing. Docker's bridges live inside the private address ranges: `172.16.0.0/12` means both "the container bridges" and an ordinary home LAN. Nothing in nginx's source filter can tell those apart, because telling them apart means asking which interface a packet arrived on, and that filter only sees addresses. A genuinely narrow answer is a separate internal listener per service, which is a larger change than this library has made.

Emptying the switch is also not free. Uptime Kuma runs in a container and checks the vhosts you tell it to watch, and a dashboard tile that shows a service's status fetches it server-side from a container too. Both stop working. If nothing on your machine reaches a vhost from a container, set the list to empty and lose nothing.

## The browser form decides; the machine consents

The installer is one wizard with two front ends: a console program on the machine's own screen, and a page served on port 8099 to any computer on the network. The browser front end exists because a Cloudflare API token is forty characters of random text and a console has no clipboard. It holds configuration authority in full: every answer, every secret, every module, and which disk gets which role. It does not hold destructive authority.

### The pairing code

The console shows an eight-character code, and the page must present it before the API answers anything at all. The alphabet it is drawn from leaves out every pair that gets read wrong off a screen: no O or 0, no I, 1 or l, no S or 5, no B or 8, no Z or 2. Twenty-five characters survive that, and eight of them is about 37 bits, which is the part doing the work. The server counts wrong codes per source address. It answers the first three immediately. After that it answers each further attempt from the same address about two seconds slower, which turns a guessing loop into something that runs for days. After ten wrong codes it refuses the address outright, and the address stays refused until somebody at the machine clears it; typing the correct code afterwards does not lift the lockout. One address guessing does not shut any other address out, and one correct code resets that address's count to nothing.

### Who may connect at all

Before the server reads a byte of a request it looks at the peer's address and closes the connection if the address is not on a local network. Loopback counts, the private ranges count, link-local counts, IPv6 unique-local and link-local count, and so does `100.64.0.0/10`, the range Tailscale assigns from. A household router that forwards port 8099 to the installer, deliberately or by accident, does not thereby put the form on the internet. The installer image carries the same ranges in its own firewall, so a foreign packet is dropped before the server sees it as well as refused after.

### Pressing Install

Pressing Install in the browser does not start an install. The machine's own screen lists the disks it is about to erase and waits for an answer. Pressing Y there installs. Pressing Escape refuses. Nothing is typed into the browser and nothing about the answer crosses the network, so there is no approval for a listener to catch and nothing for a guesser to try.

An earlier version did this with a number: the machine showed six digits and you typed them into the browser. That is worse than it looks. The digits travelled back over the same unencrypted connection they existed to protect, arriving on the wire at the one moment they mattered, and a wrong guess only cost the price of asking for another number. A keypress on the machine cannot be sent, intercepted or repeated.

An install started at the console needs no approval. The person pressing Install there is standing at the machine, which is the thing being proved.

### What this does not protect

The browser form is plain HTTP, and the secret values on it are encrypted before they leave the page. The installer makes a key pair when it starts, the page seals the Cloudflare token, the VPN credentials, the backup credentials and the admin password to the public half, and only the ciphertext is posted. Something watching your network sees ciphertext. If the page cannot encrypt a value it does not send it, and tells you to type that one on the machine instead. Refusing is deliberate: stopping the encryption from working is easier than breaking it, so a fallback to sending in the clear would be the cheapest way in rather than a convenience.

The page carries its own cryptography to do this, because the browser will not lend it any. A browser only exposes `crypto.subtle` on a secure context, which a plain-HTTP page is not, so the installer ships a small public-domain library and uses that.

This protects against watching, not against rewriting. Somebody who can change traffic in flight, rather than only read it, can serve you a modified page carrying their own key, and then the encryption is theirs.

Both screens show a short fingerprint of the installer's key, and it is worth knowing exactly what that is for. A difference between them means something is wrong, and that is worth catching. A match proves nothing, because the browser's copy of the fingerprint arrived over the same connection an attacker would be rewriting, and they can print the real one beside their own key. The machine's copy is the one that did not travel. Treat the fingerprint as a consistency check, not as proof of who you are talking to.

A certificate would close the gap and would also teach a beginner, in the first ten minutes of their first install, that a browser security warning is a thing you click through. That habit costs more over a year than this exposure costs in the hour the installer runs.

The honest summary is that the installer is protected against a network that watches and is not protected against one that rewrites. What bounds the second case is not cryptographic. An install cannot start without somebody pressing a key on the machine, the answers are frozen from the moment that question is asked until it is answered, and the form itself cannot be taken from whoever is using it without another keypress there. The code written beside the address is enough to look; everything that changes the machine needs a person in front of it.

## Updating the installer itself

A stick burned in March runs March's installer unless something replaces it, so the installer checks the project's binary cache for a newer build of itself and can fetch and run it before the wizard opens. That is a real trust decision, so it has three bounds on it.

The build must be signed by the key baked into the image, named `homelab-installer-1`. Nix checks that signature itself and refuses a build that key did not sign, no matter what the cache claims about it. The fetch runs with `--max-jobs 0`, which means it downloads a finished build or it fails, and never compiles one on a live USB. A failure of any kind falls back to the installer already on the stick.

Before it fetches anything, it prints what it is about to run: the commit, the exact store path, when that build was published, and the name of the key it will require. "It is signed" says nothing without saying by whom, so the name of the key is printed next to the store path it is about to run. Those four lines are read out of the cache's own index and are only as honest as the cache is. The signature check is the part that does not depend on that.

If you would rather not trust the project's cache at all, build the installer yourself from the published commit. A stock NixOS ISO plus `nix run 'github:ww4/homelab-modules?dir=configurator' -- tui` compiles the configurator from source in a few minutes, with no installer cache configured as a substituter and nothing signed by that key in the result.
