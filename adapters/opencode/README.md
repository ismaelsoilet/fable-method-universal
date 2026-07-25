# OpenCode Adapter for Fable Method

This adapter installs the fable-method skills into OpenCode's skill system.

## Installation

```bash
# Install all four skills globally
./install.sh --framework opencode --global

# Install into a specific project
./install.sh --framework opencode --project /path/to/project

# Install a single skill
./install.sh --framework opencode --skill fable-method --global
```

## Skill Format

OpenCode skills use a simple format:
- `SKILL.md` - The skill content with frontmatter
- Frontmatter includes: `name`, `description`, `trigger`

## Installed Skills

After installation, the following skills are available:

| Skill | Trigger | Description |
|-------|---------|-------------|
| `/fable-method` | `/fable-method <task>` | The core problem-solving loop |
| `/fable-loop` | `/fable-loop <task>` | Orchestrated workflow with parallel workers |
| `/fable-judge` | `/fable-judge` | Adversarial verification of finished work |
| `/fable-domain` | `/fable-domain <sector>` | Generate new domain adapter bundles |

## Framework Capabilities

OpenCode provides the following tools that the skills use:

| Abstraction | OpenCode Tool |
|-------------|---------------|
| parallel_worker | `task` - Run subagents in parallel |
| task_tracker | `todowrite` - Track multi-step work |
| web_fetch | `webfetch` - Fetch web content |
| git_operations | `bash` - Run git commands |
| file_operations | `read`, `write`, `edit`, `grep`, `bash` |

## Usage Notes

- The `task` tool is used for parallel evidence gathering and adversarial verification
- The `todowrite` tool is used for multi-step work tracking
- The `webfetch` tool is used for source verification and research
- Git operations use the `bash` tool with standard git commands

## Subcommands

All skills support subcommands:

```
/fable-method plan <task>   # Steps 0-3 only, deliver plan, stop
/fable-method audit          # Grade work against the loop
/fable-method report         # Rewrite answer outcome-first

/fable-judge suite <target>  # Run trap suite against a skill/model
```
