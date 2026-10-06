+++
title = "Prove a restore"
description = "The drill: list the snapshots, restore one path, compare it, then do the offsite repository too"
weight = 3
+++

At the end of this you will have pulled a real file out of a real snapshot and compared it with the live copy, from both repositories, and you will have the two commands written down somewhere that is not the machine. A backup you have not restored from is a hypothesis, and this is the step people skip.

## Prerequisites

- One night's wait. The first backup runs at 02:30 the night after the install, so do this the next morning.
- Root on the machine.
- The pool name you gave `homelab.backup.local.repository`.
- The offsite repository's environment file, if you configured one.

## Step 1 — List the snapshots

As root:

```sh
restic -r /mnt/<pool>/restic --password-file /run/secrets/backup-password snapshots
```

You should see at least one snapshot with last night's date. No snapshots at all means the job did not run, and `journalctl -u restic-backups-critical-local.service` says why (`critical-local` is the default job name; `homelab.backup.local.name` sets it).

## Step 2 — Restore one path somewhere harmless

Pick one small path that is in `homelab.backup.paths` and restore it to a scratch directory, never over the live copy:

```sh
restic -r /mnt/<pool>/restic --password-file /run/secrets/backup-password \
  restore latest --target /tmp/restore-test --include /var/lib/<something>
```

## Step 3 — Compare it with the live copy

```sh
diff -r /tmp/restore-test/var/lib/<something> /var/lib/<something>
```

A running service writes to its state directory, so expect differences in a database file or a log. What you are checking is that the files are there, the sizes are right, and the content is readable.

## Step 4 — Do the same against the offsite repository

Repeat Steps 1 to 3 against the remote repository, with its environment file sourced so restic has the credentials:

```sh
set -a; . <homelab.backup.remote.environmentFile>; set +a
restic -r <homelab.backup.remote.repository> \
  --password-file /run/secrets/backup-password snapshots
```

An offsite repository you have never read from is the one that will be unreadable on the day the house is gone. The local copy passing tells you nothing about the remote one.

## Step 5 — Write the commands down off the machine

Put the two restore commands somewhere that survives the machine, next to the restic passphrase and the admin age key. On the day you need them, the machine that holds your notes is the machine that is missing.

## Conclusion

You have restored from both repositories and you know the commands work. The `backup` module runs an integrity check after every job and publishes a failed unit when the check fails, which the monitoring stack turns into an alert, so the repository's consistency is watched from here on. Consistency is not the same as a restore, and only the drill proves that one.

Next, [The phone](@/day-two/the-phone.md) is the alert you cause on purpose.
