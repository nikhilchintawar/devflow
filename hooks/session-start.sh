#!/bin/bash
# DevFlow SessionStart Hook
# Automatically runs when Claude Code starts
# Provides helpful reminders about DevFlow commands

set -e

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  # Not a git repo, skip DevFlow hints
  exit 0
fi

# Check if .claude directory exists
if [ ! -d ".claude" ]; then
  echo "💡 DevFlow Tip: Run /setup to analyze this project and generate context files"
  exit 0
fi

# Check if context files exist
if [ -f ".claude/claude.md" ] && [ -f ".claude/context.md" ] && [ -f ".claude/architecture.md" ]; then
  echo "📚 DevFlow context available"
  echo ""
  echo "Commands:"
  echo "  /start  - Load project context and begin development"
  echo "  /setup  - Regenerate context files (run after major changes)"
  echo ""

  # Show when context was last updated
  if [ -f ".claude/context.md" ]; then
    LAST_UPDATED=$(date -r ".claude/context.md" "+%Y-%m-%d %H:%M" 2>/dev/null || stat -f "%Sm" -t "%Y-%m-%d %H:%M" ".claude/context.md" 2>/dev/null)
    if [ -n "$LAST_UPDATED" ]; then
      echo "📅 Context last updated: $LAST_UPDATED"
      echo ""
    fi
  fi
else
  echo "⚠️  Incomplete DevFlow context detected"
  echo ""
  echo "Run /setup to generate missing files:"
  [ ! -f ".claude/claude.md" ] && echo "  • claude.md (behavior rules)"
  [ ! -f ".claude/context.md" ] && echo "  • context.md (project identity)"
  [ ! -f ".claude/architecture.md" ] && echo "  • architecture.md (system structure)"
  echo ""
fi

exit 0
