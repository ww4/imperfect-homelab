#!/usr/bin/env bash
# gen-llms — the whole site as one plain-text file (llms-full.txt), from the
# same markdown the pages are built from: sections in weight order, pages in
# weight order, front matter turned into a heading and a URL. Deterministic;
# the flake's `llms-fresh` check diffs it against the committed copy.
#
#   gen-llms.sh CONTENT_DIR BASE_URL > llms-full.txt
set -euo pipefail
content=$1; base=${2%/}
fm() { awk -v k="$1" 'BEGIN{f=0} /^\+\+\+$/{f++; next} f==1 && $0 ~ "^"k" = " { sub("^"k" = \"?",""); sub("\"$",""); print; exit }' "$2"; }
body() { awk 'BEGIN{f=0} /^\+\+\+$/{f++; next} f>=2 {print}' "$1"; }
weight() { w=$(fm weight "$1"); echo "${w:-999}"; }
printf '# %s\n\n' "$(fm title "$content/_index.md")"
body "$content/_index.md"
# sections by weight
for s in $(for d in "$content"/*/; do [ -f "$d/_index.md" ] && printf '%s %s\n' "$(weight "$d/_index.md")" "$d"; done | sort -n | awk '{print $2}'); do
  name=$(basename "$s")
  printf '\n\n# %s\n\nURL: %s/%s/\n\n' "$(fm title "$s/_index.md")" "$base" "$name"
  body "$s/_index.md"
  for p in $(for f in "$s"/*.md; do [ "$(basename "$f")" = "_index.md" ] && continue; printf '%s %s\n' "$(weight "$f")" "$f"; done | sort -k1,1n -k2,2 | awk '{print $2}'); do
    slug=$(basename "$p" .md)
    printf '\n\n## %s\n\nURL: %s/%s/%s/\n\n' "$(fm title "$p")" "$base" "$name" "$slug"
    body "$p"
  done
done
