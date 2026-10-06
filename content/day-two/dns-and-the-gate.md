+++
title = "DNS and the gate"
description = "Point the names at the machine, watch the certificates arrive, then prove the gate from outside"
weight = 1
+++

At the end of this every service name will resolve to your machine, each one will have a real certificate, and you will have proved from outside your network that nobody else can reach any of them. The last part is the one check this guide cannot run for you, because it has to come from a device that is not yours.

## Prerequisites

- The machine installed and booted.
- The list of names the generator printed (`jellyfin.<domain>`, `grafana.<domain>`, and so on).
- The machine's tailnet address, or its LAN address if you will only ever use it at home.
- A device that is not on your LAN and not on your tailnet. A phone on mobile data will do.

## Step 1 — Create one record per name

Create an A record for each name, pointing at the machine's address. With the Cloudflare token on the machine, the configurator does it for you, and the command is safe to run again:

```sh
sudo homelab-configure dns /root/homelab
```

It points the names at the address the machine has when it runs, which is the tailnet address once Tailscale has joined, and it prints what it created, updated and left alone. Pass `--ip` to name an address yourself, and `--dry-run` to see the plan without writing anything.

Every record is proxied off. The network gate is the perimeter here, and Cloudflare's proxy would sit outside it.

## Step 2 — Wait for the certificates

ACME issues a certificate per name over DNS-01 on the first boot, which needs the DNS API token you supplied and nothing inbound.

Until a name has one, nginx serves a self-signed placeholder, so a browser warning in the first minutes is expected. A warning an hour later means the token or the zone is wrong, and [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) has the four failure messages and what each one means.

## Step 3 — Prove the gate from outside it

Take a device off your LAN and off your tailnet. If your connection has a public IPv6 address, aim a request at it with a `Host` header naming one of your vhosts:

```sh
curl -sk -o /dev/null -w '%{http_code}\n' \
  -H "Host: jellyfin.example.com" "https://[YOUR-PUBLIC-IPV6]/"
```

The answer must be `403`, from nginx. A login page is a failure and not a partial pass: it means the request reached the application, and only that application's password stands between a stranger and your data.

## Conclusion

The names work, the certificates are real, and the gate holds from the one place that can test it. Next, [First logins](@/day-two/first-logins.md) goes through each application once.
