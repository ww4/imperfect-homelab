+++
title = "Containers lost DNS when MagicDNS came on"
weight = 6
+++

Turning on Tailscale's MagicDNS for the machine rewrote the resolver that containers inherit. Outbound DNS from inside every container stopped while names inside the tailnet kept resolving, so the box looked fine from a shell and broken from any service that fetched anything. The resolver Tailscale installs answers on an address the Docker bridge cannot reach. The fix on the reference machine is a local resolver on the host that containers can reach, and MagicDNS left off for the server; the symptom to recognise is "works on the host, fails in the container, only for names outside the tailnet".

