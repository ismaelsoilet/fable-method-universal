# Generic Adapter for Fable Method

This adapter installs the fable-method as a portable system prompt for any AI agent or harness.

## Installation

```bash
# Install into a specific project
./install.sh --framework generic --project /path/to/project

# Install globally (as AGENTS.md)
./install.sh --framework generic --global
```

## What Gets Installed

1. **`AGENTS.md`** - Portable version of the fable-method for any agent harness
2. **`.fable-method/`** - Directory containing the full method reference materials

## How It Works

The generic adapter uses the `AGENTS.md` format, which is recognized by many agent harnesses:
- Claude Code (when AGENTS.md is in the project root)
- Cursor
- Codex CLI
- Aider
- Any agent that reads AGENTS.md

## Framework Capabilities

The generic adapter assumes minimal tool capabilities:

| Abstraction | Generic Implementation |
|-------------|----------------------|
| parallel_worker | None - perform sequentially, batch independent reads |
| task_tracker | Markdown checklist in context |
| web_fetch | None - note when memory-based info is used |
| git_operations | None - note when diff-based verification is unavailable |
| file_operations | read, write, edit, grep, ls |

## Limitations

- No parallel worker: evidence gathering and verification are done sequentially
- No web fetch: research relies on the model's training data (with caveats)
- No git operations: change tracking is done by re-reading files
- The method will note these limitations in reports

## Usage

Simply place `AGENTS.md` in your project root. Any agent that reads AGENTS.md will follow the fable-method automatically.

You can also explicitly reference the method:

```
Use the fable method to approach this task
```

or

```
Apply fable-judge to verify the work
```

## Manual Installation

If the installer doesn't work with your framework:

1. Copy `AGENTS.md` to your project root
2. Copy the `.fable-method/` directory to your project root
3. Any agent that reads AGENTS.md will follow the method

## Supported Frameworks

This adapter works with any framework that:
- Reads `AGENTS.md` or system prompt files
- Has file read/write/edit capabilities
- Has search/grep capabilities
- Can run shell commands (for verification)

Examples: Claude Code, Cursor, Codex CLI, Aider, Gemini CLI, Antigravity CLI, and many more.
