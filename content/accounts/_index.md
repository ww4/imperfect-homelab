+++
title = "Accounts and keys"
description = "The things you fetch from somebody else's website: a Cloudflare DNS token, a VPN account for the download stack, and a model provider for the assistant"
weight = 5
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

The installer mints every secret it can. Three it cannot, because they belong to an account somewhere else: the Cloudflare API token that gets your certificates and your DNS records, the WireGuard credentials the download client's tunnel runs on, and the key an assistant uses to reach a model it cannot run here. All three are work you do in a web browser, on somebody else's site, before or during the install.

Each page here is a walkthrough with the clicks in order, the values to copy, and what to do when the installer says the value did not check out. The Cloudflare page applies to every install. The VPN page applies only if the download stack is among your modules, and the model provider page only if you asked for an assistant on a machine with no graphics card of its own. All of them can be done a day ahead, and all of them can be done after the install if you skipped them at the time.
