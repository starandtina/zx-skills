#!/bin/bash

# Sync local skills back to repo (for development)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="${HOME}/.claude/skills"

echo "Syncing skills from ~/.claude/skills to repo..."
echo "Source: $SKILLS_DIR"
echo "Target: $REPO_ROOT/skills"

# Copy all zx-* directories from installed skills back to repo
for skill_dir in "$SKILLS_DIR"/zx-*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_dir="$REPO_ROOT/skills/$skill_name"

        echo "Syncing $skill_name..."

        # Remove existing if present
        if [ -d "$target_dir" ]; then
            rm -rf "$target_dir"
        fi

        # Copy skill directory
        cp -r "$skill_dir" "$target_dir"

        # Remove node_modules and other generated files from repo
        rm -rf "$target_dir/node_modules"
        rm -f "$target_dir/package-lock.json"
    fi
done

echo ""
echo "✓ Sync complete!"
echo ""
echo "Synced skills:"
ls -1 "$REPO_ROOT/skills" | grep "^zx-" | sed 's/^/  - /'
