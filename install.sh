#!/bin/bash

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing save-your-work skills..."

mkdir -p "$SKILLS_DIR"

cp "$SCRIPT_DIR/skills/checkpoint.md" "$SKILLS_DIR/checkpoint.md"
cp "$SCRIPT_DIR/skills/resume.md" "$SKILLS_DIR/resume.md"

echo ""
echo "Done! Two skills installed to $SKILLS_DIR:"
echo "  /checkpoint  — start a session with automatic progress checkpoints"
echo "  /resume      — recover a crashed session from the last checkpoint"
echo ""
echo "Run /checkpoint at the beginning of your next development session."
