+++
title = "backup"
description = "restic snapshots of the irreplaceable small state: a local repo on the pool plus an optional offsite one, same paths and retention; optional SFTP push target for a second machine."
[extra]
generated = true
+++

restic snapshots of the irreplaceable small state: a local repo on the pool plus an optional offsite one, same paths and retention; optional SFTP push target for a second machine.

Memory: about 64 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.backup` enables it; there is no switch.


## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.backup.passwordFile` | `<restic repository passphrase, one line>` | `root` | generate |
| `homelab.backup.remote.environmentFile` | `<backend credentials as restic env vars, e.g. B2_ACCOUNT_ID + B2_ACCOUNT_KEY>` | `root` | supply |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.adminUser`

`string` — default `"admin"`

Username of the human administrator (SSO seed user, etc.).

#### `homelab.backup.checkOpts`

`list of string` — default `[   "--with-cache" ]`

Arguments to `restic check` after each run (structural integrity, using the local cache).

#### `homelab.backup.exclude`

`list of string` — default `[ ]` — example `[   "/var/lib/jellyfin/transcodes"   "/var/lib/jellyfin/cache" ]`

Regenerable subtrees of `paths` (caches, logs, transcode scratch) to leave out.

#### `homelab.backup.keep.daily`

`positive integer, meaning >0` — default `7`

Daily snapshots to keep.

#### `homelab.backup.keep.monthly`

`positive integer, meaning >0` — default `6`

Monthly snapshots to keep.

#### `homelab.backup.keep.weekly`

`positive integer, meaning >0` — default `4`

Weekly snapshots to keep.

#### `homelab.backup.local.enable`

`boolean` — default `true`

Keep a repository on local storage (fast restores; survives the system disk).

#### `homelab.backup.local.name`

`string` — default `"critical-local"`

Job name: the unit is restic-backups-&lt;name&gt;.

#### `homelab.backup.local.onCalendar`

`string` — default `"02:30"`

systemd OnCalendar for the local job (missed runs are caught up).

#### `homelab.backup.local.repository`

`null or string` — default `null` — example `"/mnt/pool/restic"`

Directory of the local repository, normally on a storage pool rather than the system disk.

#### `homelab.backup.local.requiresMountsFor`

`list of string` — default `[ ]` — example `[   "/mnt/pool" ]`

Mountpoints that must be mounted before the local job (and the SFTP-push permission service) may run — so a pool that failed to mount yields a skipped run, not a repository written into the bare mountpoint on the system disk. 

#### `homelab.backup.passwordFile`

`string` — **required** — example `"/run/secrets/restic-password"`

File holding the restic repository passphrase, shared by the local and remote repositories. restic cannot recover a lost passphrase: keep a copy somewhere that is not this machine. 

#### `homelab.backup.paths`

`list of string` — default `[ ]` — example `[   "/var/lib/nextcloud"   "/var/backup/postgresql"   "/home/alice/Documents" ]`

The critical tier: every path whose loss could not be undone. Application state under /var/lib, database dumps, keys, documents. Not bulk media — that is a mirror job, not a restic job. 

#### `homelab.backup.remote.enable`

`boolean` — default `false`

Also push to an offsite repository (survives fire, theft and ransomware).

#### `homelab.backup.remote.environmentFile`

`null or string` — default `null` — example `"/run/secrets/restic-remote-env"`

File of the backend's credentials as restic environment variables (for B2: B2_ACCOUNT_ID and B2_ACCOUNT_KEY; for S3: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY). Null for backends that need none, such as sftp: with a key. 

#### `homelab.backup.remote.name`

`string` — default `"critical-remote"`

Job name: the unit is restic-backups-&lt;name&gt;.

#### `homelab.backup.remote.onCalendar`

`string` — default `"03:00"`

systemd OnCalendar for the remote job (missed runs are caught up).

#### `homelab.backup.remote.repository`

`null or string` — default `null` — example `"b2:my-bucket"`

A restic backend URL: b2:, s3:, azure:, gs:, sftp:, rest:.

#### `homelab.backup.sftpPush.authorizedKeys`

`list of string` — default `[ ]` — example `[   "restrict,command=\"internal-sftp\" ssh-ed25519 AAAA... backup@otherbox" ]`

The pushing machine's public keys. Prefix each with restrict,command="internal-sftp" so the key can do nothing but SFTP, whatever the client asks for. 

#### `homelab.backup.sftpPush.enable`

`boolean` — default `false`

Let a second machine push its own restic snapshots over SFTP into the local repository (one repo for the household). Creates a dedicated system user whose primary group owns the repository. 

#### `homelab.backup.sftpPush.user`

`string` — default `"restic-push"`

Name of the SFTP-only system user the other machine logs in as.

