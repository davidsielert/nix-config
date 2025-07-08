# ⚙️  The hostname you pass to the flake’s darwin configuration.
#     If you rename your machine-specific directory (hosts/<name>),
#     change this to match.

# Extra opts we have to sprinkle on plain `nix` invocations
# because we’re using flakes everywhere.
FEATURES       := "nix-command flakes pipe-operators"

# ---------------------------------------------------------------------------
# Core build / deploy flows
# ---------------------------------------------------------------------------

# Build the full system but don’t activate it.
build:
    #! /usr/bin/env bash
    set -euo pipefail
    echo "🧪  Building nix-darwin system for ${HOSTNAME} …"
    sudo  nix build .#darwinConfigurations.${HOSTNAME}.system --extra-experimental-features '{{FEATURES}}' --show-trace
    echo "✅  Build completed — configuration is valid."


# Build *and* switch to it right away.
switch:
    darwin-rebuild switch --flake .#${HOSTNAME}

# Re-build against the current lockfile, keeping the running system intact.
rebuild:
    darwin-rebuild rebuild --flake .#${HOSTNAME}

# Quickly roll back to the previous darwin generation.
rollback:
    darwin-rebuild rollback
# ---------------------------------------------------------------------------
# Development helpers
# ---------------------------------------------------------------------------

# Flake checks (eval + tests); add `--show-trace` if you hit an eval error.
check:
    nix flake check --extra-experimental-features '{{FEATURES}}'
dev:
    nix develop --extra-experimental-features '{{FEATURES}}'
# Format Nix files.  Pick the formatter you like (alejandra, nixfmt, etc.).
fmt:
    alejandra .

# Lint (deadnix = finds unused attrs; statix = style / foot-guns).
lint:
    deadnix
    statix check .
