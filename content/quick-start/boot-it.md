+++
title = "Boot it"
description = "Start the PC from the stick, not from its own disk"
weight = 3
+++

Plug the stick into the PC you are giving up, plug in the network cable, and turn it on. The PC will try to start whatever is on its disk; you want it to start from the stick instead, and the way to ask is a key pressed right after power-on.

Tap the boot-menu key repeatedly as soon as the machine's logo appears. Which key depends on who made the machine or its motherboard: F12 on Dell, Lenovo and Acer, F11 on MSI, F8 on ASUS, Esc on HP. A menu appears listing drives; pick the entry that names your USB stick, preferring one that starts with "UEFI". If no menu comes and Windows starts, turn it off and try again faster; if the key does nothing at all, enter the setup screen instead (Del or F2 at the same moment) and look for a Boot tab where you can put the USB drive first. While you are in setup, find Secure Boot, usually under Boot or Security, and set it to Disabled; the installer will not start with it on.

When it worked, the screen goes through a few seconds of text and ends on a short green message that starts with "Homelab installer"; it waits for the network (if no cable is in, it says so and keeps waiting; plug one in and it carries on), spends about a minute looking for a newer installer on the internet (a stick burned months ago still runs today's installer), and the installer's form opens over it. You are logged in already. Nothing is installed yet; the stick runs in memory and you can turn the PC off at any point before step 4 with no effect.

The network is automatic over a cable. Wi-Fi works but needs typing (`wpa_cli`); a cable is easier, and you can move the machine afterwards.
