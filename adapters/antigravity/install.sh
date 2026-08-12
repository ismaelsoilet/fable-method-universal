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
            INSTALL_DIR="$HOME/.gemini/config/skills"
            shift
            ;;
        --project)
            SCOPE="project"
            PROJECT_DIR="$2"
            INSTALL_DIR="$PROJECT_DIR/.agent/skills"
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
    INSTALL_DIR="$HOME/.gemini/config/skills"
fi

mkdir -p "$INSTALL_DIR"
if [[ "$SCOPE" == "project" && -n "$PROJECT_DIR" ]]; then
    mkdir -p "$PROJECT_DIR/.agents/skills"
fi

# Install each skill
for skill in fable-method fable-loop fable-judge fable-domain; do
    SKILL_SRC="$BUNDLE_DIR/skills/$skill"
    SKILL_DST="$INSTALL_DIR/$skill"
    
    if [[ -d "$SKILL_SRC" ]]; then
        cp -r "$SKILL_SRC" "$SKILL_DST"
        echo "Installed: $skill -> $SKILL_DST"
        if [[ "$SCOPE" == "project" && -n "$PROJECT_DIR" ]]; then
            cp -r "$SKILL_SRC" "$PROJECT_DIR/.agents/skills/$skill"
            echo "Installed (alias): $skill -> $PROJECT_DIR/.agents/skills/$skill"
        fi
    else
        echo "Warning: $skill not found at $SKILL_SRC"
    fi
done

echo ""
echo "Antigravity CLI skills installed ($SCOPE scope) to: $INSTALL_DIR"
echo "Skills trigger automatically via natural language (e.g., 'apply fable-method')."
echo "No '/' command prefix is required."

