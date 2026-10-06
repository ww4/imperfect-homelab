+++
title = "First look"
description = "Pull the stick, let it boot, open the apps from your other computer and log in"
weight = 5
+++

At the end of this you will have opened the machine's apps from another computer, logged in to the ones that need it, and moved the first-login passwords into your password manager. The install is already done; this is the part where you see it.

## Prerequisites

- The installer saying it has finished, on the machine's screen.
- The password you typed on the Profile screen.
- A password manager, or somewhere else you are willing to keep passwords.

## Step 1 — Reboot and pull the stick

Press **Close**, type `reboot` and press Enter. Pull the stick out as soon as the screen goes dark, so the machine starts from its own disk.

The first boot takes a few minutes longer than later ones, because the machine requests its certificates and starts every service for the first time. Give it five minutes before you judge it.

## Step 2 — Open the first app

On your other computer, open `https://recipes.` followed by your domain, so `https://recipes.example.com`. The other names are the same shape:

| Address | What it is |
|---|---|
| `recipes.<domain>` | Tandoor, the recipe app |
| `jellyfin.<domain>` | Jellyfin, movies and shows |
| `grafana.<domain>` | the monitoring dashboards |
| `ntfy.<domain>` | the alert feed your phone subscribes to |

The install created these names at Cloudflare, pointing at the machine's address on your home network, so they work from any device in the house.

If the browser says the site cannot be reached, wait another minute and reload. If it warns about the certificate, the same answer: the certificate is on its way. A warning an hour later is a real problem, and [When something is wrong](@/quick-start/when-something-is-wrong.md) covers it.

## Step 3 — Create the accounts the apps ask for

Jellyfin and Tandoor ask you to create their first account the first time you visit. Use whatever you like. Those accounts belong to the applications themselves; the machine's own login is separate.

## Step 4 — Read the first-login passwords, then delete the file

The dashboards and the few apps that come with a fixed login have their passwords in a file on the machine. Sit at the machine, log in as `admin` with the password you typed on the Profile screen, and read it:

```sh
sudo cat /root/homelab/FIRST-LOGIN.md
```

Copy what you need into a password manager. Once it is there, the file can go:

```sh
sudo rm /root/homelab/FIRST-LOGIN.md
```

## Step 5 — Put the alerts on your phone

Install the ntfy app on your phone, point it at your `ntfy.` address, and log in with the subscriber account from `FIRST-LOGIN.md`. Alerts from the machine arrive there from then on. [The phone](@/day-two/the-phone.md) has the step where you cause one on purpose to prove it works.

## Conclusion

Tandoor is usable straight away: paste a recipe URL and it imports the recipe. Jellyfin needs your video files copied onto the machine before there is anything to watch, and the Starter kit has no file share yet, so that step needs a terminal or a USB drive plugged into the machine for now. The first backup runs by itself at 02:30 tonight.

[Day two](@/day-two/_index.md) is the next chapter: the DNS and gate check, the restore drill, and the first alert. [Start here](@/start-here/_index.md) explains what you now have and why it is built the way it is.
