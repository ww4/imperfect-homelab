+++
title = "Answer the questions"
description = "Nine screens, filled in from your own computer's browser, then it installs by itself"
weight = 4
+++

At the end of this the PC will be installing itself, and you will have answered nine screens to get there. Fill them in from a browser on your own computer rather than at the machine: that browser has a clipboard, and the Cloudflare token is a long line you do not want to retype.

## Prerequisites

- The PC showing the installer's address, code and barcode from [Boot it](@/quick-start/boot-it.md).
- Your domain name and, if you have made one, your Cloudflare API token. [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) is the walkthrough if you have not.
- A password you can keep. There is no reset email on this machine.
- Twenty to forty minutes of downloading after you press Install, on a home connection.

## Step 1 — Open the form from your own computer

Type the address shown on the machine's screen into a browser, or point a phone camera at the barcode. Type the code once when it asks. The code is what keeps anyone else on your network from filling in the form, and [The trust model](@/principles/the-trust-model.md) says what else stands behind it.

Everything below works the same way on the machine's own screen if you would rather stand there. Arrow keys or Tab move between lines, Enter opens a line for typing and Enter again keeps it, and the bottom line says what is wrong when something is. Both screens show the same answers as you go, so you can start in one and finish in the other.

## Step 2 — Welcome

The first screen says what is about to happen and what the machine has: memory, disks, and whether it can reach the internet.

Check the internet line before you go on. If it says the machine cannot reach the internet, the install will fail partway, and the cause is almost always the network cable or the port it is in.

## Step 3 — Choose what the machine should be

Pick **Starter** if you are following this chapter. The number beside each kit is the memory that kit needs, shown green when it fits the machine you are installing on.

The other kits add the media pipeline, the office applications, or everything in the library. You can add any of them later with one command, so there is no reason to over-reach now.

One kit, **AI box**, is offered only on a machine whose graphics card the installer recognises and rates. On every other machine it is shown greyed with the reason beside it, which is usually that the published card list does not know your card. That affects this kit alone; the assistant on [Step 8](#step-8-an-assistant) runs on any machine.

## Step 4 — Storage

This screen lists every disk in the machine except the stick you booted from. Set the disk the system should go on to **SYSTEM**. That disk is erased.

A second disk for your files is set to `data`. The Starter kit does not need one; it lives on the system disk.

Continue refuses to move on until exactly one disk says SYSTEM, which is the guard against installing onto a disk you meant to keep.

## Step 5 — Profile

Four values, and the password is the one to be careful with.

- **Machine name**: one word, such as `homelab`.
- **Admin username**: `admin` is fine.
- **Password**, twice. Write it down before you move on. There is no reset email.
- **Time zone**, in the form `America/New_York`.

## Step 6 — SSH access

This is for reaching the machine from another computer without sitting at it. Type your GitHub username to pull in the public keys on that account, or paste a key.

If you do not know what an SSH key is, press **Continue** twice. The first press warns you that only the machine's own screen will reach it afterwards, and the second accepts that.

## Step 7 — Domain and certificates

Type your domain with nothing in front of it (`example.com`, not `www.example.com`) and your email address. The email goes to Let's Encrypt with the certificate request.

Below them is a box for the Cloudflare API token, with the steps to make one beside it. Paste the token in and press **Save**. The installer checks it against your domain at once: a green line means it works, and a red one says what is wrong.

**Skip for now** leaves the token unset and the install carries on. The machine then comes up with no certificates and no DNS records, so every address either warns or does not answer. [Cloudflare DNS and the API token](@/accounts/cloudflare-dns.md) covers both the token itself and how to set it after the install.

## Step 8 — An assistant

This screen asks whether the machine should run an assistant, and no is the default. An assistant is a program that keeps working between conversations, reads and writes the files you give it, and runs what you ask it to. Nothing else on the machine depends on the answer, so **No, thank you** and **Continue** is a complete answer and costs you nothing later: it is one command and a rebuild to add.

Answering **Yes, set one up** installs Hermes, which is somebody else's open-source work rather than part of this library. You talk to it at the machine or over SSH; it gets no address on your network.

The line under the two choices says what this machine can do about models. A graphics card the installer recognises and rates runs models on the machine itself, and then the assistant is already pointed at them and needs no account anywhere. Any other machine needs an account with a model provider, and a credentials line appears for the key. [A model for the assistant](@/accounts/model-provider.md) is the walkthrough for that, including what to do if you would rather set it up after the install.

## Step 9 — Modules

The kit's list, already ticked. The line at the top repeats how much memory the whole set needs.

Leave it alone unless you know you want something else. Adding a module later is one command and a rebuild.

## Step 10 — Review and install

Everything on one screen, with the disks to be erased in red. Read that red line, then press **Install**.

Nothing is erased yet. Because you are driving this from a browser, the PC's own screen now lists the disks it is about to wipe and waits for an answer. Walk over and press **Y** on the PC, and the install starts. Press **Escape** to refuse it. There is nothing to type in the browser, and nothing about your answer travels: whoever starts an install has stood at the machine. [The trust model](@/principles/the-trust-model.md) has the reasoning.

From here the installer works alone: it writes the configuration and checks it, partitions the disk, downloads the system and installs it. Twenty to forty minutes is normal on a home connection, and both screens show what it is doing line by line. When it finishes it prints the addresses to open and the login to use.

If it stops with an error instead, the form reopens with everything you typed still in it. [When something is wrong](@/quick-start/when-something-is-wrong.md) has the three usual causes.

## Conclusion

The machine is installing itself and needs nothing more from you until it reboots. Next, [First look](@/quick-start/first-look.md) opens the apps from your other computer.
