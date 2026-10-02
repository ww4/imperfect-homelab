+++
title = "Before you begin"
description = "A spare PC, a USB stick, another computer, a domain, and an evening"
weight = 1
+++

You need five things, and the domain is the only one that costs money. Gather them before you start, because the middle of the install is a bad time to discover the stick is too small.

- A PC you can give up. Step 4 erases its disk. Anything from the last ten years works if it has 8 GB of memory or more; the Starter kit uses about 3 GB of that, and the installer adds up whatever you pick and tells you if the machine is short. It needs a wired network connection to your router for the install.
- A USB stick of 4 GB or more; step 2 erases it.
- The computer you are reading this on, for making the stick and later for using the apps.
- A domain name at Cloudflare. See below.
- An email address, which the certificate authority wants.

The PC is the one piece people hesitate over. An old gaming machine, a retired office desktop, a mini PC from a marketplace: any of them. A second disk inside it is nice for media but not required for the Starter kit, which lives on the one disk. If the machine has a disk you want to keep, take it out before you start; the installer erases every disk you point it at and nothing else, but taking the disk out removes the chance of a mistake.

The domain is how the apps get names like `recipes.yourdomain.com` and real certificates, so your browser does not warn you every time. For this alpha release the installer only knows how to do that through Cloudflare's DNS. If you have no domain, register one at Cloudflare: sign in at dash.cloudflare.com, open Domain Registration, search a name, pay about ten dollars a year, and the DNS is already there. If you own a domain somewhere else, add it to a free Cloudflare account (Add a site, Free plan) and change the nameservers at your registrar to the two Cloudflare shows you; the registrar's help pages have the clicks for that, and the change takes anywhere from minutes to a day.

Set aside an evening. Most of it is waiting: the stick takes a few minutes to write, and the install downloads two or three gigabytes.
