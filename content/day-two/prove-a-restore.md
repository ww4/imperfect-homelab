+++
title = "Prove a restore"
description = "A backup you have not restored from is a hypothesis"
weight = 3
+++

The first backup runs at 02:30 the night after install. The next morning, before anything else, restore from it.

List the snapshots: `restic -r /mnt/<pool>/restic --password-file /run/secrets/backup-password snapshots` as root. Pick one small path that is in `homelab.backup.paths` and restore it somewhere harmless: `restic -r … restore latest --target /tmp/restore-test --include /var/lib/<something>`. Compare it with the live copy. Then do the same against the offsite repository if you configured one, with its environment file, because an offsite repository you have never read from is the one that will be unreadable when the house is gone. Write down the two commands somewhere that survives the machine, next to the restic passphrase and the admin age key.

The library's `backup` module runs an integrity check after every job and publishes a failed unit if it fails, which the monitoring stack turns into an alert. That proves the repository is consistent. It does not prove you can restore, and only the drill does.

