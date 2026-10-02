+++
title = "Where it came from"
description = "The reference box, and the site this guide owes its shape to"
weight = 3
+++

The reference box is called gromit and lives in rural Kentucky. It has been rebuilt several times over the years, most recently from scratch on NixOS, and what you install from this guide is a cleaned-up copy of what it runs today. Its configuration, the public half anyway, is the library this site documents. The private half is a values file plus the handful of things that are one household's business.

It started from Perfect Media Server. Alex Kretzschmar's site laid out a way to build a home server from independent disks, a union filesystem, parity, and containers, and explained the reasoning as well as the commands. This machine's first version followed that write-up closely. The storage design here still does: MergerFS over disks that each hold whole files, SnapRAID for parity, and a backup tier separate from the media tier. What changed over the years is that the configuration moved from scripts and hand-edited files into one declarative description, and that an agent took over the routine work.

This guide does the same thing one generation on, and owes the same debt to two podcasts: Self-Hosted, which Alex co-hosts, and Linux Unplugged from Jupiter Broadcasting, which is where NixOS and most of the rest of the stack came from. Perfect Media Server taught the principles and left the build to you; this site gives you the build and then teaches the principles, in that order, because a working machine is a better place to learn from than a blank one.

