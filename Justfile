check:
    #! /usr/bin/env bash
    set -euo pipefail

    echo "🧪  Building nix-darwin system for mbp14 …"
    NIXPKGS_ALLOW_UNFREE=1 \
      nix build .#darwinConfigurations.mbp14.system \
        --extra-experimental-features 'nix-command flakes pipe-operators' \
        --impure --show-trace
    echo "✅  Build completed — configuration is valid."

