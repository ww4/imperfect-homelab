+++
title = "Principles"
description = "Implementations vs values, secrets as paths, importing enables, the network perimeter, GitOps with a rehearsal branch, and the trust model they add up to"
weight = 2
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

Five rules account for the choices in this homelab, and most of the library's files are one of them applied. Implementations live in a public library and the facts about your house live in a flake you own. Secrets enter as file paths, never as values the library knows about. Importing a module is what enables it, and a module reads nothing but its own options. The network is the perimeter, and the applications behind it are not asked to be. And nobody applies a change by hand: a merge deploys it, after a rehearsal if you want one.

Each has a chapter. They are short, and they are worth reading before the Tech stack chapter: the rules came first and the stack had to fit them.

A sixth chapter, [The trust model](@/principles/the-trust-model.md), is what the five add up to when you ask who is allowed to do what without being asked again. Read that one if you are deciding whether to put this on a network you care about.

