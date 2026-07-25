#!/usr/bin/env bash
# Antigravity CLI adapter installer
# Installs fable-method skills into Antigravity CLI's skill directory
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Determine install location
SCOPE="global"
INSTALL_DIR=""
PROJECT_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            SCOPE="global"
            INSTALL_DIR="$HOME/.gemini/antigravity-cli/skills"
            shift
            ;;
        --project)
            SCOPE="project"
            PROJECT_DIR="$2"
            INSTALL_DIR="$PROJECT_DIR/.agents/skills"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 --global | --project <path>"
            exit 1
            ;;
    esac
done

# Default to global if not specified
if [[ -z "$INSTALL_DIR" ]]; then
    SCOPE="global"
    INSTALL_DIR="$HOME/.gemini/antigravity-cli/skills"
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
echo "Antigravity CLI skills installed ($SCOPE scope) to: $INSTALL_DIR"
echo "Restart Antigravity CLI to trigger skill re-scan."
echo "Try it: open Antigravity CLI and type /fable-method after any task."
