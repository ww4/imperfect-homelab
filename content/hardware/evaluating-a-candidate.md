+++
title = "Evaluating a candidate"
description = "Five stages, ordered so the cheapest one can end it"
weight = 3
+++

A used machine (a library sale, a decommissioned office PC, a hand-me-down) gets five stages, ordered so that the cheapest can end the evaluation. You decide most boxes at the desk, without powering them on. The output is a one-page card in the configuration repository, so the answer does not have to be re-derived when the box turns up in a closet again.

Stage 0 is the desk pass, from the model number alone: look up the CPU family and TDP, RAM slots and maximum, storage ports and bays, PCIe slots by size, NIC chipset, out-of-band management, the vendor's idle-power figure, and the model's known problems (BIOS whitelists, a bad-capacitor era, a proprietary PSU connector). The intake line has to say the form factor, because one model number ships as a tower, a small-form-factor and a tiny with different bays and slots. Match the result against the roles you need; if none fits, stop here and strip it for RAM, drives and fans. Stage 1 is ten minutes with the side off: bulging capacitors, a missing heatsink, a PSU that does not match the board. Stage 2 is a bench boot from a USB stick with the probe script, which inventories everything and runs the gates unattended. Stage 3 is an overnight burn-in, only for a box you are adopting: memory, disks and thermals under load. Stage 4 writes the card: role, name, next steps, or pass.

The reference machine's owner runs stages 0 and 4 through the agent and does 1 to 3 by hand; 2 and 3 are mostly waiting. The probe script and a sample card are in the configuration repository's `docs/hardware/`.
