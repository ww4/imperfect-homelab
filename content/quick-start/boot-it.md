+++
title = "Boot it"
description = "Start the PC from the stick, not from its own disk, and wait for the installer to open"
weight = 3
+++

At the end of this the spare PC will be running the installer out of memory, with an address and a code on screen that let you finish the job from your own computer's browser. Nothing is written to the PC's disk in this step, and you can turn the machine off at any point here with no effect on it.

## Prerequisites

- The stick from [Make the stick](@/quick-start/make-the-stick.md).
- The spare PC, a monitor and a keyboard attached to it.
- A network cable from the PC to your router. Wi-Fi works but has to be typed in with `wpa_cli`, and you can move the machine to Wi-Fi later.

## Step 1 — Start the PC from the stick

Plug the stick into the PC, plug in the network cable, and turn it on. Left alone the PC will start whatever is on its own disk, so you have to ask it for the stick, and the way to ask is a key pressed right after power-on.

Tap the boot-menu key repeatedly as soon as the maker's logo appears. Which key it is depends on who made the machine or its motherboard:

| Maker | Boot menu | Setup |
|---|---|---|
| Dell, Lenovo, Acer | F12 | F2 |
| MSI | F11 | Del |
| ASUS | F8 | Del or F2 |
| HP | Esc, then F9 | Esc, then F10 |

A menu appears listing the drives it can start from. Pick the entry that names your USB stick, preferring one that starts with **UEFI**. If Windows starts instead, turn the PC off and try again, tapping earlier.

## Step 2 — Turn Secure Boot off, if the stick will not start

If the key does nothing, or the stick is not in the menu, go into the setup screen instead (the right-hand column above) and look for a **Boot** tab where you can put the USB drive first in the order.

While you are in there, find **Secure Boot**, usually under **Boot** or **Security**, and set it to **Disabled**. The installer will not start with it on. Save and exit, which is usually F10.

On a few older machines the stick has to be in a rear USB port rather than a front one, because the front ports are wired to a hub the firmware cannot boot from.

## Step 3 — Wait for the installer to come up

The screen runs a few seconds of text and settles on a short green message beginning "Homelab installer". Three things then happen on their own, and the screen says which one it is on.

It waits for the network. With no cable in it says so and keeps waiting; plug one in and it carries on by itself.

It spends about a minute looking for a newer installer on the internet, so a stick burned months ago still runs today's installer.

Then the installer's form opens over the message, showing an address like `http://192.168.1.50:8099`, a short code, and a square barcode.

You are already logged in, and nothing has been written to the PC's disk.

## Conclusion

The PC is running the installer from memory and is waiting for answers. Next, [Answer the questions](@/quick-start/answer-the-questions.md) fills the form in from your own computer, which is the easier place to do it because that browser has a clipboard.
