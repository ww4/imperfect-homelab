+++
title = "A VPN account for the download client"
description = "The WireGuard values the download stack needs, from Mullvad or Proton, and what a forwarded port changes"
weight = 2
+++

At the end of this you will have four values written down: a WireGuard private key, an address, a country, and on one of the two providers a switch that asks for a forwarded port. Those are what the installer wants when the download stack is among your modules, and they are the only part of that stack you cannot get from the installer itself.

The download client runs inside the VPN tunnel. qBittorrent shares gluetun's network namespace, so every packet it sends leaves through WireGuard and there is no route around the tunnel for it to fall back to. When the tunnel is down, qBittorrent has no network at all, which is why the credentials are not optional.

## Prerequisites

- A paid account with Mullvad or Proton VPN. Those are the two this page walks through. The installer's provider list has a few more, and `other` lets you name any provider gluetun supports.
- The `arr` module among your chosen modules. Without it the installer never asks for any of this.
- A text editor on the computer you are reading this on, to open the configuration file the provider gives you.
- Nothing to install. Both providers hand over the values from a web page.

## Step 1 — Decide whether you need a forwarded port

A forwarded port is an open door back through the VPN to your download client, and without one you can still connect out to other peers and download at full speed. What you lose is inbound connections: peers cannot start a connection to you, so you upload to fewer of them and seeding is slower. Some private trackers check for a connectable port and will not count your uploads without one.

Mullvad does not offer port forwarding at all. Proton offers it on paid plans through NAT-PMP, and the port it assigns lasts for the length of a session. If seeding ratio matters to you, that difference decides which of the two you want.

## Step 2 — Get the values from Mullvad

Sign in at [mullvad.net](https://mullvad.net) with your account number. Open **WireGuard configuration** under the account page, choose **Linux** as the platform, and generate a key. Pick any country for the server; the one you pick is the country you will type into the installer. Download the configuration file.

Open the downloaded `.conf` in a text editor. The two lines you need are at the top:

```ini
[Interface]
PrivateKey = oK3mExampleKeyNotRealDoNotUseAAAAAAAAAAAAAA=
Address = 10.64.0.2/32,fc00:bbbb:bbbb:bb01::1:0/128
```

The private key is everything after `PrivateKey = `, and it ends in `=`. The address is everything after `Address = `, and you keep the `/32` on it. If the line carries an IPv6 address after a comma, keep the whole line as it is. Mullvad has no port forwarding, so there is no port to write down.

## Step 3 — Get the values from Proton VPN

Sign in at [account.protonvpn.com](https://account.protonvpn.com) and open **Downloads**, then **WireGuard configuration**. Choose **GNU/Linux** as the platform and give the key a name you will recognise later, such as `homelab`.

Before you create the key, turn on **NAT-PMP (Port Forwarding)**, and choose a server from the **P2P** list. Both of those are settings on the same screen, and you need both: the free tier has no P2P servers and no port forwarding, so this step wants a paid plan. Click **Create** and download the file.

The two lines you need are the same two:

```ini
[Interface]
PrivateKey = yH7pExampleKeyNotRealDoNotUseBBBBBBBBBBBBBB=
Address = 10.2.0.2/32
```

Write down the country the server you picked is in, as a single word such as `Netherlands` or `Switzerland`.

## Step 4 — Fill the values in at the installer

The installer asks for these on the Secrets screen, and the first box is the provider. Choose the provider before anything else, because the boxes below change to the values that provider needs.

| Box | What goes in it | Where it came from |
|---|---|---|
| VPN provider | `mullvad` or `protonvpn` | your account |
| WireGuard private key | the key, without `PrivateKey = ` | the `.conf` from Step 2 or 3 |
| WireGuard address | the address, keeping the `/32` | the same file |
| Server country | one country name, such as `Netherlands` | the server you chose |
| Port forwarding | `on`, Proton only | Step 1 |
| Forwarded port | a port number, only if your provider gives a fixed one | your provider |

The installer writes these as `KEY=value` lines and encrypts the file before it reaches the installed machine, and the values never enter the answers file. Use the web form if you can: a WireGuard key is 44 characters you do not want to retype.

Nothing checks these values the way the installer checks the Cloudflare token, because neither provider publishes an API for it. A typo shows up after the install as a tunnel that never comes up, so read the two long values back before you move on.

## Step 5 — Match qBittorrent's listen port, if you have a fixed one

Skip this step on Mullvad and on Proton. It applies to a provider that hands you a permanent port number.

Type that number into the **Forwarded port** box in Step 4, which the installer passes to gluetun as `FIREWALL_VPN_INPUT_PORTS`, and then set the same number inside qBittorrent after the install: **Tools**, **Options**, **Connection**, **Port used for incoming connections**. The two have to agree. Gluetun opens the firewall for the port you gave the installer, and qBittorrent listens on the port you set in its own options, so a mismatch leaves you with the slow seeding of Step 1 while everything looks configured.

Proton's port changes with each session, so there is no number to type ahead of time. Gluetun requests one and opens the firewall for it, and this release does not push that number into qBittorrent's own setting. To find the current one, read the gluetun log on the machine:

```sh
sudo journalctl -u docker-gluetun | grep -i "port forward" | tail -5
```

## Step 6 — Check it after the first boot

Open `qbittorrent.` followed by your domain. The status bar at the bottom of the window says whether qBittorrent is connected. A globe icon marked **Firewalled** means it is working but has no inbound port, which is the expected state on Mullvad.

If the page does not load at all, the tunnel is the first thing to look at:

```sh
systemctl status docker-gluetun
sudo journalctl -u docker-gluetun -n 50
```

An authentication failure in that log means the private key or the address is wrong, and the fix is Step 7 with the values read again from the provider's file.

## Step 7 — Set the credentials later, if you skipped them

**Skip for now** on the Secrets screen lets the install finish. The download client stays off until you set the VPN credentials, and everything else on the machine runs normally. To set it afterwards, write the file on the installed machine:

```sh
sudo install -m 600 /dev/null /root/vpn.env
sudo tee /root/vpn.env >/dev/null <<'EOF'
WIREGUARD_PRIVATE_KEY=paste-the-key-here
WIREGUARD_ADDRESSES=10.64.0.2/32
SERVER_COUNTRIES=Netherlands
EOF
```

Add `VPN_PORT_FORWARDING=on` to that file on Proton, or `FIREWALL_VPN_INPUT_PORTS=` and the number on a provider with a fixed port. Then hand it to the configurator and rebuild:

```sh
sudo homelab-configure generate --out /root/homelab \
  --secret homelab.arrStack.vpnEnvFile=@/root/vpn.env
sudo nixos-rebuild switch --flake /root/homelab#YOUR_HOSTNAME
```

Delete `/root/vpn.env` once the rebuild has finished; the encrypted copy inside the flake is the one the machine reads from then on. The same two commands replace the credentials when you change provider or roll a key.

## Conclusion

The download stack now has a tunnel it cannot leak around, and you know which of your two options gives you an inbound port. What remains is inside the applications: [First logins](@/day-two/first-logins.md) covers telling Sonarr and Radarr about the download client, which is one of the two things the installer cannot do for you.

If you have not set up DNS yet, [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) is the other value the installer asks you to fetch from somebody else's website. The [arr](@/services/arr.md) reference page lists every option this module reads.
