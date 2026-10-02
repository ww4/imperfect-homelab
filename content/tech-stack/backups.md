+++
title = "Backups"
description = "restic for the critical tier, a mirror for the media tier, and a restore you have actually run"
weight = 8
+++

The backup has three legs. restic to a repository on the local backup pool, for fast restores that survive the system disk. restic to an offsite repository (Backblaze B2 on the reference machine, any restic backend in the library), for fire, theft and ransomware. And a mirror job for bulk media, which does not belong in restic: dedup and encryption buy nothing on terabytes of video, and the prune would take days. The two restic jobs take the same paths, the same passphrase and the same retention, so the repositories are interchangeable at restore time.

The critical tier is a list of paths in your values file: application state under `/var/lib`, database dumps, keys, documents. The restic job dumps each Postgres database separately rather than running `pg_dumpall`, so one failing database cannot break every backup. The local job declares the pool as a required mount, so a pool that failed to mount yields a skipped run instead of a repository written into the bare mountpoint on the system disk. Retention is seven daily, four weekly, six monthly by default, with an integrity check after each run. A second machine can push its own snapshots into the local repository over SFTP; the library creates a dedicated user for it whose primary group owns the repository, because on a MergerFS pool with the kernel's FUSE permission checks, supplementary groups are not honoured and the obvious setup (add the admin to the group) does not work.

Run the restore drill once, before you need it: list the snapshots, restore one small path to a temporary directory, compare. The Day two chapter walks through it. Disaster recovery closes end to end only if you mirror the repository (secrets included) offsite and escrow the decryption key off the machine, so a total loss of the hardware still leaves a path from the mirror to the key to the backup credentials to the data.
