+++
title = "Deploys stopped for two days and nothing said so"
weight = 8
+++

The deploy daemon on the reference machine polled a GitHub mirror of the configuration, and the token that let the forge push to that mirror expired. Pull requests merged on the forge; the mirror stayed where it was; the daemon saw no change and deployed nothing, correctly, for two days. Every dashboard was green, because a deploy pipeline reading a stale source is healthy by every measure it has.

Two watchdogs came out of it and are in the library: one compares the forge's branch head with the commit the daemon last deployed, and one compares the forge with its mirror. Both alert on drift, and the first measured the real merge-to-deploy latency on its first run. The daemon now polls the forge directly, with the mirror as a fallback.

