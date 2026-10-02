+++
title = "mergerfs-pools"
description = "Assemble homelab.pools into mounted MergerFS pools."
[extra]
generated = true
+++

Assemble homelab.pools into mounted MergerFS pools.

## Enabling it

Importing `nixosModules.mergerfs-pools` enables it; there is no switch.


## Secrets

None.

## Options

#### `homelab.pools`

`attribute set of (submodule)` — default `{ }`

MergerFS pools to assemble. See mergerfs-pools.nix.

#### `homelab.pools.<name>.branches`

`string` — **required** — example `"/mnt/disks/media-*"`

Glob of member-branch mountpoints (mergerfs device string).

#### `homelab.pools.<name>.createPolicy`

`one of "mfs", "epmfs", "ff", "lfs", "rand"` — default `"mfs"`

Where NEW files land. `mfs` (most free space) balances writes. `epmfs` (existing path, most free space) keeps new files on the branch that already holds their parent directory — required if anything hardlinks across the tree (e.g. rsync --link-dest), because mergerfs hardlinks only function within a single branch. 

#### `homelab.pools.<name>.fsname`

`null or string` — default `null`

Optional fsname= shown in df/mount output.

#### `homelab.pools.<name>.memberDir`

`null or string` — default `null` — example `"/mnt/disks"`

Directory the member branches mount under (for the auto-remounter).

#### `homelab.pools.<name>.members`

`list of string` — default `[ ]` — example `[   "D1"   "D2" ]`

Member subdirectory names under memberDir (for the auto-remounter).

#### `homelab.pools.<name>.minFreeSpace`

`null or string` — default `null` — example `"100G"`

Reserve headroom: mergerfs won't place a NEW file on a branch with less than this free. Must exceed your largest single file so a create never hits ENOSPC mid-write — the 4 GiB default once let a mirror job fill a branch until a large temp file no longer fit. Hardlinks and growth of existing files are unaffected (link() co-locates with its target regardless). 

#### `homelab.pools.<name>.mountpoint`

`string` — **required** — example `"/mnt/media"`

Where the pooled filesystem mounts.

