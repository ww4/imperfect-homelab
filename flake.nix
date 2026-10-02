{
  description = "homelab-guide — the Zola site, plus the Services reference generated from the module library";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  # The library is a flake input so the reference is generated from a PINNED
  # commit: `nix flake update homelab-modules` then `nix run .#gen-reference`
  # is the whole refresh loop.
  inputs.homelab-modules.url = "github:ww4/homelab-modules";

  outputs = { self, nixpkgs, homelab-modules }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;

      # Same extraction the configurator bakes into its binary: a full
      # module-system eval of every library module, options only.
      optionsJson =
        let
          eval = lib.nixosSystem {
            inherit system;
            modules = builtins.attrValues homelab-modules.nixosModules
              ++ [ { nixpkgs.hostPlatform = system; } ];
          };
          docs = lib.optionAttrSetToDocList eval.options.homelab;
          text = v: if builtins.isAttrs v && v ? text then v.text else toString v;
        in builtins.toJSON (map (o: {
          inherit (o) name type;
          description = o.description or null;
          hasDefault = o ? default;
          default = if o ? default then text o.default else null;
          example = if o ? example then text o.example else null;
        }) (builtins.filter (o: (o.visible or true) && !(o.internal or false)) docs));

      catalogJson = pkgs.writeText "catalog.json" (builtins.toJSON homelab-modules.catalog);
      optionsFile = pkgs.writeText "options.json" optionsJson;

      reference = pkgs.runCommand "homelab-guide-reference" { nativeBuildInputs = [ pkgs.jq ]; } ''
        bash ${./tools/gen-reference.sh} ${catalogJson} ${optionsFile} $out
      '';

      # The whole site as one text file for agents (static/llms-full.txt), from
      # the same markdown the pages come from; committed so Pages needs no nix,
      # and checked for freshness like the reference.
      llms = pkgs.runCommand "imperfect-homelab-llms" { } ''
        mkdir -p $out
        bash ${./tools/gen-llms.sh} ${./content} https://ww4.github.io/imperfect-homelab > $out/llms-full.txt
      '';

      site = pkgs.stdenvNoCC.mkDerivation {
        pname = "imperfect-homelab";
        version = if self ? shortRev then self.shortRev else "dirty";
        src = self;
        nativeBuildInputs = [ pkgs.zola ];
        buildPhase = "zola build";
        installPhase = "cp -r public $out";
      };
    in {
      packages.${system} = { inherit site reference; default = site; };

      apps.${system}.gen-reference = {
        type = "app";
        program = toString (pkgs.writeShellScript "gen-reference" ''
          set -euo pipefail
          [ -f config.toml ] || { echo "run from the repo root" >&2; exit 1; }
          rm -rf content/services && mkdir -p content/services
          cp ${reference}/* content/services/
          chmod u+w content/services/*
          echo "content/services regenerated from homelab-modules ${homelab-modules.shortRev or "dirty"}"
        '');
      };

      # `nix flake check`: the committed reference and llms-full.txt must equal
      # the generated ones.
      checks.${system} = {
        reference-fresh = pkgs.runCommand "reference-fresh" { } ''
          if diff -r ${reference} ${self}/content/services; then
            touch $out
          else
            echo "content/services is stale — run: nix run .#gen-reference" >&2; exit 1
          fi
        '';
        llms-fresh = pkgs.runCommand "llms-fresh" { } ''
          if diff ${self}/static/llms-full.txt ${llms}/llms-full.txt; then
            touch $out
          else
            echo "static/llms-full.txt is stale — run: tools/gen-llms.sh content https://ww4.github.io/imperfect-homelab > static/llms-full.txt" >&2; exit 1
          fi
        '';
      };

      devShells.${system}.default = pkgs.mkShell { packages = [ pkgs.zola pkgs.jq ]; };
    };
}
