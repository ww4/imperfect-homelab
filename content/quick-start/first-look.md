+++
title = "First look"
description = "Pull the stick, let it boot, open the apps from your other computer"
weight = 5
+++

Type `reboot`, press Enter, and pull the stick out as soon as the screen goes dark. The first boot takes a few minutes longer than later ones, because the machine requests its certificates and starts every service for the first time; give it five minutes before you judge it. The first backup runs by itself at 2:30 that night.

On your other computer, open `https://recipes.` followed by your domain, so `https://recipes.example.com`. Jellyfin is at `jellyfin.`, the monitoring dashboards at `grafana.`, and the alert feed at `ntfy.`, all on your domain. The install created these names at Cloudflare, pointing at the machine's address on your home network, so they work from any device in the house. If the browser says the site cannot be reached, wait another minute and reload; if it warns about the certificate, same answer. Jellyfin and Tandoor ask you to create their first account the first time you visit; use whatever you like, those are separate from the machine. The dashboards and the few apps that come with a fixed login have their passwords in a file on the machine called `FIRST-LOGIN.md`. To read it, sit at the machine, log in as `admin` with the password you typed on the Host screen, and type `sudo cat /root/homelab/FIRST-LOGIN.md`. Copy what you need into a password manager and the file can go.

Tandoor is usable at once: paste a recipe URL and it imports the recipe. Jellyfin needs your video files copied onto the machine before there is anything to watch, and the Starter kit has no file share yet, so for now that step needs a terminal or a USB drive plugged into the machine. Install the ntfy app on your phone, subscribe it to your `ntfy.` address, and alerts will arrive there. When you want more, [Day two](@/day-two/_index.md) is the next chapter. [Start here](@/start-here/_index.md) explains what you now have.
