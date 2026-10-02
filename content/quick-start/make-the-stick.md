+++
title = "Make the stick"
description = "Download the installer image, write it with Rufus"
weight = 2
+++

Download two things on your Windows computer: the installer image, which is about 1.5 GB, and Rufus, which writes it to the stick. The image is at `https://homelab-installer.nyc3.cdn.digitaloceanspaces.com/iso/homelab-installer-latest.iso`. Save it anywhere. Rufus is a single program with nothing to install; get `rufus-x.xx.exe` from [rufus.ie](https://rufus.ie) and run it. Plug in the stick.

1. In Rufus, under Device, pick the stick. Check the size; if there is more than one drive listed, pick the one that matches the stick, because Rufus erases whatever you pick.
2. Click SELECT and choose the `.iso` you downloaded.
3. Leave Partition scheme on GPT and Target system on UEFI (non CSM).
4. Click START. Rufus asks how to write the image; choose "Write in DD Image mode" and click OK. It warns that it will erase the device; click OK.
5. Wait for the green READY bar, then click CLOSE.

Eject the stick from the taskbar before you pull it out, the way you would any drive. If Rufus says the image is not bootable or stops with an error, the download is usually incomplete: compare the file size with the number next to the download link, and download it again.
