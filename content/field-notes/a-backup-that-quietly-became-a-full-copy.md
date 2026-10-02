+++
title = "A backup that quietly became a full copy"
weight = 2
+++

A weekly mirror job used `rsync --link-dest` to hardlink unchanged files against the previous run, so each run should have cost only the changed bytes. On a MergerFS pool with the default create policy, the new run's directory landed on whichever branch had the most free space, and the previous run's files sat on another branch. MergerFS cannot hardlink across branches; it returns `EXDEV`, and rsync handles `EXDEV` by copying the file instead of failing. Every weekly run was a full copy, the pool filled, and the first symptom was a job failing with `ENOSPC` months later.

The rule: `epmfs` (existing path, most free space) on any pool that receives hardlinks, so a new file lands on the branch that already holds its parent directory. It is an option on every pool in the library, and the option's description says why. The same incident set `minfreespace` above the largest single file, because the 4 GiB default let a job fill a branch until a temp file no longer fit.

