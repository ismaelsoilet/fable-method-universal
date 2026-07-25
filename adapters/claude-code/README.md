# Claude Code Adapter for Fable Method

This adapter installs the fable-method as a Claude Code plugin.

## Installation

```bash
# Install as a Claude Code plugin (recommended)
./install.sh --framework claude-code --plugin

# Or install as standalone skills
./install.sh --framework claude-code --standalone
```

## Plugin Installation (Recommended)

```bash
cd /path/to/fable-method-universal
/plugin marketplace add .
/plugin install fable@fable-method
```

Or manually:

```bash
# Copy the plugin to Claude Code's plugin directory
cp -r adapters/claude-code ~/.claude/plugins/fable
```

## Standalone Skills Installation

```bash
./install.sh --framework claude-code --standalone
```

This installs skills to `~/.claude/skills/`.

## Installed Skills

After installation, the following skills are available:

| Skill | Trigger | Description |
|-------|---------|-------------|
| `/fable-method` | `/fable-method <task>` | The core problem-solving loop |
| `/fable-loop` | `/fable-loop <task>` | Orchestrated workflow with subagents |
| `/fable-judge` | `/fable-judge` | Adversarial verification |
| `/fable-domain` | `/fable-domain <sector>` | Generate domain adapters |

## Framework Capabilities

Claude Code provides:

| Abstraction | Claude Code Tool |
|-------------|-----------------|
| parallel_worker | `subagent` - Spawn subagents for parallel work |
| task_tracker | `todo` - TodoWrite tool |
| web_fetch | `WebFetch` - Fetch web content |
| git_operations | `bash` - Run git commands |
| file_operations | `read`, `write`, `edit`, `grep`, `ls` |

## Subcommands

```
/fable-method plan <task>   # Steps 0-3 only
/fable-method audit          # Grade work against the loop
/fable-method report         # Rewrite answer outcome-first

/fable-judge suite <target>  # Run trap suite
```

## Make it Proactive

Add to your global `~/.claude/CLAUDE.md`:

```markdown
# Fable family (think / act / prove)
- Before any non-trivial multi-step task, apply the fable-method loop
- For unattended or agent-heavy runs, use fable-loop
- After completing substantive work, run a fable-judge pass
```
