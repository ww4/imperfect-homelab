#!/usr/bin/env bash
# gen-reference — render the Services section from the library's own data.
#
# Inputs: the catalog (nix eval --json <library>#catalog) and the option docs
# (the configurator's optionsJson: every homelab.* option with type, default,
# description). Output: one Zola page per module plus the section index,
# into $3. Deterministic — the flake's `reference-fresh` check diffs this
# against the committed content/services/, so the reference cannot drift
# from the library the way hand-written docs would.
#
#   gen-reference.sh catalog.json options.json OUTDIR
set -euo pipefail
catalog=$1; options=$2; out=$3
mkdir -p "$out"

# Section index: a table of every module, alphabetical.
{
  cat <<'HDR'
+++
title = "Services"
description = "Every module in the library — what it does, what it reads, what it needs"
weight = 7
sort_by = "title"
template = "section.html"
page_template = "page.html"
[extra]
generated = true
+++

One page per module, generated from the library's catalog and option
declarations at the pinned commit. The catalog is checked against the
library's exported modules at evaluation time, and this section is checked
against the catalog, so what you read here is what the code does.

| Module | Purpose | Memory | Enable | Serves |
|---|---|---|---|---|
HDR
  jq -r 'to_entries | sort_by(.key) | .[] | select(.key != "options")
    | "| [\(.key)](@/services/\(.key).md) | \(.value.description) | \(if (.value.memory // 0) == 0 then "—" else (.value.memory|tostring) + " MiB" end) | \(if .value.enable == "import" then "import" else "`" + .value.enable + "`" end) | \(.value.vhosts | map("`" + . + ".<domain>`") | join(", ")) |"' "$catalog"
} > "$out/_index.md"

# One page per module.
jq -r 'to_entries | sort_by(.key) | .[] | select(.key != "options") | .key' "$catalog" | while read -r name; do
  jq -r --arg n "$name" --slurpfile opts "$options" '
    .[$n] as $m
    | ($m.options | map(select(length > 0))) as $prefixes
    | ($opts[0] | map(select(.name as $o | $prefixes | any(. as $p | $o == $p or ($o | startswith($p + "."))))) | sort_by(.name)) as $mine
    | def esc: gsub("\""; "\\\"");
      # Table cells are prose, not markup: escape pipes and angle brackets
      # (an option doc saying "<name>.<domain>" would otherwise open an HTML
      # element the browser never closes, and the table vanishes).
      def cell: gsub("\\|"; "\\|") | gsub("\n+"; " ") | gsub("<"; "&lt;") | gsub(">"; "&gt;");
      # Inside a code span markdown takes < and > literally, so entities would show as text.
      def code: gsub("\n+"; " ");
    "+++",
    "title = \"\($n)\"",
    "description = \"\($m.description | esc)\"",
    "[extra]",
    "generated = true",
    "+++",
    "",
    $m.description,
    "",
    (if ($m.memory // 0) == 0 then "Memory: no long-running process of its own." else "Memory: about \($m.memory) MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra)." end),
    "",
    "## Enabling it",
    "",
    (if $m.enable == "import" then "Importing `nixosModules.\($n)` enables it; there is no switch."
     else "Import `nixosModules.\($n)` and set `\($m.enable) = true`." end),
    "",
    (if ($m.requires | length) > 0 then
      "**Requires:** " + ($m.requires | map("[\(.)](@/services/\(.).md)") | join(", ")) else empty end),
    (if ($m.vhosts | length) > 0 then
      "**Serves:** " + ($m.vhosts | map("`\(.).<homelab.domain>`") | join(", ")) + " — create the DNS record." else empty end),
    "",
    (if ($m.secrets | length) > 0 then
      "## Secrets",
      "",
      "| Option | File must carry | Read by | Class |",
      "|---|---|---|---|",
      ($m.secrets[] | "| `\(.option)` | \(.keys | map("`" + . + "`") | join(", ")) | `\(.owner)` | \(.source) |"),
      "",
      "Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once."
     else "## Secrets", "", "None." end),
    "",
    "## Options",
    "",
    (if ($mine | length) == 0 then "This module reads no `homelab.*` options."
     else
      ($mine[] |
        "#### `\(.name)`",
        "",
        "`\(.type | code)` — " + (if .hasDefault then "default `" + (.default | code) + "`" else "**required**" end)
          + (if .example then " — example `" + (.example | code) + "`" else "" end),
        "",
        (.description // "" | cell),
        "")
     end)
  ' "$catalog" > "$out/$name.md"
done
echo "gen-reference: $(ls "$out" | wc -l) files -> $out" >&2
