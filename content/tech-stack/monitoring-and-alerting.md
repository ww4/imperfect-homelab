+++
title = "Monitoring and alerting"
description = "Prometheus, Grafana and Alertmanager, provisioned from configuration down to the quiet hours"
weight = 6
+++

The stack is Prometheus, Grafana and Alertmanager, with the part most setups skip: the library provisions alert rules, contact points, notification policies and mute timings from configuration. A rebuild restores the alert rules and routing along with the daemons. The library ships generic rules (a failed systemd unit, a failed deploy, CPU and NVMe temperatures); your flake adds the site-specific ones through `extraAlertRuleFiles`, which is where rules that name your own exporters belong. Every exporter and watchdog in the library publishes an explicit failure signal when its check fails, never stale data that reads as healthy; the storage chapter has the incident that made that a rule.

Routing is two tiers. Critical alerts page at once, at any hour; everything else holds until morning. Quiet hours are one option (`homelab.quietHours`) rendered into both Grafana and Alertmanager, so the two cannot disagree about when the phone stays silent. Alert descriptions carry the remediation (which journal to read, which unit to check), because the reader is you on a phone at seven in the morning. The reference machine's owner set one rule above the others: nothing network-related wakes anyone, ever, and only fire, flood and electrical faults pierce the quiet hours.

Notifications go to the phone through ntfy, self-hosted. The `ntfy` module runs the server with write-only anonymous access, so any service on the machine can post without a credential, and provisions one subscriber account for the owner's phone. An `alertmanager-ntfy` shim translates Alertmanager's webhook into ntfy messages with priority and a title; both are small, and both are modules because the alternative was a script somebody would forget to reinstall.

