#!/usr/bin/env bash
# Claude Code adapter installer
# Installs fable-method as a Claude Code plugin or standalone skills
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
MODE="standalone"

while [[ $# -gt 0 ]]; do
    case $1 in
        --plugin)
            MODE="plugin"
            shift
            ;;
        --standalone|--global|--project)
            MODE="standalone"
            shift
            if [[ "${1:-}" != "" && "${1:-}" != "--"* ]]; then
                shift
            fi
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--plugin | --standalone | --global | --project <path>]"
            exit 1
            ;;
    esac
done

if [[ "$MODE" == "plugin" ]]; then
    # Install as plugin
    PLUGIN_DIR="$HOME/.claude/plugins/fable"
    mkdir -p "$PLUGIN_DIR"
    cp "$BUNDLE_DIR/adapters/claude-code/plugin.json" "$PLUGIN_DIR/"
    
    # Copy skills
    for skill in fable-method fable-loop fable-judge fable-domain; do
        cp -r "$BUNDLE_DIR/skills/$skill" "$PLUGIN_DIR/"
    done
    
    echo "Claude Code plugin installed to: $PLUGIN_DIR"
    echo "Enable it with: /plugin install fable@fable-method"
else
    # Install as standalone skills
    SKILLS_DIR="$HOME/.claude/skills"
    mkdir -p "$SKILLS_DIR"
    
    for skill in fable-method fable-loop fable-judge fable-domain; do
        SKILL_SRC="$BUNDLE_DIR/skills/$skill"
        SKILL_DST="$SKILLS_DIR/$skill"
        cp -r "$SKILL_SRC" "$SKILL_DST"
        echo "Installed: $skill -> $SKILL_DST"
    done
    
    echo ""
    echo "Claude Code standalone skills installed to: $SKILLS_DIR"
    echo "Try it: open Claude Code and type /fable-method after any task."
fi
