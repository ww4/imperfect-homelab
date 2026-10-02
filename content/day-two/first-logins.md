+++
title = "First logins"
description = "Each application once, with the password from FIRST-LOGIN.md, then SSO"
weight = 2
+++

Log in to each application once with the admin password from `FIRST-LOGIN.md`. The ones with single sign-on (Grafana, Forgejo, Nextcloud, Paperless, Immich, when `authelia` is among your modules) will show an SSO button; the admin account you log in with first is the local one, and the application creates the SSO account on first use. Enrol your authenticator in Authelia before anything else, because the forward-auth gate in front of the services without their own login needs it. Two things you must set by hand, because the configuration cannot: the download client's credentials inside Sonarr and Radarr (each app keeps them in its own database), and the first `snapraid sync` if you chose parity.

