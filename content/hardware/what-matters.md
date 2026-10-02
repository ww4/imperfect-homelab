+++
title = "What matters"
description = "Ports and bays first, then power, then the NIC; the CPU last"
weight = 2
+++

Count the storage connectivity before anything else: SATA ports, drive bays, M.2 slots, and whether a PCIe slot could take an HBA. All of it is on the spec sheet, and it ends most evaluations. A four-port board with two bays can run the docs-forge profile on a pair of disks and nothing more; the media-box profile wants a system disk plus at least two data disks and a parity disk, each on its own port. Low-profile slots in a small-form-factor case rule out most HBAs.

Power is the real price. At around twelve cents per kilowatt-hour a machine that runs all day costs about a dollar a year for every watt it idles at. A 35 W desktop is $37 a year; a 10 W mini-PC is $10; a $25 salvage tower that idles at 35 W costs more in its first year of electricity than it did to buy. Vendors publish measured figures (Lenovo's IT Eco Declaration, Dell's Product Environmental Datasheet, the ENERGY STAR finder), and those beat any estimate. Score power against the role's duty cycle: a box that is off 23 hours a day costs a few dollars a year however thirsty it is awake, and off-with-wake-on-LAN draws under a watt.

The NIC: one gigabit port is enough for everything in this guide, and an Intel chipset is the one with the fewest surprises. Out-of-band management (IPMI, Intel AMT) is convenient for a box in a closet, and AMT on old Intel boards needs firmware patched past the 2017 vulnerability before you enable it. Two and a half gigabit or ten is only worth paying for if your pool can feed it, which a few USB disks cannot.

The CPU is the last question. Anything from the last decade with four cores runs every profile; transcoding video for remote playback is the one job that wants more, and a GPU or a modern iGPU covers it. RAM wants 16 GB as a floor and 32 GB if the download stack and the photo server are both on.

