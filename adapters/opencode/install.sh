#!/usr/bin/env bash
# OpenCode adapter installer
# Installs fable-method skills into OpenCode's skill directory
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Determine install location
if [[ "${1:-}" == "--global" ]]; then
    INSTALL_DIR="$HOME/.config/opencode/skills"
elif [[ "${1:-}" == "--project" ]]; then
    INSTALL_DIR="$2/.opencode/skills"
else
    INSTALL_DIR="$HOME/.config/opencode/skills"
fi

mkdir -p "$INSTALL_DIR"

# Install each skill
for skill in fable-method fable-loop fable-judge fable-domain; do
    SKILL_SRC="$BUNDLE_DIR/skills/$skill"
    SKILL_DST="$INSTALL_DIR/$skill"
    
    if [[ -d "$SKILL_SRC" ]]; then
        cp -r "$SKILL_SRC" "$SKILL_DST"
        echo "Installed: $skill -> $SKILL_DST"
    else
        echo "Warning: $skill not found at $SKILL_SRC"
    fi
done

echo ""
echo "OpenCode skills installed successfully."
echo "Try it: open OpenCode and type /fable-method after any task."
