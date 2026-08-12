#!/usr/bin/env bash
# OpenCode adapter installer
# Installs fable-method skills into OpenCode's skill directory
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

PROJECT_PATH=""
# Determine install location
if [[ "${1:-}" == "--global" ]]; then
    INSTALL_DIR="$HOME/.config/opencode/skills"
elif [[ "${1:-}" == "--project" ]]; then
    PROJECT_PATH="$2"
    INSTALL_DIR="$PROJECT_PATH/.agent/skills"
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
        if [[ -n "$PROJECT_PATH" ]]; then
            mkdir -p "$PROJECT_PATH/.opencode/skills"
            cp -r "$SKILL_SRC" "$PROJECT_PATH/.opencode/skills/$skill"
        fi
    else
        echo "Warning: $skill not found at $SKILL_SRC"
    fi
done

echo ""
echo "OpenCode skills installed successfully to: $INSTALL_DIR"
echo "Skills trigger automatically via natural language (e.g. 'apply fable-method')."

