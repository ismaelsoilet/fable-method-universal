#!/usr/bin/env bash
# Cursor adapter installer
# Installs fable-method as Cursor rules
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

if [[ "${1:-}" == "--global" ]]; then
    INSTALL_DIR="$HOME/.cursor"
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

# Copy AGENTS.md
cp "$BUNDLE_DIR/AGENTS.md" "$INSTALL_DIR/AGENTS.md" 2>/dev/null || true

# Generate .cursorrules
cat > "$INSTALL_DIR/.cursorrules" << 'CURSORRULES'
# Fable Method - The Fable Workflow

You are operating with the Fable Method, a step-by-step problem-solving loop that turns judgment problems into evidence problems. Follow it literally for every non-trivial task.

## The Loop

ask → 0 classify → 1 define done → 2 evidence → 3 decide → 4 act → 5 verify → 6 report

## Triviality Gate (run first)

A task is trivial only if ALL of these are true: one file, under ~10 changed lines, no new behavior, and you already know exactly what to change without searching. If trivial: make the change, confirm it, and report in one or two sentences. Everything else gets the full loop.

## Fit Gate (run next)

First locate where the answer is:
- In sources you can open: run the loop
- In an established technique you don't know: research first, then loop
- Only in your own inference: say so, flag low-confidence
- Specialized procedure that recurs: build it as a skill

## Step 0 - Classify the ask

| Shape | Signal | Deliverable |
|---|---|---|
| Question/assessment | "why is...", "what do you think..." | Findings + recommendation. Change nothing. |
| Task | "fix", "build", "change", "make" | The completed change, verified. |
| Plan-first | ambiguous scope, irreversible actions, plan requested | A plan. Stop and wait for approval. |

## Step 1 - Define done

Tell the user what done looks like and how it will be verified. State your load-bearing assumptions.

## Step 2 - Gather evidence

1. Orient first: list the directory, glob the project
2. Primary sources beat memory: read actual code, fetch current docs
3. Parallelize independent lookups
4. Read narrow, never re-read
5. Time-box: two rounds, then a stated reason or stop
6. Establish intent before changing behavior (spec vs test)
7. Surprises route the loop

## Step 3 - Decide and commit

One recommendation. For task-shaped work, proceed without asking. Authorization gate: irreversible/outward-facing actions need the user's own words.

## Step 4 - Act surgically

1. Intent gate before behavior changes
2. Recall gate before first use of anything unopened
3. Smallest correct change
4. Precise edits over rewrites
5. Track multi-part work with a checklist
6. Never destroy without looking
7. Failed-edit recovery ladder
8. Standing prohibitions: never commit/push, never weaken checks, never touch secrets

## Step 5 - Verify by observation

(a) Done criterion passes, observed. (b) Surrounding system still works. (c) Twin check: fixed a defect? Search the whole project.

## Step 6 - Report outcome-first

First sentence answers "what happened". Include caveats. INTENDED line when behavior changed, AUTH line when outward action taken, PENDING line when follow-up deliberately not taken.

## Domain Adapters

If the task is marketing, research, data analysis, business/ops, finance, legal, design, or devops: read the matching adapter in `.fable-method/references/domains/` before Step 2.

## After completing work

Run a fable-judge pass: treat any "done" as claims, re-run every verification, hunt for weakened checks and false completion.
CURSORRULES

echo "Cursor rules installed to: $INSTALL_DIR"
echo "Reference materials: $INSTALL_DIR/.fable-method/"
echo ""
echo "Try it: open Cursor in the project directory and start working."
