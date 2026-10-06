+++
title = "Containers on NixOS"
description = "OCI containers as systemd units, images pinned by digest, and the two gaps between Docker and the NixOS firewall"
weight = 7
+++

Most services here are native NixOS modules, and the ones that are not run as OCI containers declared in Nix (`virtualisation.oci-containers`), which makes each one a systemd unit like everything else. The download stack is the main user: Prowlarr, Sonarr, Radarr, Lidarr, Jellyseerr, and qBittorrent inside a Gluetun VPN namespace. A container's image, environment, volumes and network are in the module; its state is a directory under `/var/lib` that the backup module covers.

Images are pinned by tag and digest, and the digest is what deploys. A bare `:latest` re-pulls on every rebuild, which makes each container a standing supply-chain surface, and the containers sit inside the network gate on the vhosts that opt their bridge range in, so a compromised upstream image would be a LAN-equivalent attacker on those. [The trust model](@/principles/the-trust-model.md) says why that opt-in exists and what turning it off costs. Pinning makes an image update a reviewed change. To bump one deliberately, `skopeo inspect` gives you the new digest and a pull request carries it. The download stack's containers share a user-defined bridge network, because the default Docker bridge does not do DNS between containers and their addresses shuffle on restart. That network is IPv4-only on purpose: the bridge has no IPv6 route, Cloudflare-fronted indexers are dual-stack, and glibc prefers the AAAA answer, so a container picks an address it cannot reach and the connection dies with a message that blames DNS.

Two gaps between Docker and NixOS are worth knowing before you hit them. A `MemoryMax` on a `docker-*.service` unit constrains nothing, because dockerd puts the container's processes in their own cgroup scope; the memory limit goes in the container's `extraOptions` as `--memory`. And NixOS's interface-scoped firewall rules do not see traffic from a bridge network to the host, so a container that needs to reach a host service needs a hole for the `br-+` interfaces on that port.

qBittorrent has no network of its own. It borrows Gluetun's namespace, so every byte it sends leaves through the VPN's WireGuard tunnel and there is no path for it to leak onto. Gluetun publishes qBittorrent's web port, and the one setting you carry across is the VPN's forwarded port, set both in the VPN environment and in qBittorrent's listen port.

