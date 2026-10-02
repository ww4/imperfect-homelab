+++
title = "Answer the questions"
description = "Seven screens in the configurator, then one command and a wait"
weight = 4
+++

Type `homelab-configure tui` and press Enter. A full-screen form opens with seven tabs along the top. Tab moves to the next screen and Shift-Tab back, the arrow keys move up and down a list, and the last line of the screen always says what the keys do on the screen you are on. You can go back and change anything until the last screen.

**1 Kit.** Move to Starter and press Space. This chooses the modules for you; the box at the bottom lists them. The other kits are for later, when you know what you want.

**2 Host.** Press Enter on a line to edit it, type, press Enter to keep it. Host name: one word, letters and digits, like `homelab`. Admin password: the password you will log in with; pick a good one and write it down, because there is no reset email. Time zone: yours, in the form `America/New_York`. Leave the disk lines alone; the next screen fills them. SSH public key and GitHub user are for people who already use SSH; skip them.

**3 Disks.** The screen lists every drive in the machine. Move to the one the system should go on and press Space until it says SYSTEM. If the machine has a second drive you want for media, press Space on it until it says data. The installer erases everything marked here.

**4 Modules.** Already set by the kit. Look, do not touch.

**5 Values.** The lines at the top, marked with a red `!`, are the required ones: `homelab.domain` is your domain, like `example.com`, with nothing in front of it, and `homelab.acme.email` is your email address. The rest have defaults; leave them.

**6 Secrets.** One line, the Cloudflare token. Press `v` and the screen explains how to create the token at Cloudflare: My Profile, API Tokens, Create Token, the "Edit zone DNS" template, your domain as the one zone. Create it there, type it here (you can type it from the other computer's screen; it is one long string), press Enter. The configurator checks it against your domain at once and says so.

**7 Review.** If you have filled everything, the line is green. Press `g`. The screen fills with text for a minute while the configurator writes and checks the configuration, and ends with a list that starts with "next:"; the first item is the command you want: `sudo homelab-configure install ./my-homelab`.

Type that command and press Enter. It shows the disks it is about to erase and asks you to type the host name to confirm. Type it. Then it partitions the disk, downloads the system, and installs it; on a home connection this is twenty to forty minutes, and the screen scrolls the whole time. It is done when it prints "installed" followed by your host name, the addresses to open, and the login to use.

If it stops with an error instead, read [When something is wrong](@/quick-start/when-something-is-wrong.md). Nothing is lost; the stick is still running, and `homelab-configure tui` opens the form again with your answers in it.
