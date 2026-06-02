#!/bin/bash

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing save-your-work skills..."

mkdir -p "$SKILLS_DIR"

cp "$SCRIPT_DIR/skills/saving-progress/SKILL.md" "$SKILLS_DIR/saving-progress.md"
cp "$SCRIPT_DIR/skills/continue-progress/SKILL.md" "$SKILLS_DIR/continue-progress.md"

echo ""
echo "Done! Two skills installed to $SKILLS_DIR:"
echo "  /saving-progress   — start a session with automatic progress checkpoints"
echo "  /continue-progress — recover a crashed session from the last checkpoint"
echo ""
echo "Run /saving-progress at the beginning of your next development session."
