# homelab-guide

The guide to the homelab: install it from the public module library
([homelab-modules](https://git.rosemaryacres.com/ww4/homelab-modules)), then
learn how it is built so you can add to it. A Zola site.

**Name.** `homelab-guide` is a working name; the repo, title and `base_url`
rename together when the real one lands.

## Layout

```
content/<section>/      the nine sections, weight-ordered (0 start-here … 9 field-notes)
content/services/       GENERATED — one page per library module (see below)
templates/ static/      Zola theme, no external theme dependency
tools/gen-reference.sh  the generator: catalog.json + options.json → markdown
flake.nix               site package, the generator, and the freshness check
```

## Working on it

```sh
nix develop            # zola + jq
zola serve             # live preview at http://127.0.0.1:1111
nix build              # the site, as Cloudflare Pages will build it
```

## The Services section is generated

`content/services/` is produced from the library at the commit pinned in
`flake.lock` — its catalog (`nix eval .#catalog`) and a module-system
evaluation of every `homelab.*` option. It is committed so the site builds
without nix (Cloudflare Pages runs plain `zola build`), and
`nix flake check` fails if the committed copy differs from what the
generator produces.

To pick up library changes:

```sh
nix flake update homelab-modules
nix run .#gen-reference
git add flake.lock content/services
```

## Publishing

Cloudflare Pages, wired to the GitHub mirror of this repo (the Forgejo repo
is the source of truth; GitHub is a push-mirror). Build command `zola build`,
output `public`, `ZOLA_VERSION` set to the version `nix build` uses.

## License

Text is CC BY-SA 4.0 (see `LICENSE`). The module library it documents is
GPL-3.0 under its own repo.
