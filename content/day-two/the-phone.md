+++
title = "The phone"
description = "Subscribe the phone to the alert feed, then cause one alert on purpose and watch it clear"
weight = 4
+++

At the end of this your phone will have received a real alert from the machine and the matching all-clear, so you will know the path works before something breaks at three in the morning. The whole drill takes about ten minutes, most of it waiting for a rule to fire.

## Prerequisites

- The ntfy subscriber account from `FIRST-LOGIN.md`. The `ntfy` module provisioned it for you.
- Your ntfy address resolving and holding a real certificate, from [DNS and the gate](@/day-two/dns-and-the-gate.md).
- A phone, and root on the machine.

## Step 1 — Subscribe the phone

Install the ntfy app, point it at your ntfy vhost, and log in with the subscriber account. Subscribe it to the alerts topic.

## Step 2 — Cause an alert on purpose

Stop a service the monitoring stack watches, and leave it stopped:

```sh
sudo systemctl stop uptime-kuma
```

The failed-unit rule picks it up on its next evaluation. The notification carries the unit name and the journal command to run, because the reader of an alert is you on a phone, half awake, with no context.

If nothing arrives after a few evaluation windows, check Alertmanager's own view of the alert before suspecting the phone: the alert either did not fire or did not route, and those are different problems.

## Step 3 — Confirm the all-clear

Start the service again:

```sh
sudo systemctl start uptime-kuma
```

A resolved notification should follow. An alert path that fires but never resolves trains you to ignore it, which is worse than no alert at all.

## Step 4 — Fix the quiet hours if it came at the wrong time

`homelab.quietHours` sets quiet hours for Grafana and Alertmanager from one place. If the alert you caused came through at an hour it should not have, change the window in your values file and rebuild. Changing it in either UI leaves the two disagreeing, and the next rebuild puts it back.

## Conclusion

The machine can reach your phone, and you have seen both halves of the cycle. That closes Day two. [Tech stack](@/tech-stack/_index.md) is where the chapters stop telling you what to do and start explaining why each piece is the one that got picked.
