+++
title = "snapraid"
description = "SnapRAID parity for a MergerFS pool's member disks: nightly sync, weekly partial scrub; any one member recoverable per parity disk."
[extra]
generated = true
+++

SnapRAID parity for a MergerFS pool's member disks: nightly sync, weekly partial scrub; any one member recoverable per parity disk.

Memory: about 64 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Import `nixosModules.snapraid` and set `homelab.snapraid.enable = true`.

**Requires:** [mergerfs-pools](@/services/mergerfs-pools.md)

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

#### `homelab.snapraid.contentDir`

`string` — default `"/var/lib/snapraid"`

Persistent local directory for a copy of the content (database) file; every data disk also carries one.

#### `homelab.snapraid.enable`

`boolean` — default `false`

Parity-protect a MergerFS pool's member disks with SnapRAID. Off by default on purpose: the first sync is a manual, hours-long step after the parity disk is mounted (see the module header). 

#### `homelab.snapraid.exclude`

`list of string` — default `[   "*.unrecoverable"   "/tmp/"   "lost+found/"   ".pool-member" ]`

Patterns SnapRAID skips (the pool-member sentinel the auto-remounter writes is here by default).

#### `homelab.snapraid.extraExclude`

`list of string` — default `[ ]` — example `[   "/downloads/incomplete/" ]`

Site-specific patterns appended to `exclude` — transient download scratch, caches.

#### `homelab.snapraid.parityFiles`

`list of string` — default `[ ]` — example `[   "/mnt/parity1/snapraid.parity" ]`

One parity file per parity disk, each on a disk that is NOT a pool member and at least as large as the largest member. One file = any one member recoverable; two = any two. 

#### `homelab.snapraid.pool`

`string` — default `"media"` — example `"media"`

Name of the homelab.pools entry whose memberDir + members are the data disks.

#### `homelab.snapraid.scrub.interval`

`string` — default `"Mon *-*-* 05:00:00"`

OnCalendar for `snapraid scrub`.

#### `homelab.snapraid.scrub.olderThan`

`unsigned integer, meaning >=0` — default `10`

Skip blocks scrubbed within this many days.

#### `homelab.snapraid.scrub.plan`

`integer between 0 and 100 (both inclusive)` — default `12`

Percent of the array verified per scrub run.

#### `homelab.snapraid.sync.interval`

`string` — default `"*-*-* 04:00:00"`

OnCalendar for `snapraid sync` (a no-op when nothing changed; keep it clear of mirror jobs).

#### `homelab.snapraid.touchBeforeSync`

`boolean` — default `true`

Run `snapraid touch` first so files with zero sub-second timestamps get unique ones (SnapRAID's own recommendation).

