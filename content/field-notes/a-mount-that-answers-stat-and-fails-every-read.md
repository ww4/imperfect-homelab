+++
title = "A mount that answers stat() and fails every read"
weight = 1
+++

A USB member disk of the media pool dropped off the bus under load. The filesystem shut itself down, as XFS does, but the mount entry survived: `/proc/mounts` still listed it, `mountpoint` still said yes, `df` still showed its size, and node_exporter kept reporting it present and healthy because `statfs()` returned the cached superblock. Only an actual read returned an error. Nothing could mount over the corpse, so the recovery service's `systemctl start` on the mount unit failed. It failed again every two minutes for nine hours, 260 times, while the dashboard rule that should have paged counted mount entries and saw a full set. Every service with data on that pool was down the whole time.

The rule: a check that can be satisfied by cached metadata is not a check. The library's remounter probes with a real directory read, asks the kernel's mount table whether a path is mounted instead of stat-ing the path, treats a slow read as ambiguous, and publishes its own health metric. If you write your own watcher for anything, ask what it would report during the failure it exists to catch.

