#!/bin/bash

# Install zx-skills to ~/.claude/skills/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="${HOME}/.claude/skills"

echo "Installing zx-skills..."
echo "Source: $REPO_ROOT"
echo "Target: $SKILLS_DIR"

# Create skills directory if not exists
mkdir -p "$SKILLS_DIR"

# Copy all zx-* directories
for skill_dir in "$REPO_ROOT"/skills/zx-*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_dir="$SKILLS_DIR/$skill_name"

        echo "Installing $skill_name..."

        # Remove existing if present
        if [ -d "$target_dir" ]; then
            rm -rf "$target_dir"
        fi

        # Copy skill directory
        cp -r "$skill_dir" "$target_dir"
    fi
done

# Install zx-card dependencies if needed
if [ -d "$SKILLS_DIR/zx-card" ]; then
    echo ""
    echo "Installing zx-card dependencies..."
    cd "$SKILLS_DIR/zx-card"
    if [ ! -d "node_modules" ]; then
        npm install
        npx playwright install chromium
    fi
fi

echo ""
echo "✓ Installation complete!"
echo ""
echo "Installed skills:"
ls -1 "$SKILLS_DIR" | grep "^zx-" | sed 's/^/  - /'
echo ""
echo "Restart Claude Code to load the new skills."
