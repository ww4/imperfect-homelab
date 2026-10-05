+++
title = "Answer the questions"
description = "Eight screens, one question each, then the install runs by itself"
weight = 4
+++

The installer opens by itself a few seconds after the green welcome text. It is a form with one question per screen: read the paragraph at the top, fill in the lines, move to Continue at the bottom and press Enter. Back goes to the previous screen and keeps what you typed. The arrow keys or Tab move between lines; the one you are on is shown in reverse video with a › in front of it. Enter on a line lets you type; Enter again keeps it, Esc throws it away. When something goes wrong, the bottom line of the screen says what, in red.

**1 Welcome.** Says what is about to happen and what the machine has: memory, disks, and whether it can reach the internet. If it says the internet is not reachable, check the cable before going on.

**2 What should this machine be?** Move to Starter and press Space. The number next to each kit is the memory it needs on this machine, green when it fits.

**3 Storage.** Every disk in the machine is listed except the USB stick you booted from. Move to the one the system should go on and press Space until it says SYSTEM; that disk is erased. If you have a second disk for your files, press Space on it until it says data. Continue refuses until one disk says SYSTEM.

**4 Profile.** The machine's name (one word, like `homelab`), the admin username (`admin` is fine), the password twice, and the time zone in the form `America/New_York`. Write the password down; there is no reset email.

**5 SSH access.** This is for reaching the machine from another computer without sitting at it. If you have a GitHub account with keys on it, type the username on the first line and press Enter; the keys appear in the list below. If you do not know what an SSH key is, press Continue twice: the first press warns you that only the machine's own screen will work, the second accepts that.

**6 Domain and certificates.** Your domain (`example.com`, nothing in front of it) and your email address. Then the Cloudflare token: move to that line and the help box explains where to make it (My Profile, API Tokens, Create Token, the "Edit zone DNS" template, your domain as the one zone). Create it there, press Enter here, type it, press Enter. The installer checks it against your domain at once and shows a green tick or a red reason.

**7 Modules.** The kit's list, already filled in. Look, do not touch. The paragraph at the top repeats the memory verdict.

**8 Review.** Everything on one screen, with the disks that will be erased in red. Move to Install and press Enter.

From here it works on its own: it writes the configuration and checks it, partitions the disk, downloads the system onto it, and installs it. On a home connection that is twenty to forty minutes, and the screen scrolls the whole time. When it finishes, the screen says "installed" with your machine's name, the addresses to open, and the login to use, with a Close button under it. If it stops with an error instead, read [When something is wrong](@/quick-start/when-something-is-wrong.md). You lose nothing: press Close, and `homelab-configure tui` opens the form again with everything you typed still in it.
