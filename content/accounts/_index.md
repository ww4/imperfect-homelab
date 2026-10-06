+++
title = "Accounts and keys"
description = "The two things you fetch from somebody else's website: a Cloudflare DNS token and, for the download stack, a VPN account"
weight = 5
sort_by = "weight"
template = "section.html"
page_template = "page.html"
+++

The installer mints every secret it can. Two it cannot, because they belong to an account somewhere else: the Cloudflare API token that gets your certificates and your DNS records, and the WireGuard credentials the download client's tunnel runs on. Both are work you do in a web browser, on somebody else's site, before or during the install.

Each page here is a walkthrough with the clicks in order, the values to copy, and what to do when the installer says the value did not check out. The Cloudflare page applies to every install. The VPN page applies only if the download stack is among your modules. Both can be done a day ahead, and both can be done after the install if you skipped them at the time.
