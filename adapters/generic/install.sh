#!/usr/bin/env bash
# Generic adapter installer
# Installs fable-method as AGENTS.md for any agent harness
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Determine install location
if [[ "${1:-}" == "--global" ]]; then
    INSTALL_DIR="$HOME"
elif [[ "${1:-}" == "--project" ]]; then
    INSTALL_DIR="$2"
else
    INSTALL_DIR="$(pwd)"
fi

mkdir -p "$INSTALL_DIR/.fable-method"

# Copy reference materials
cp -r "$BUNDLE_DIR/skills/fable-method/references" "$INSTALL_DIR/.fable-method/"
cp "$BUNDLE_DIR/skills/fable-method/SKILL.md" "$INSTALL_DIR/.fable-method/"
cp "$BUNDLE_DIR/skills/fable-method/skill.yaml" "$INSTALL_DIR/.fable-method/"

# Copy AGENTS.md (portable version)
cp "$BUNDLE_DIR/AGENTS.md" "$INSTALL_DIR/AGENTS.md"

echo "Generic adapter installed to: $INSTALL_DIR"
echo "AGENTS.md: $INSTALL_DIR/AGENTS.md"
echo "Reference materials: $INSTALL_DIR/.fable-method/"
echo ""
echo "Any agent that reads AGENTS.md will follow the fable-method."
