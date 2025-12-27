#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.claude/commands"
REPO_URL="https://raw.githubusercontent.com/nikhilchintawar/devflow/main/commands"
COMMANDS=("setup" "start")

echo ""
echo "📦 DevFlow - Claude Code Command Installer"
echo "=========================================="
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: Claude Code CLI not found${NC}"
    echo "   Install from: https://code.claude.com"
    echo ""
    echo "   Continuing installation anyway..."
    echo ""
fi

# Determine install location
if [ "$1" = "--project" ]; then
    INSTALL_DIR=".claude/commands"
    echo -e "${GREEN}📁 Installing to project: ${INSTALL_DIR}${NC}"
else
    echo -e "${GREEN}🌍 Installing globally: ${INSTALL_DIR}${NC}"
fi

# Create directory structure
mkdir -p "${INSTALL_DIR}"

# Install each command with its subdirectory
echo ""
echo "⬇️  Downloading commands..."
for cmd in "${COMMANDS[@]}"; do
    echo "   Installing /${cmd}..."
    mkdir -p "${INSTALL_DIR}/${cmd}"

    # Download main command file
    if ! curl -sSfL "${REPO_URL}/${cmd}/${cmd}.md" -o "${INSTALL_DIR}/${cmd}/${cmd}.md"; then
        echo -e "${RED}❌ Failed to download ${cmd} command${NC}"
        exit 1
    fi

    # Download reference file for start command
    if [ "$cmd" = "start" ]; then
        if curl -sSfL "${REPO_URL}/${cmd}/reference.md" -o "${INSTALL_DIR}/${cmd}/reference.md" 2>/dev/null; then
            echo "   └─ Including reference documentation"
        fi
    fi
done

echo ""
echo -e "${GREEN}✅ DevFlow commands installed successfully!${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Usage:"
echo "  1. Start Claude Code:"
echo "     $ claude"
echo ""
echo "  2. Setup project (first time):"
echo "     /setup"
echo "     → Analyzes your codebase"
echo "     → Generates .claude/ context files"
echo ""
echo "  3. Start development session:"
echo "     /start"
echo "     → Loads project context"
echo "     → Ready for development tasks"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📖 Documentation: https://github.com/nikhilchintawar/devflow"
echo ""
