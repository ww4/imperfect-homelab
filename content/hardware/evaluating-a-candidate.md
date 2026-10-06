+++
title = "Evaluating a candidate"
description = "Five stages, ordered so the cheapest one can end it, with a written card at the end"
weight = 3
+++

At the end of this you will have a one-page card saying what a used machine is for, or that it is not worth keeping, reached in under an hour of hands-on time. The stages are ordered so the cheapest can end the evaluation, and most boxes are decided at the desk without being powered on. The card goes in the configuration repository, so the answer does not have to be worked out again when the box turns up in a closet two years later.

## Prerequisites

- The machine's exact model number, and the form factor. One model number ships as a tower, a small-form-factor and a tiny, with different bays and slots, so the intake line has to say which.
- The list of roles you need filled.
- A USB stick with the probe script, for Step 3.

## Step 1 — The desk pass

From the model number alone, look up:

- CPU family and TDP
- RAM slots and the maximum the board takes
- storage ports and drive bays
- PCIe slots, by physical size
- NIC chipset
- out-of-band management
- the vendor's measured idle-power figure
- the model's known problems: BIOS whitelists, a bad-capacitor era, a proprietary PSU connector

Match the result against the roles you need. If none fits, stop here and strip the machine for RAM, drives and fans. Most candidates end at this step, which is the point of putting it first.

## Step 2 — Ten minutes with the side off

Open it and look for bulging capacitors, a missing heatsink, and a PSU that does not match the board. Any one of those ends the evaluation on a machine you did not pay for.

## Step 3 — A bench boot with the probe script

Boot it from a USB stick carrying the probe script. The script inventories the hardware and runs the gates unattended, so this stage is mostly waiting.

## Step 4 — An overnight burn-in

Only for a box you have decided to adopt. Load memory, disks and thermals overnight and read the results in the morning. Like Step 3, it is mostly waiting.

## Step 5 — Write the card

One page: the role, the name you are giving it, the next steps, or a pass. Commit it to the configuration repository next to the others.

## Conclusion

You have a decision and a record of how you reached it. The probe script and a sample card live in the configuration repository's `docs/hardware/`. On the reference machine the agent runs Steps 1 and 5 and a person does 2 through 4, which splits the work along the line between looking things up and having hands on the machine.
