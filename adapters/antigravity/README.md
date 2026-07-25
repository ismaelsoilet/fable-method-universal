# Antigravity CLI Adapter for Fable Method

This adapter installs the fable-method skills into Google Antigravity CLI's skill system.

## Installation

```bash
# Install all four skills globally (all projects)
./install.sh --framework antigravity --global

# Install into a specific project
./install.sh --framework antigravity --project /path/to/project
```

## Skill Format

Antigravity CLI uses a simple skill format:
- `SKILL.md` - The skill definition with YAML frontmatter
- Optional: `scripts/`, `references/`, `assets/` directories

### Frontmatter

```yaml
---
name: fable-method
description: "A step-by-step problem-solving loop..."
triggers:
  - "/fable-method"
  - "use the fable method"
turbo_safe: false
---
```

## Installation Locations

- **Global**: `~/.gemini/antigravity-cli/skills/` (available across all projects)
- **Project**: `<project-root>/.agents/skills/` (available only in that project)

## Installed Skills

After installation, the following skills are available:

| Skill | Trigger | Description |
|-------|---------|-------------|
| `/fable-method` | `/fable-method <task>` | The core problem-solving loop |
| `/fable-loop` | `/fable-loop <task>` | Orchestrated workflow with parallel workers |
| `/fable-judge` | `/fable-judge` | Adversarial verification of finished work |
| `/fable-domain` | `/fable-domain <sector>` | Generate new domain adapter bundles |

## Framework Capabilities

Antigravity CLI provides the following tools:

| Abstraction | Antigravity Tool |
|-------------|-----------------|
| parallel_worker | Subagents (asynchronous, concurrent agent sessions) |
| task_tracker | Todo tool |
| web_fetch | Web search/fetch tools |
| git_operations | Terminal commands (bash) |
| file_operations | Read, write, edit, grep, ls |

## Subagents in Antigravity CLI

Antigravity CLI features an asynchronous subagents framework:
- The main agent can spawn subagents for parallel work
- Subagents have full access to tools (code search, file editing, terminal, web)
- The main agent controls what tools and permissions subagents get
- Use `/agents` panel to view and manage running subagents

## Usage Notes

- Restart Antigravity CLI after installing new skills to trigger re-scan
- Skills are automatically imported as slash commands
- The `turbo_safe` flag controls whether a skill can run without approval in turbo mode

## Limitations

- Antigravity CLI's subagent system is asynchronous, not synchronous like Claude Code's
- Some parallel worker patterns may need adaptation for async execution
