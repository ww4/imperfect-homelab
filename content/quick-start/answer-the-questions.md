+++
title = "Answer the questions"
description = "Eight screens, filled in from your own computer's browser, then it installs by itself"
weight = 4
+++

A minute after the green welcome text, the machine's screen shows an address like `http://192.168.1.50:8099`, a six-character code, and a square barcode. Open that address in a browser on your own computer, or point a phone camera at the barcode, type the code once, and fill the form there. You can paste into it. The machine's own screen cannot take a paste, and the Cloudflare token is a long line you do not want to retype. The code keeps anyone else on your network from using the form.

Everything below works the same way on the machine's screen, if you would rather stand there. The arrow keys or Tab move between lines, Enter opens a line for typing and Enter again keeps it, and the bottom line says what is wrong when something is. Both screens show the same answers as you go, so you can start in one and finish in the other.

**1 Welcome.** What is about to happen, and what the machine has: memory, disks, and whether it can reach the internet. If the internet line says it cannot, check the cable before going on.

**2 What should this machine be?** Pick Starter. The number beside each kit is the memory it needs on this machine, green when it fits.

**3 Storage.** Every disk in the machine except the stick you booted from. Set the one the system should go on to SYSTEM; that disk is erased. A second disk for your files is `data`. Continue refuses until one disk says SYSTEM.

**4 Profile.** The machine's name (one word, like `homelab`), the admin username (`admin` is fine), the password twice, and the time zone in the form `America/New_York`. Write the password down: there is no reset email.

**5 SSH access.** This is for reaching the machine from another computer without sitting at it. Type your GitHub username to pull in the keys on that account, or paste one. If you do not know what an SSH key is, press Continue twice: the first press warns that only the machine's own screen will work, the second accepts it.

**6 Domain and certificates.** Your domain (`example.com`, nothing in front of it) and your email address. Below them is a box for the Cloudflare token, with the steps to make one: dash.cloudflare.com, My Profile, API Tokens, Create Token, the "Edit zone DNS" template, your domain as the one zone. Paste it in, press Save, and the installer checks it against your domain at once: a green line means it works, a red one says what is wrong. **Skip for now** leaves it unset, and the page tells you what will not work until you set it later. [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) has the same steps with the screens described, what each red line means, and how to set the token after the install.

**7 Modules.** The kit's list, already filled in. The line at the top repeats how much memory the set needs.

**8 Review.** Everything on one screen, with the disks to be erased in red. Press Install.

From there it works alone: it writes the configuration and checks it, partitions the disk, downloads the system onto it and installs it. On a home connection that is twenty to forty minutes, and both screens show what it is doing, line by line. When it finishes you get the addresses to open and the login to use.

If it stops with an error instead, read [When something is wrong](@/quick-start/when-something-is-wrong.md). The form reopens with everything you typed still in it.
