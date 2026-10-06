+++
title = "Operating with an agent"
description = "A scoped AI operator: its own user, a root-owned guard, PR-only changes, a rehearsal branch"
weight = 10
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

An AI agent runs on the reference machine as its own user and does the routine work: wiring a new service, extending the monitoring, moving configuration into the library, keeping the documentation current. It cannot apply anything. Its normal output is a pull request, and a human merging that pull request is what changes the machine. Every gate it meets on the way is mechanical, enforced by file permissions and branch protection rather than by instructions it is asked to follow.

The design question is the one you face with a new hire. A language model can write NixOS modules, so the question is how much access the work needs and what happens on the day it is confidently wrong. The answer here is the one you would give a careful junior engineer with no production access: read everything, propose anything, apply nothing. The chapters that follow are that access model. Read them before you give an agent a shell on anything you care about.

