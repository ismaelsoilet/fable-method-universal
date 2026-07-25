#!/usr/bin/env bash
# Universal installer for fable-method skills
# Installs skills into any supported framework
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Install fable-method skills into your preferred framework.

OPTIONS:
    --framework <name>   Framework to install for (required)
                        Supported: opencode, cursor, antigravity, claude-code, generic
    --global             Install globally (all projects)
    --project <path>     Install into a specific project
    --skill <name>       Install only a specific skill (fable-method, fable-loop, fable-judge, fable-domain)
    --all                Install for all supported frameworks
    --list               List available frameworks and skills
    -h, --help           Show this help message

EXAMPLES:
    # Install all skills for OpenCode (global)
    $0 --framework opencode --global

    # Install into a specific project
    $0 --framework cursor --project /path/to/project

    # Install only fable-method for Antigravity CLI
    $0 --framework antigravity --global --skill fable-method

    # Install for all frameworks
    $0 --all --global

EOF
    exit 0
}

list_frameworks() {
    echo "Available frameworks:"
    echo "  opencode       - OpenCode agent"
    echo "  cursor         - Cursor editor"
    echo "  antigravity    - Google Antigravity CLI"
    echo "  claude-code    - Claude Code"
    echo "  generic        - Any agent (AGENTS.md)"
    echo ""
    echo "Available skills:"
    echo "  fable-method   - The core problem-solving loop"
    echo "  fable-loop     - Orchestrated workflow with parallel workers"
    echo "  fable-judge    - Adversarial verification"
    echo "  fable-domain   - Generate domain adapter bundles"
}

install_framework() {
    local framework="$1"
    local scope="$2"
    local project_path="$3"
    local skill_filter="$4"
    
    local adapter_dir="$SCRIPT_DIR/adapters/$framework"
    
    if [[ ! -d "$adapter_dir" ]]; then
        echo -e "${RED}Error: Framework '$framework' not found${NC}"
        echo "Available frameworks: opencode, cursor, antigravity, claude-code, generic"
        exit 1
    fi
    
    local install_cmd="$adapter_dir/install.sh"
    
    if [[ ! -x "$install_cmd" ]]; then
        chmod +x "$install_cmd"
    fi
    
    echo -e "${BLUE}Installing fable-method for $framework...${NC}"
    
    if [[ "$scope" == "global" ]]; then
        bash "$install_cmd" --global
    elif [[ "$scope" == "project" ]]; then
        bash "$install_cmd" --project "$project_path"
    else
        bash "$install_cmd"
    fi
    
    echo -e "${GREEN}Installation complete for $framework${NC}"
}

# Parse arguments
FRAMEWORK=""
SCOPE=""
PROJECT_PATH=""
SKILL_FILTER=""
INSTALL_ALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --framework)
            FRAMEWORK="$2"
            shift 2
            ;;
        --global)
            SCOPE="global"
            shift
            ;;
        --project)
            SCOPE="project"
            PROJECT_PATH="$2"
            shift 2
            ;;
        --skill)
            SKILL_FILTER="$2"
            shift 2
            ;;
        --all)
            INSTALL_ALL=true
            shift
            ;;
        --list)
            list_frameworks
            exit 0
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Validate
if [[ "$INSTALL_ALL" == false && -z "$FRAMEWORK" ]]; then
    echo -e "${RED}Error: --framework is required (or use --all)${NC}"
    usage
fi

# Install
if [[ "$INSTALL_ALL" == true ]]; then
    echo -e "${BLUE}Installing fable-method for all frameworks...${NC}"
    for framework in opencode cursor antigravity claude-code generic; do
        echo ""
        install_framework "$framework" "${SCOPE:-global}" "${PROJECT_PATH:-}" "$SKILL_FILTER"
    done
    echo ""
    echo -e "${GREEN}All frameworks installed successfully!${NC}"
else
    install_framework "$FRAMEWORK" "${SCOPE:-global}" "${PROJECT_PATH:-}" "$SKILL_FILTER"
fi

echo ""
echo -e "${YELLOW}Note: Restart your agent/framework after installation.${NC}"
echo -e "${YELLOW}      Some frameworks require manual activation.${NC}"
