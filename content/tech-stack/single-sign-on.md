+++
title = "Single sign-on"
description = "Authelia as a forward-auth gate and as an OIDC provider, driven by one list"
weight = 4
+++

Authelia runs in two modes from one module. As a forward-auth gate it puts a real login (password plus TOTP) in front of services that have none of their own, or whose own login you would rather not expose. As an OIDC provider it gives single sign-on to the applications that support it: Grafana, Forgejo, Nextcloud, Paperless and Immich on the reference machine. Both modes share the user database, so one account and one authenticator cover the machine.

One option drives the forward-auth side: a list of subdomain names. The module generates both the nginx `auth_request` wiring and Authelia's access-control rule from that list, because they must always agree and keeping them as two edits is how a vhost ends up with the auth hook but no rule, which shows the user a bare 403 instead of a login page. Machine secrets (the JWT secret, the session key, the OIDC signing key) generate themselves on first boot and are never committed. OIDC client secrets appear in configuration only as one-way hashes; the plaintext lives in each consuming application's encrypted secret, and the configurator mints both halves from one value.

Adding SSO to a new application is three edits: a client block in `homelab.authelia.oidcClients`, the application's own OIDC settings pointed at the issuer, and the secret file. Removing Authelia later means undoing those edits in every application, and the configurator will warn you which ones it would orphan.

