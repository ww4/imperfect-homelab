+++
title = "Start here"
description = "What this is, who it is for, and the box it came from"
weight = 1
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

This guide hands you a homelab that one person has run for years, and then shows you how it is built so you can change it. Every service, alert rule and backup job you end up with is a file you can read. The install is one command from the NixOS installer: it asks what you want, mints the secrets, and leaves you with a working machine. The understanding takes longer, and the rest of the site is for that.

Read it in order the first time. Later you will come back for one chapter at a time, and the Services reference is for looking things up.

The reference machine is one household's setup. The Principles chapter gives the reasons for its choices (a MergerFS pool over independent disks, Tailscale as the only way in, nginx in front of everything), and you can make different ones. The install path is tested against three fixed profiles in a virtual machine, and your hardware will differ from the reference box in ways the Hardware chapter tries to anticipate. When something in the guide and something on your screen disagree, the screen is right, and the issue tracker is where to say so.

