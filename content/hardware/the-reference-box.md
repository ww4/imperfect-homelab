+++
title = "The reference box"
description = "A 2014 desktop, one NVMe, six SATA drives, six USB drives, and what each is for"
weight = 1
+++

The reference machine is an Intel i5-4690K, four cores from 2014, with 30 GB of RAM. The system disk is a 500 GB NVMe, which holds the OS, every service's state under `/var/lib`, and the databases; nothing on it is bulk media. Six SATA drives sit inside the case and six more hang off USB in external enclosures, and together they make the two pools: a working pool of six disks for media and service files, around 28 TB, and a backup pool of four 6 TB disks that receives the restic repository and the media mirror. A separate scratch disk holds the download client's incomplete files, kept off the pool to spare its I/O.

That mix is what accumulated; do not read it as a recommendation. The USB enclosures are the weak part, and the library's auto-remounter and the drive-temperature exporter exist because of them: the enclosures drop off the bus under load, misreport power state, and one model needs a cold power cycle to clear an over-current fault. If you are buying, put the data disks on SATA or an HBA and keep USB for the backup pool, where a dropped disk only costs a retry. Twelve spinning drives are the largest line in its power draw, which is why the backup pool's disks spin down between jobs.

The fleet has two more hosts: a compute node (a Ryzen 9 5900X with a GPU) that does Nix builds and the photo server's machine learning, and a laptop. The guide's profiles need neither; they are where heavy compute went so the storage box could stay boring.

