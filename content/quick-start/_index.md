+++
title = "Quick start"
description = "One evening, no Linux: a movie server, a recipe app, backups and alerts on a spare PC"
weight = 0
sort_by = "weight"
+++

This is the short road. With a spare PC, a USB stick and a domain name, you can have the Starter kit running in an evening: a movie and TV server (Jellyfin), a recipe app (Tandoor), nightly backups, and monitoring that sends alerts to your phone. You do not need to know Linux. The installer asks its questions on screen, this guide tells you what to answer, and when it says it is done, it is.

Six steps, each on its own page, each with the exact clicks and keys. The pages assume Windows on the computer you are reading this on, because that is what most people have; the steps on the PC you are installing to are the same for everyone, and if a step does not match what you see, the page says what to check, and the Field notes chapter has the rest.

This alpha release supports one DNS provider, Cloudflare, because that is the simplest way to get certificates for a machine on a home network; a local-only setup without a domain is planned but not built. [Compatibility](@/start-here/compatibility.md) lists the rest of what this release does and does not support. The installer wipes the PC you install on. Everything else is reversible.

1. [Before you begin](@/quick-start/before-you-begin.md): the five things you need.
2. [Make the stick](@/quick-start/make-the-stick.md): put the installer on a USB stick with Rufus.
3. [Boot it](@/quick-start/boot-it.md): start the PC from the stick.
4. [Answer the questions](@/quick-start/answer-the-questions.md): eight screens in your own browser, then it installs by itself.
5. [First look](@/quick-start/first-look.md): open it from your other computer and log in.
6. [When something is wrong](@/quick-start/when-something-is-wrong.md): the usual three, and how to get help.
