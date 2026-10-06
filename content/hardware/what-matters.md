+++
title = "What matters"
description = "Ports and bays first, then power, then the NIC; the CPU last"
weight = 2
+++

Count the storage connectivity before anything else: SATA ports, drive bays, M.2 slots, and whether a PCIe slot could take an HBA. All of it is on the spec sheet, and it ends most evaluations. A four-port board with two bays can run the docs-forge profile on a pair of disks and nothing more; the media-box profile wants a system disk plus at least two data disks and a parity disk, each on its own port. Low-profile slots in a small-form-factor case rule out most HBAs.

Power is the real price. At around twelve cents per kilowatt-hour a machine that runs all day costs about a dollar a year for every watt it idles at. A 35 W desktop is $37 a year; a 10 W mini-PC is $10; a $25 salvage tower that idles at 35 W costs more in its first year of electricity than it did to buy. Vendors publish measured figures (Lenovo's IT Eco Declaration, Dell's Product Environmental Datasheet, the ENERGY STAR finder), and those beat any estimate. Score power against the role's duty cycle: a box that is off 23 hours a day costs a few dollars a year however thirsty it is awake, and off-with-wake-on-LAN draws under a watt.

The NIC: one gigabit port is enough for everything in this guide, and an Intel chipset is the one with the fewest surprises. Out-of-band management (IPMI, Intel AMT) is convenient for a box in a closet, and AMT on old Intel boards needs firmware patched past the 2017 vulnerability before you enable it. Two and a half gigabit or ten is only worth paying for if your pool can feed it, which a few USB disks cannot.

Memory is the number to size by, and it is additive. Each module in the Services chapter carries a rough resident figure for household load, the configurator adds them up for whatever you pick, puts a gigabyte under them for the kernel, systemd and the container runtime, and compares the sum with the machine it is running on; a kit that does not fit is marked red before you install anything. The sums today: the Starter kit about 3 GB, the media box about 5 GB, documents and forge about 7 GB, everything about 10 GB, and [Compatibility](@/start-here/compatibility.md) has each one to the megabyte with the arithmetic beside it. Those are steady-state numbers; a transcode, Immich's machine-learning pass or a SnapRAID sync adds a gigabyte or two for as long as it runs, so buy a quarter more than the sum. In practice that means 8 GB for the Starter kit or the media box, and 16 GB if you want everything at once. Memory is also the cheapest upgrade a used desktop takes.

The CPU is the last question. Anything from the last decade with four cores runs every profile; transcoding video for remote playback is the one job that wants more, and a GPU or a modern iGPU covers it. If the download stack and the photo server are both on, 32 GB stops you thinking about memory again.

