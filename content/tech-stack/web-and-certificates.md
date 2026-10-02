+++
title = "Web and certificates"
description = "nginx in front of everything, the allow list every vhost inherits, and TLS with no inbound path"
weight = 3
+++

Every service sits behind nginx, and every vhost is declared by the module that serves it. A shared helper turns a port into a vhost: `foo.<domain>` with TLS, proxying to `127.0.0.1:<port>`, the forward-auth hook if the name is in the protected list. The allow/deny gate lives once, in the shared `http` block, so a vhost that forgets it does not exist. Services bind to localhost; only nginx listens on an interface. A new service is a module that calls the helper, and the DNS record is the one thing you add by hand.

Certificates come from Let's Encrypt over DNS-01. The ACME client answers the challenge by creating a DNS record through your provider's API, so issuance needs no port open to the internet, and a name that resolves only inside your tailnet still gets a browser-trusted certificate. The library's `acme` module sets the defaults; your flake supplies an email, a provider name, and the token file.

Two things the reference machine learned here are in the Field notes: a `types {}` block in a vhost replaces the whole MIME map rather than adding to it, and a regex `location` beats a prefix one regardless of order. The library's build-time checks catch the log-path mistakes; those two it cannot, so the Day two chapter has you probe every path class after a change.

