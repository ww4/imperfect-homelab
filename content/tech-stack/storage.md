+++
title = "Storage"
description = "MergerFS over independent disks, SnapRAID parity, and a remounter that knows a zombie mount when it sees one"
weight = 2
+++

The pool is MergerFS over independent disks, each holding whole files. There is no striping: a lost disk costs that disk's contents and nothing else, every surviving disk is readable on its own with any Linux, and disks of different sizes and ages mix freely. That trade suits bulk media but not a database, which is why the services keep their state on the system disk and only their large files on the pool. SnapRAID adds parity on top, so a single failed disk is recoverable file by file.

Six mount options took the longest to get right, and the library sets them for every pool. `cache.files=off` keeps the page cache coherent across branches. `moveonenospc=true` moves a file to another branch and retries when a write fills the one it started on. `dropcacheonclose=true` keeps a large sequential write from evicting everything else. `func.getattr=newest` makes `stat()` return the newest branch's metadata when a path exists on several, without which two writers holding copies see stale sizes. `minfreespace` is a floor set above your largest single file, so a create never hits end-of-disk mid-write; the reference machine learned that when a mirror job filled a branch until a temp file no longer fit. And the create policy, `mfs` or `epmfs`, decides where new files land.

The create policy is the one to get right. `mfs` (most free space) balances writes across branches and is the right default for a media pool. `epmfs` (existing path, most free space) keeps a new file on the branch that already holds its parent directory, and any pool that receives hardlinks needs it, because MergerFS hardlinks only work within one branch. When they fail, `rsync --link-dest` does not error; it silently copies, and an incremental backup becomes a full one and fills the pool. The reference machine's backup pool runs `epmfs` for exactly that reason. Pick per pool, in the values file.

SnapRAID reads the member disks directly, never through the pool mount, and writes parity to one file per parity disk on a disk outside the pool. The library derives the data disks from the pool's member list, so adding a disk to the pool adds it to parity in the same edit. The first sync is yours to run by hand, because it builds parity from scratch and takes hours.

Disks on USB drop off the bus, and the library's remounter handles the two shapes that takes. In the clean one the mount disappears and a `systemctl start` on the mount unit brings it back. In the other, the filesystem shuts down but the mount entry survives: `/proc/mounts` still lists it, `mountpoint` still says yes, `df` still reports it, and only a real read returns an error. Nothing can mount over that corpse, so a plain restart fails forever. The reference machine once ran 260 failed recovery attempts over nine hours in that state without an alert, because the dashboard rule counted mount entries and the zombie kept the count at full strength.

The remounter now probes with a real directory read, answers "is it mounted" from the kernel's mount table rather than by stat-ing the path (which also fails on a dead filesystem), and treats a slow read as ambiguous. Three rules bound it: it only ever remounts, never repairs; it declares success only after a write test; and it caps itself at a few remounts per drive per day, because a disk that keeps dropping is failing hardware and silently remounting it hides the warning.

