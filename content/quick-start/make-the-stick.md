+++
title = "Make the stick"
description = "Download the installer image, check it, and write it to a USB stick with Rufus"
weight = 2
+++

At the end of this you will have a USB stick that the spare PC can boot from. Two downloads go into it: the installer image, which is about 1.5 GB, and Rufus, a single Windows program that writes the image to the stick. Neither needs installing and neither touches the computer you are reading this on, beyond the files in your Downloads folder.

## Prerequisites

- A Windows computer with a free USB port. The steps below name Rufus, which is Windows only; on macOS or Linux, use Etcher or `dd` and come back at Step 5.
- A USB stick of 4 GB or more. Step 4 erases it.
- About fifteen minutes, most of it the download.

## Step 1 — Download the installer image

The current image is always at this address, which redirects to the newest build:

```
https://github.com/ww4/homelab-modules/releases/latest/download/homelab-installer.iso
```

Save it anywhere you can find it again. The file is about 1.5 GB, so on a slow connection start it now and read on while it runs.

## Step 2 — Check that the download is whole

A partial download is the most common reason Rufus refuses an image, and the check takes a few seconds. Download the checksum from the same address with `.sha256` on the end, then open a Command Prompt in the folder holding the `.iso` and run:

```
certutil -hashfile homelab-installer.iso SHA256
```

The long number it prints should match the number in the `.sha256` file. If it does not, download the image again.

## Step 3 — Get Rufus

Rufus is one `.exe` with nothing to install. Download `rufus-x.xx.exe` from [rufus.ie](https://rufus.ie) and run it. Windows may ask whether to allow it to make changes; it needs that to write to a drive.

Plug the stick in now, so Rufus sees it when it starts.

## Step 4 — Write the image to the stick

Rufus erases whatever drive you point it at, so the first field is the one to be careful with.

1. Under **Device**, pick the stick. Check the size against the stick in your hand. If more than one drive is listed, pick the one that matches.
2. Click **SELECT** and choose the `.iso` you downloaded.
3. Leave **Partition scheme** on **GPT** and **Target system** on **UEFI (non CSM)**.
4. Click **START**. Rufus asks how to write the image: choose **Write in DD Image mode** and click **OK**.
5. Rufus warns that it will erase the device. Click **OK**.
6. Wait for the green **READY** bar, then click **CLOSE**.

Writing takes a few minutes. The progress bar stalls near the end while Windows flushes its cache, which is normal.

## Step 5 — Eject the stick

Eject the stick from the taskbar before you pull it out, the way you would any drive. Pulling it early can leave the last few megabytes unwritten, and a stick in that state boots partway and then stops.

If Rufus said the image is not bootable, or stopped with an error, the download was incomplete. Compare the file size with the number next to the download link, redo Step 2, and write it again.

## Conclusion

You have a bootable installer on a stick, and nothing on your own computer has changed. Next, [Boot it](@/quick-start/boot-it.md) starts the spare PC from the stick.
