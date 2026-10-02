+++
title = "Homelab Guide"
sort_by = "weight"
template = "index.html"
+++

A complete self-hosted homelab — media, photos, documents, a git forge,
single sign-on, monitoring, phone alerts, 3-2-1 backups — that you install
from a public NixOS module library in one pass, and then understand well
enough to add to.

Three promises:

1. **One command from the installer ISO** answers questions and leaves you
   with a working system, secrets included.
2. **Every line of it is readable.** Implementations live in the library;
   your values live in a flake you own. Nothing is hidden in a container
   you cannot inspect.
3. **You can add the next service yourself**, and the guide shows the loop
   the author's own tooling uses to do it.
