#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.claude/commands"
REPO_URL="https://raw.githubusercontent.com/nikhilchintawar/devflow/main"
COMMANDS=("setup" "start" "update")

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

# Parse arguments
PROJECT_INSTALL=false

for arg in "$@"; do
    case $arg in
        --project)
            PROJECT_INSTALL=true
            INSTALL_DIR=".claude/commands"
            ;;
        --help)
            echo "Usage: install.sh [options]"
            echo ""
            echo "Options:"
            echo "  --project      Install to current project (.claude/commands)"
            echo "  --help         Show this help message"
            echo ""
            echo "Examples:"
            echo "  # Install commands globally"
            echo "  ./install.sh"
            echo ""
            echo "  # Install commands to current project"
            echo "  ./install.sh --project"
            echo ""
            exit 0
            ;;
    esac
done

# Determine install location
if [ "$PROJECT_INSTALL" = true ]; then
    echo -e "${GREEN}📁 Installing to project: ${INSTALL_DIR}${NC}"
else
    echo -e "${GREEN}🌍 Installing globally: ${INSTALL_DIR}${NC}"
fi

# Create directory structure
mkdir -p "${INSTALL_DIR}"

# Install commands
echo ""
echo "⬇️  Downloading commands..."
for cmd in "${COMMANDS[@]}"; do
    echo "   Installing /${cmd}..."

    # Download command file directly (flat structure)
    if ! curl -sSfL "${REPO_URL}/commands/${cmd}.md" -o "${INSTALL_DIR}/${cmd}.md"; then
        echo -e "${RED}❌ Failed to download ${cmd} command${NC}"
        exit 1
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
