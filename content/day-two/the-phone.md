+++
title = "The phone"
description = "Subscribe, then cause one alert on purpose"
weight = 4
+++

The `ntfy` module provisioned a subscriber account for you; its password is in `FIRST-LOGIN.md`. Install the ntfy app, point it at your ntfy vhost, log in, and subscribe to the alerts topic. Then cause one alert on purpose: stop a service the monitoring stack watches (`systemctl stop uptime-kuma`, say) and wait for the failed-unit rule. The notification should arrive within the rule's evaluation window with the unit name and the journal command to run. Start the service again and confirm the resolved notification follows.

`homelab.quietHours` sets quiet hours for both Grafana and Alertmanager. If the alert you caused came through at an hour it should not have, change the window in the values file rather than in either UI.
