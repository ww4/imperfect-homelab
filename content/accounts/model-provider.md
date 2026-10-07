+++
title = "A model for the assistant"
description = "Whether this machine needs an account with a model provider, which one to pick, and how to get the key into the installer"
weight = 3
+++

At the end of this the assistant on your machine will have a model to think with. The assistant is the program; the model is what it thinks with, and a model comes from one of two places. A machine with a large enough graphics card runs its own, and then there is nothing to buy and nothing on this page to do. Every other machine rents one by the token from a company, which means an account and an API key. The installer tells you which of the two you have, on the screen that offers the assistant, so read that line first and come back here only if you need to.

## Prerequisites

- A decision that you want an assistant at all. It is optional, nothing else on the machine depends on it, and the installer defaults to no.
- A card for payment, for every provider named here. All of them charge by use rather than by month, and a small household's use is small.
- About ten minutes, in a browser, on any computer.
- The installer open at the assistant screen, or a machine already installed. Either order works.

## Step 1 — Settle whether you need an account at all

The assistant screen in the installer prints one line about this machine's graphics card. If it names a card and says what that card can run, this machine serves its own models and the key box below can stay empty: the assistant is already pointed at the models on the machine. If it says the card is too small, or that it recognises no card, then models have to come from somewhere else and you need an account.

A machine with a capable card can still use an account, and some people do: a local model for everything ordinary, a rented one for the occasional hard question. That is a later decision, made in the assistant's own configuration rather than in the installer, and you do not need to make it now.

## Step 2 — Choose a provider

Hermes talks to anything that speaks OpenAI's API shape, which by now is much of the industry. Your choice is wider than the three below, and every one of them needs the same two values from you: a key and the address to send it to.

**OpenAI** is the one with nothing extra to configure. Its address is the one Hermes assumes, so you supply the key and leave the address box empty.

**OpenRouter** is one account that reaches many companies' models, including Anthropic's and several free ones, and it is the simplest way to try more than one model without opening more than one account. It needs the key and the address `https://openrouter.ai/api/v1`.

**Anthropic** sells access to Claude directly, and its address for OpenAI-shaped clients is `https://api.anthropic.com/v1/`. Read Anthropic's own note on that endpoint before you build on it: the company describes the compatibility layer as intended for testing and comparing models rather than as a long-term solution, and says some features are ignored rather than refused. For Claude models in an assistant you intend to keep using, OpenRouter is the steadier route.

| Provider | Where the key comes from | Address to enter |
|---|---|---|
| OpenAI | platform.openai.com, **API keys** | leave empty |
| OpenRouter | [openrouter.ai/keys](https://openrouter.ai/keys) | `https://openrouter.ai/api/v1` |
| Anthropic | platform.claude.com, **API keys** | `https://api.anthropic.com/v1/` |

## Step 3 — Create the key

Sign in to whichever you chose, find the API keys page, and create one. Name it for the machine rather than for yourself, because the name is how you will know which key to revoke later. Every provider shows the key once. Copy it somewhere you can paste from before you leave the page. If you lose it, delete that key and make another; there is no way to read an existing one back.

A key is a long string of letters, digits and dashes with no spaces in it. Do not copy a surrounding quotation mark, and do not copy the word before it. A key that arrives with a stray character fails in a way the error message does not explain.

## Step 4 — Give it to the installer

The installer asks for this on the assistant screen, step 7 of 9. Answer **Yes, set one up**, and a credentials line appears underneath; press Enter on it to open the form. The form has two boxes. Put the key in **API key**. Put the address in **Provider address**, or leave that box empty for OpenAI. Press **Save**.

The browser encrypts what you type before it sends it, and the installer prints the key fingerprint on the machine's own screen so you can check that the two agree. It reaches the installed machine as an encrypted file and never appears in the answers file.

**Skip** leaves the credential unset and the install carries on. Nothing else changes: the rest of the machine installs and works the same.

## Step 5 — Put a limit on it

A key with no limit on it can run up a bill while you are asleep. Every provider named here has a page for this, usually under **Billing** or **Limits**, where you set a monthly maximum and an address to warn. Set one now. An assistant left running against a large document or a long task uses more than a conversation does, and the point of the limit is that you find out from an email rather than from a statement.

## Step 6 — Talk to it after the first boot

The assistant has no web address, on purpose. It runs in a container with one directory of its own, the installer gives it no name under your domain, and nothing on your network can reach it. You talk to it by sitting at the machine or logging in over SSH:

```sh
sudo docker exec -it hermes-agent hermes
```

If you skipped the key, this first conversation is where it asks for one. If you supplied it, it is already there.

Everything the assistant keeps lives in `/var/lib/hermes`, and that directory is the whole of what it can see. Giving it more is a deliberate edit to `homelab.hermes.extraMounts` in your flake, one line per thing, read-only unless it needs to write. Read the [hermes-agent](@/services/hermes-agent.md) reference page before you add the first one: this is a program whose job is to run code and act on what it finds, and the directory list is the whole of the fence around it.

If the machine has a capable card, you also have `chat.<your domain>`, a browser chat window against the models running locally. That is a different thing from the assistant and it needs no key at all.

## Step 7 — Set or change the key later

Skipping the key at install time costs nothing, and the same two commands set it afterwards or replace it when you roll it. Sit at the machine or log in over SSH, and write the file:

```sh
sudo install -m 600 /dev/null /root/hermes.env
sudo tee /root/hermes.env >/dev/null <<'EOF'
OPENAI_API_KEY=paste-the-key-here
OPENAI_BASE_URL=https://openrouter.ai/api/v1
EOF
```

Leave the `OPENAI_BASE_URL` line out entirely for OpenAI. Then hand the file to the configurator and rebuild:

```sh
sudo homelab-configure generate --out /root/homelab \
  --secret homelab.hermes.environmentFile=@/root/hermes.env
sudo nixos-rebuild switch --flake /root/homelab#YOUR_HOSTNAME
```

Delete `/root/hermes.env` once the rebuild has finished; the encrypted copy inside the flake is the one the machine reads from then on.

## Conclusion

What the assistant can see is still one directory, and that is the setting to look at next. The [hermes-agent](@/services/hermes-agent.md) reference page lists every option the module reads. If your machine runs its own models instead, [ollama](@/services/ollama.md) and [open-webui](@/services/open-webui.md) are the two modules behind that, and neither needs an account with anybody.
