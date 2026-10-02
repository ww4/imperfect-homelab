+++
title = "A memory limit that limited nothing"
weight = 3
+++

A container's backend had grown to 3.6 GB of resident memory, the largest process on the box, and the fix seemed obvious: `MemoryMax = "6G"` on its `docker-*.service` unit, the way you cap a native service. It capped nothing. dockerd puts a container's processes in their own cgroup scope under the Docker daemon, not under the systemd unit that started the container, so the unit's limit applies to a cgroup holding only the client process. The limit that works is `--memory=6g` in the container's `extraOptions`, and the proof is `memory.max` in the container's own scope, read from `/sys/fs/cgroup`. The same incident showed that `--memory-swap` did not translate to a swap cap on cgroup v2, so do not cite it as one.

