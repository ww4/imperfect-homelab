+++
title = "An empty result has two causes"
weight = 9
+++

An empty answer means "nothing there" or "the lookup failed", and the two look identical unless the tool distinguishes them. The reference machine's operator (the agent, in this case) twice reported a monitoring gap that did not exist, because a `journalctl --since` with a rejected time expression printed nothing and was read as "no entries". A forge API call made with an empty token succeeded with only the public repositories and was read as "those repositories do not exist", three separate times. A `curl` with `|| echo 000` behind a status-code check turned a dead port into a success.

When you write a check, write down what it prints when the lookup itself fails. The reference machine's tooling now holds that rule: a tool that queries something refuses to run with an empty credential, checks the command's own exit status before parsing its output, and treats a result shorter than expected as a reason to prove the query worked before concluding anything is absent.
