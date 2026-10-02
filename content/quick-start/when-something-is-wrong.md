+++
title = "When something is wrong"
description = "The three usual cases, and how to hand the problem to an agent"
weight = 6
+++

Three things cover most first-evening trouble, and none of them means you did it wrong. The first is that the machine will not start from the stick: Secure Boot is on, or the boot menu picked the stick's non-UEFI entry. Go back into setup, disable Secure Boot, and pick the entry that starts with UEFI. On a few older machines the stick needs to be in a rear USB port rather than a front one.

The install stopped with an error. Read the last few lines; they say which step failed. "no such device" means the form names a disk that is not there; open the form again and redo the Disks screen. A download error means the network dropped; run the install command again and it starts from the beginning. Anything else, copy the last twenty lines somewhere and move to the last paragraph.

The names do not open. Give the first boot five minutes. Then, on the Windows computer, open a command prompt and type `nslookup recipes.example.com` with your domain; it should answer with an address starting 192.168 or 10. If it answers with nothing, Cloudflare has not got the records: sit at the machine, log in, and run `sudo homelab-configure dns /root/homelab`. If it answers with an address but the page does not open, some home routers refuse public names that point at private addresses ("DNS rebind protection"); the router's settings page has a switch for it, often under DNS or Security. If the machine's address changed, give it a fixed one in the router (a DHCP reservation) and run the `dns` command again.

For anything else, hand the problem to an AI agent. Paste `https://ww4.github.io/imperfect-homelab/llms.txt` into Claude, ChatGPT or whatever you use, say what you were doing and what the screen says, and it will have the whole guide and the installer's commands to work from. If you can give it a way to reach the machine, it can look for itself; the [Operating with an agent](@/agent/_index.md) chapter is about doing that safely.
