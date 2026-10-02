+++
title = "Extending"
description = "Write a module: the option contract, the catalog entry, leak-scan, build-vm, the PR"
weight = 7
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

Adding a service to this homelab is one module file, one option group, one catalog entry and one pull request. The module holds the implementation and reads every site fact through `homelab.*`; the catalog entry tells the configurator and this site what the module needs; the pull request carries the proof that the reference machine still builds to the same closure. That loop is the one the agent on the reference machine runs for every change, and this chapter walks it once by hand.

The worked example adds a small web service. The three chapters after it are the parts of the loop you will reuse: the option contract, the proof, and the pull request.

