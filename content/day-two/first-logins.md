+++
title = "First logins"
description = "Each application once, the authenticator enrolled, and the two things the configuration cannot set"
weight = 2
+++

At the end of this you will have signed in to every application once, enrolled an authenticator, and set the two values no configuration file can set for you. None of it takes long; the order is what matters, because the authenticator gates the services that have no login of their own.

## Prerequisites

- `FIRST-LOGIN.md`, or the passwords from it already in your password manager.
- An authenticator app on your phone, if `authelia` is among your modules.
- The service names resolving, from [DNS and the gate](@/day-two/dns-and-the-gate.md).

## Step 1 — Enrol your authenticator in Authelia

Do this first. The forward-auth gate in front of the services that have no login of their own needs it, so until it is enrolled those services are closed to you as well as to everyone else.

Open your Authelia address, sign in with the admin password from `FIRST-LOGIN.md`, and register a one-time-password app when it asks.

## Step 2 — Log in to each application once

Work down the list with the admin password from `FIRST-LOGIN.md`. The applications wired for single sign-on (Grafana, Forgejo, Nextcloud, Paperless and Immich, when `authelia` is among your modules) show an SSO button next to the password form.

The admin account you log in with first is the application's own local account. The application creates the SSO account the first time somebody signs in through the button, so both exist and the local one is your way back in if single sign-on ever breaks.

## Step 3 — Tell Sonarr and Radarr about the download client

Each of those applications keeps the download client's address and credentials in its own database, which is why the configuration cannot set them. Open qBittorrent's web UI first and set the web-UI login you want. Then open Sonarr and Radarr, go to the download-client settings in each, add qBittorrent, and give it that address and that login.

If the download client is not reachable at all, its tunnel is the place to look, and [A VPN account for the download client](@/accounts/vpn.md) has the checks.

## Step 4 — Run the first snapraid sync

If you chose parity, it does not exist until the first sync has run, and that run builds it from scratch over hours. The module leaves it to you for that reason:

```sh
sudo snapraid sync
```

Start it somewhere a dropped SSH session will not take it with you, under `tmux` or `screen`. The nightly timer takes over afterwards, and finds nothing to do until something changes.

## Conclusion

Every application has an account you can get back into, and the two hand-set values are set. Next, [Prove a restore](@/day-two/prove-a-restore.md) is the drill most people skip.
