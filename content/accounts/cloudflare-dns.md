+++
title = "Cloudflare DNS and the API token"
description = "Put your domain's DNS at Cloudflare, create the scoped token the installer asks for, and check that it works"
weight = 1
+++

At the end of this you will have a domain whose DNS lives at Cloudflare and an API token that can edit that one domain's records. The token is the single value the installer cannot work out for itself, and it is what makes the certificates automatic. Your services get real certificates from Let's Encrypt through a DNS-01 challenge. The challenge proves you own the domain by writing a temporary TXT record and reading it back, so nothing on your machine ever has to listen on the public internet. The same token does a second job after the install: `homelab-configure dns` uses it to create one A record per service name, pointing at the machine's own address.

This release supports Cloudflare and no other DNS provider. If your domain is somewhere else and you would rather not move it, there is no path through the installer today.

## Prerequisites

- A domain name, or about ten dollars a year to register one. Any name will do; nothing in the homelab depends on what it is.
- A Cloudflare account. The free plan does everything here.
- Sign-in access to your current registrar, if the domain is already registered somewhere other than Cloudflare.
- Twenty minutes, plus waiting time if you are moving an existing domain. You can do all of this a day before you install.

## Step 1 — Put the domain's DNS at Cloudflare

Cloudflare has to be answering DNS questions about your domain before a token can do anything with it. There are two routes, and which one you take depends on whether you already own a name.

**If you do not have a domain yet**, register it at Cloudflare and the DNS is already in the right place. Sign in at [dash.cloudflare.com](https://dash.cloudflare.com), open **Domain Registration** in the left sidebar, choose **Register Domains**, search for a name, and pay. A `.com` runs about ten dollars a year and Cloudflare sells at cost. When the purchase finishes, the domain appears in your account with Cloudflare's nameservers already set, and you can go to Step 2.

**If you already own a domain elsewhere**, add it to Cloudflare and then point the registrar at Cloudflare's nameservers. In the dashboard choose **Add a site** (on some layouts it is **Add** then **Existing domain**), type the domain without any `www` in front of it, and pick the **Free** plan. Cloudflare reads the records your current DNS host is publishing and shows you the list it found. Read that list before you go on. If you receive email at this domain, the MX records and any SPF, DKIM or DMARC TXT records have to be in that list, because after the switch Cloudflare is the only thing answering and anything missing stops working. Add by hand whatever the scan missed.

Cloudflare then shows two nameservers, something in the shape of `ara.ns.cloudflare.com` and `rob.ns.cloudflare.com`. The pair is specific to your account, so copy the ones on your screen rather than the ones printed here. Sign in at your registrar, find the nameserver setting (registrars call it **Nameservers**, **DNS**, or **Manage DNS**), replace both entries with Cloudflare's, and save. The registrar's own help pages have the exact clicks, because every registrar puts this in a different place.

The change takes effect somewhere between a few minutes and a day, and most of the time it is under an hour. Cloudflare checks on its own and emails you when the zone goes **Active**; until then the dashboard shows it as **Pending Nameserver Update**. The token you make in the next step will work the moment the zone is active, and not before. If you are in a hurry, create the token now and come back to the check at the end.

## Step 2 — Create the API token

Sign in at [dash.cloudflare.com](https://dash.cloudflare.com), click the profile icon in the top right corner, and choose **My Profile**. In the left sidebar choose **API Tokens**, then **Create Token**.

Cloudflare offers a list of templates. Find **Edit zone DNS** and click **Use template** beside it. The template already carries the one permission the installer needs, `Zone - DNS - Edit`. Do not add others.

Scroll to **Zone Resources** and set the three dropdowns to **Include**, **Specific zone**, and your domain. This is the part that matters for safety: a token scoped to one zone can edit that domain's records and nothing else in your account. Leave **Client IP Address Filtering** empty, because the machine's address will change, and leave **TTL** empty unless you want to rotate the token on a schedule.

Click **Continue to summary**. The summary should read as one line, your domain with DNS edit rights. Click **Create Token**.

Cloudflare now shows the token once and never again. It is about 40 characters of letters, digits, underscores and hyphens, with no spaces and no prefix:

```
v1Qk8s_ExampleTokenNotRealDoNotUse_7bQ3zR4t
```

Copy it somewhere you can paste from. If you lose it before the install, come back here and roll it; there is no way to read it again.

Two mistakes are easy to make on this screen. The **Global API Key**, further down the same API Tokens page, is not what you want; it has full access to your whole account and the installer will reject it. And a token created with **All zones** instead of a specific zone will pass the installer's check but gives away more than it needs to.

## Step 3 — Check the token before you use it

You can prove the token works from any computer with `curl`, before the installer ever sees it. Replace the token and the domain:

```sh
curl -s -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  "https://api.cloudflare.com/client/v4/zones?name=example.com"
```

A working token answers with JSON containing `"success": true` and exactly one entry under `result`, carrying your domain's name and its zone id. An empty `result` array with `"success": true` means the token is valid but cannot see that zone, which sends you back to Step 1. An HTTP 400 or 403 with `"success": false` means the token itself is wrong. The installer makes this same request, so a token that passes here will pass there.

## Step 4 — Paste it into the installer

The installer asks for the token on the **Domain and certificates** screen, under the boxes for your domain and your email address. Fill the domain in first. The check needs it, and the installer will tell you to go back if the domain box is empty.

Paste the token into the Cloudflare token box and press **Save**. The installer writes it as a single line, `CLOUDFLARE_DNS_API_TOKEN=` followed by the token, and encrypts the file before it reaches the installed machine. The installer never puts the token in the answers file, and the token never leaves the machine except to Cloudflare.

The check runs the moment you save. A green line reads:

```
token verified: it can see the zone example.com
```

Use the web form if you can. The machine's console cannot take a paste, and retyping 40 characters without an error is not a good use of an evening. The form is at the address and code printed on the machine's screen, and both screens show the same answers as you fill them in.

## Step 5 — When the check does not pass

The check prints one of four messages when it fails, and each has one cause worth looking at first.

**`set homelab.domain first so the token can be checked against your zone`** means the domain box above is empty. Fill it in and save the token again.

**`Cloudflare rejected the token (401/403)`** means Cloudflare did not accept the value at all. The usual causes are a partial copy, a trailing space, or the Global API Key pasted in place of a token. Create a new token with the **Edit zone DNS** template and paste that.

**`the token works but sees no zone named example.com`** means the token is valid but your account has no active zone by that name. Check the domain for a typo first, then check that the zone is **Active** rather than **Pending** in the Cloudflare dashboard, then check that the token's Zone Resources names this domain and not another one. A domain you registered at Cloudflare but never added as a site will also give this answer.

**`could not reach Cloudflare`** means the machine has no working internet connection. The installer's Welcome screen says whether it has one; if it does not, check the network cable and the switch before anything else.

## Step 6 — Set the token after the install, if you skipped it

**Skip for now** lets the install finish without a token. The machine comes up and every service runs, but Let's Encrypt never issues a certificate, so each address either warns about an untrusted certificate or does not answer at all, and no DNS records are created. Nothing is lost, and the fix is three commands.

Sit at the machine or log in over SSH, and write the token into a file:

```sh
sudo install -m 600 /dev/null /root/dns.env
sudo tee /root/dns.env >/dev/null <<'EOF'
CLOUDFLARE_DNS_API_TOKEN=paste-the-token-here
EOF
```

Then hand it to the configurator, rebuild, and create the DNS records:

```sh
sudo homelab-configure generate --out /root/homelab \
  --secret homelab.acme.credentialsFile=@/root/dns.env
sudo nixos-rebuild switch --flake /root/homelab#YOUR_HOSTNAME
sudo homelab-configure dns /root/homelab
```

The rebuild re-encrypts the secret and restarts the certificate service, which then asks Let's Encrypt for one certificate per service name. Give it a few minutes; a browser warning in the first minutes is expected, though not an hour later. The `dns` command prints the records it created, updated and left alone, and is safe to run again. Delete `/root/dns.env` when the rebuild has finished, because the encrypted copy in the flake is the one that matters from then on.

## Conclusion

You now have a domain whose DNS Cloudflare answers for, and a token that can edit that domain and nothing else. Certificates arrive on the first boot, and the service names point at the machine without you touching a DNS record by hand.

Next, [Answer the questions](@/quick-start/answer-the-questions.md) walks through the rest of the installer's screens. If the install is already done, [DNS and the gate](@/day-two/dns-and-the-gate.md) is the check that the names resolve and that nothing outside your network can reach them. If your chosen kit includes the download stack, [A VPN account for the download client](@/accounts/vpn.md) is the other value you have to fetch from somebody else's website.
