+++
title = "Imperfect Homelab"
sort_by = "weight"
template = "index.html"
+++

A complete self-hosted homelab — media, photos, documents, a git forge,
single sign-on, monitoring, phone alerts, 3-2-1 backups — that you install
from a public NixOS module library in one pass, and then understand well
enough to add to.

If you have never used Linux, the [Quick start](@/quick-start/_index.md) is
the short road: one evening, click by click, and the Starter kit is running.
The rest of the site is the long road, for when you want to know why.

Three promises:

1. **One command from the installer ISO** answers questions and leaves you
   with a working system, secrets included.
2. **Every line of it is readable.** Implementations live in the library;
   your values live in a flake you own. Nothing is hidden in a container
   you cannot inspect.
3. **You can add the next service yourself**, and the guide shows the loop
   the author's own tooling uses to do it.

## Thanks

This homelab exists because other people wrote theirs down. [Perfect Media Server](https://perfectmediaserver.com) by Alex Kretzschmar is where it started, and the name here is a nod to it: that site taught the shape (independent disks, a union filesystem, parity, one service per container) and the habit of explaining the reasoning. The [Self-Hosted](https://selfhosted.show) podcast and [Linux Unplugged](https://linuxunplugged.com) from Jupiter Broadcasting are the reason the pieces are what they are, from mergerfs to NixOS; years of listening turned into years of running. If anything here is useful to you, it was useful to me first because of them.
