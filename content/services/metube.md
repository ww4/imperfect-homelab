+++
title = "metube"
description = "MeTube web GUI for yt-dlp one-off downloads."
[extra]
generated = true
+++

MeTube web GUI for yt-dlp one-off downloads.

Memory: about 192 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.metube` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `metube.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.metube.downloadDir`

`string` — **required** — example `"/mnt/media/youtube/metube"`

Host directory downloads land in (bind-mounted into the container).

#### `homelab.metube.mediaGid`

`signed integer` — default `984`

gid of the `media` group, hardcoded for the same eval-time-null reason as uid: config.users.groups.media.gid is null at eval when the group was created without an explicit gid. 

#### `homelab.metube.uid`

`signed integer` — default `971`

Fixed uid for the metube user. ⚠️ Must be EXPLICIT: an auto-allocated system uid is null at eval time, which makes the container's UID env empty and the container fall back to uid 1000. Also note NixOS refuses to change an existing user's uid — if the user already exists, pin to whatever it was actually allocated. 

