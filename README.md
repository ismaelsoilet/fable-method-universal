# Fable Method - Universal Skills Bundle

> The Fable Workflow: how Claude Fable 5 worked, distilled into four skills any model can run. **Think** (fable-method), **Act** (fable-loop), **Prove** (fable-judge), **Grow** (fable-domain). Evidence-backed: ships its own eval, failures included.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-1.4.0-blue.svg)](https://github.com/Sahir619/fable-method)
[![Frameworks](https://img.shields.io/badge/Frameworks-OpenCode%20|%20Cursor%20|%20Antigravity%20|%20Claude%20Code%20|%20Generic-orange.svg)](#)

## Credits

This is a **community-driven universal port** of the original [fable-method](https://github.com/Sahir619/fable-method) by [Sahir619](https://github.com/Sahir619). The original method was distilled from working sessions with **Claude Fable 5** and tested across 15 eval rounds with 260+ agent runs.

- **Original Repository**: https://github.com/Sahir619/fable-method
- **Author**: Sahir619
- **License**: MIT
- **Version**: 1.4.0 (universal port)

This universal version extends the original by adding framework adapters for OpenCode, Cursor, Antigravity CLI, and a generic format, making the method available to any AI agent framework beyond Claude Code.

## What Is The Fable Method?

The Fable Method is a step-by-step problem-solving loop that turns judgment problems into evidence problems. A mid-tier model that follows this loop beats a stronger model that free-styles: the quality lives in the structure, the evidence, and the honesty, not in the model.

### The Loop

```
ask → 0 classify → 1 define done → 2 evidence → 3 decide → 4 act → 5 verify → 6 report
```

### Four Skills

| Skill | Purpose |
|-------|---------|
| **fable-method** | The core loop: classify the ask, define done, gather evidence, decide, act surgically, verify by observation, report outcome-first |
| **fable-loop** | Orchestrated workflow: parallel evidence gatherers, one committed plan, surgical execution, adversarial verification |
| **fable-judge** | Adversarial verification: treats any "done" as claims, re-runs every verification, delivers VERIFIED/CAVEATS/REFUTED |
| **fable-domain** | Generates new domain adapter bundles for any sector (marketing, devops, finance, etc.) |

## Quick Start

```bash
# Install for all frameworks (global)
./install.sh --all --global

# Install for a specific framework
./install.sh --framework opencode --global
./install.sh --framework cursor --project /path/to/project
./install.sh --framework antigravity --project /path/to/project
./install.sh --framework claude-code --plugin
./install.sh --framework generic --project /path/to/project

# List available frameworks and skills
./install.sh --list
```

## Quick Start

```bash
# Install for all frameworks (global)
./install.sh --all --global

# Install for a specific framework
./install.sh --framework opencode --global
./install.sh --framework cursor --project /path/to/project
./install.sh --framework antigravity --project /path/to/project
./install.sh --framework claude-code --plugin
./install.sh --framework generic --project /path/to/project

# List available frameworks and skills
./install.sh --list
```

## What's Included

### Four Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| **fable-method** | `/fable-method` | The core problem-solving loop: classify → define done → gather evidence → decide → act → verify → report |
| **fable-loop** | `/fable-loop` | Orchestrated workflow with parallel workers, surgical execution, and adversarial verification |
| **fable-judge** | `/fable-judge` | Adversarial verification: treats any "done" as claims, re-runs every verification, delivers VERIFIED/CAVEATS/REFUTED |
| **fable-domain** | `/fable-domain` | Generates new domain adapter bundles for any sector (marketing, devops, finance, etc.) |

### Framework Adapters

| Framework | Install Location | Skill Format |
|-----------|-----------------|--------------|
| **OpenCode** | `~/.config/opencode/skills/` or `<project>/.opencode/skills/` | SKILL.md with frontmatter |
| **Cursor** | `<project>/.cursorrules` + `.fable-method/` | System prompt rules |
| **Antigravity CLI** | `~/.gemini/antigravity-cli/skills/` or `<project>/.agents/skills/` | SKILL.md with YAML frontmatter |
| **Claude Code** | `~/.claude/skills/` or plugin directory | Plugin or standalone skills |
| **Generic** | `<project>/AGENTS.md` + `.fable-method/` | Portable AGENTS.md format |

### Reference Materials

- `references/flowcharts.md` - 8 executable decision flowcharts (mermaid)
- `references/failure-modes.md` - 18 failure modes → step that prevents each
- `references/examples.md` - Worked examples for every ask shape
- `references/domains/` - 8 domain adapters (marketing, research, data-analysis, business-ops, finance, legal-compliance, design-ux, devops) + TEMPLATE.md

### Evaluation

- `eval/README.md` - Methodology and how to reproduce
- `eval/RESULTS.md` - Round-by-round results log (wins, nulls, failures)
- `eval/workflow.js` - A/B eval workflow script

## Architecture

```
fable-method-universal/
├── bundle.yaml              # Universal bundle manifest
├── install.sh               # Universal installer
├── AGENTS.md                # Portable version for any agent
├── skills/                  # The four skills
│   ├── fable-method/        # Core loop (SKILL.md + references/)
│   ├── fable-loop/          # Orchestrated workflow
│   ├── fable-judge/         # Adversarial verification
│   └── fable-domain/        # Domain adapter generation
├── adapters/                # Framework-specific adapters
│   ├── opencode/            # OpenCode adapter
│   ├── cursor/              # Cursor adapter
│   ├── antigravity/         # Antigravity CLI adapter
│   ├── claude-code/         # Claude Code adapter
│   └── generic/             # Generic adapter (AGENTS.md)
└── eval/                    # Evaluation and test scenarios
```

## How It Works

### Universal Skill Format

Each skill uses a `skill.yaml` manifest that describes:
- **Metadata**: name, description, version
- **Triggers**: how to invoke the skill
- **Capabilities**: required and optional tools
- **Abstractions**: framework-agnostic concepts mapped to framework-specific tools

### Abstractions

The skills use abstract concepts that are mapped to framework-specific implementations:

| Abstraction | OpenCode | Cursor | Antigravity | Claude Code | Generic |
|-------------|----------|--------|-------------|-------------|---------|
| parallel_worker | `task` | `agent` | `agent` | `subagent` | sequential |
| task_tracker | `todowrite` | `todo` | `todo` | `todo` | markdown_list |
| web_fetch | `webfetch` | `web_fetch` | `web_fetch` | `WebFetch` | none |
| git_operations | `bash` | `terminal` | `bash` | `bash` | none |

## Supported Frameworks

### OpenCode (Recommended)

```bash
./install.sh --framework opencode --global
# or for a specific project
./install.sh --framework opencode --project /path/to/project
```

Skills are installed to `~/.config/opencode/skills/` and are available as `/fable-method`, `/fable-loop`, `/fable-judge`, `/fable-domain`.

### Cursor

```bash
./install.sh --framework cursor --project /path/to/project
```

Installs `.cursorrules` and `.fable-method/` directory. The method is applied automatically by Cursor.

### Antigravity CLI

```bash
./install.sh --framework antigravity --global
# or for a specific project
./install.sh --framework antigravity --project /path/to/project
```

Skills are installed to `~/.gemini/antigravity-cli/skills/` (global) or `<project>/.agents/skills/` (project).

### Claude Code

```bash
./install.sh --framework claude-code --plugin
# or as standalone skills
./install.sh --framework claude-code --standalone
```

### Generic (Any Agent)

```bash
./install.sh --framework generic --project /path/to/project
```

Installs `AGENTS.md` and `.fable-method/` directory. Works with any agent that reads AGENTS.md (Claude Code, Cursor, Codex, Aider, Gemini CLI, etc.).

## Usage

### fable-method

```
/fable-method <task>        # Full loop on the task
/fable-method plan <task>   # Steps 0-3 only, deliver plan, stop
/fable-method audit         # Grade work against the loop
/fable-method report        # Rewrite answer outcome-first
```

### fable-loop

```
/fable-loop <task>          # Full orchestrated run with parallel workers
```

### fable-judge

```
/fable-judge                # Judge the most recent completed work
/fable-judge suite <target> # Run trap suite against a skill/model
```

### fable-domain

```
/fable-domain <sector>      # Generate a domain adapter bundle
```

## Documentation

- [Original Repository](https://github.com/Sahir619/fable-method) - The source of truth
- `AGENTS.md` - Portable version for any agent
- `skills/fable-method/SKILL.md` - The core method
- `skills/fable-method/references/` - Flowcharts, failure modes, examples, domain adapters

## License

MIT
