# Fable Method for Cursor

This adapter installs the fable-method as Cursor rules and system prompt instructions.

## Installation

```bash
# Install into a specific project
./install.sh --framework cursor --project /path/to/project

# Install globally (all projects)
./install.sh --framework cursor --global
```

## What Gets Installed

1. **`.cursorrules`** - Cursor rules file with the fable-method instructions
2. **`.fable-method/`** - Directory containing the full method reference materials
3. **`AGENTS.md`** - Portable version for any agent harness

## How It Works

Cursor uses `.cursorrules` to inject instructions into the system prompt. The fable-method is installed as a set of rules that Cursor follows automatically.

## Available Commands

Since Cursor doesn't have a skill/trigger system, the method is applied automatically:

- **Before any non-trivial multi-step task**: Apply the fable-method loop
- **After completing substantive work**: Run a fable-judge pass
- **For multi-phase projects**: Use fable-loop orchestration

## Framework Capabilities

Cursor provides the following tools:

| Abstraction | Cursor Tool |
|-------------|-------------|
| parallel_worker | `agent` - Cursor's agent tool (if available) |
| task_tracker | `todo` - Cursor's todo tool |
| web_fetch | `web_fetch` - Fetch web content |
| git_operations | `terminal` - Run git commands |
| file_operations | `read`, `write`, `edit`, `grep`, `ls` |

## Limitations

- Cursor does not have a native subagent system like Claude Code
- Parallel workers may need to be done sequentially
- The method will note when parallelism is unavailable

## Usage

Simply start Cursor in a project with the rules installed. The method will be applied automatically to all tasks. You can also explicitly reference it:

```
Use the fable method to approach this task
```

or

```
Apply fable-judge to verify the work
```
