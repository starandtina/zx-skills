#!/bin/bash

# zx-skill-map scanner
# Scans ~/.claude/skills/ and outputs JSON with skill metadata

SKILLS_DIR="${HOME}/.claude/skills"

if [ ! -d "$SKILLS_DIR" ]; then
    echo "[]"
    exit 0
fi

# Start JSON array
echo "["

first=true
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        skill_file="${skill_dir}/SKILL.md"

        if [ -f "$skill_file" ]; then
            # Extract metadata from YAML frontmatter
            name=$(grep -E "^name:" "$skill_file" | head -1 | sed 's/^name: *//' | tr -d '"' | xargs)
            version=$(grep -E "^version:" "$skill_file" | head -1 | sed 's/^version: *//' | tr -d '"' | xargs)
            invocable=$(grep -E "^user_invocable:" "$skill_file" | head -1 | grep -q "true" && echo "true" || echo "false")
            desc=$(grep -E "^description:" "$skill_file" | head -1 | sed 's/^description: *//' | sed 's/^"//' | sed 's/"$//' | xargs)

            # Use directory name as fallback
            if [ -z "$name" ]; then
                name="$skill_name"
            fi

            # Output JSON object
            if [ "$first" = true ]; then
                first=false
            else
                echo ","
            fi

            cat <<EOF
  {
    "name": "$name",
    "version": "${version:-}",
    "invocable": $invocable,
    "description": "${desc:-}"
  }
EOF
        fi
    fi
done

# End JSON array
echo ""
echo "]"
