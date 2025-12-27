#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.claude/commands"
HOOKS_DIR=".claude/hooks"
REPO_URL="https://raw.githubusercontent.com/nikhilchintawar/devflow/main"
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

# Parse arguments
INSTALL_HOOKS=false
PROJECT_INSTALL=false

for arg in "$@"; do
    case $arg in
        --project)
            PROJECT_INSTALL=true
            INSTALL_DIR=".claude/commands"
            ;;
        --with-hooks)
            INSTALL_HOOKS=true
            ;;
        --help)
            echo "Usage: install.sh [options]"
            echo ""
            echo "Options:"
            echo "  --project      Install commands to current project (.claude/commands)"
            echo "  --with-hooks   Install SessionStart hook to current directory"
            echo "  --help         Show this help message"
            echo ""
            echo "Examples:"
            echo "  # Install commands globally"
            echo "  ./install.sh"
            echo ""
            echo "  # Install commands globally + hooks in current project (recommended)"
            echo "  ./install.sh --with-hooks"
            echo ""
            echo "  # Install everything to current project only"
            echo "  ./install.sh --project --with-hooks"
            echo ""
            exit 0
            ;;
    esac
done

# Validate we're in a directory where hooks make sense
if [ "$INSTALL_HOOKS" = true ] && [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: Not in a git repository${NC}"
    echo "   Hooks work best in project directories"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Determine install location
if [ "$PROJECT_INSTALL" = true ]; then
    echo -e "${GREEN}📁 Installing commands to project: ${INSTALL_DIR}${NC}"
else
    echo -e "${GREEN}🌍 Installing commands globally: ${INSTALL_DIR}${NC}"
fi

if [ "$INSTALL_HOOKS" = true ]; then
    echo -e "${GREEN}🪝 Installing hooks to current directory: ${HOOKS_DIR}${NC}"
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

# Install hooks if requested
if [ "$INSTALL_HOOKS" = true ]; then
    echo ""
    echo "⬇️  Installing SessionStart hook..."

    # Create hooks directory
    mkdir -p "${HOOKS_DIR}"

    # Download hook script
    if ! curl -sSfL "${REPO_URL}/hooks/session-start.sh" -o "${HOOKS_DIR}/session-start.sh"; then
        echo -e "${RED}❌ Failed to download hook script${NC}"
        exit 1
    fi

    chmod +x "${HOOKS_DIR}/session-start.sh"

    # Check if settings.json already exists
    if [ -f ".claude/settings.json" ]; then
        echo ""
        echo -e "${YELLOW}⚠️  .claude/settings.json already exists${NC}"
        echo ""
        echo "Hook script installed. To enable it, merge the configuration:"
        echo -e "${BLUE}  ${REPO_URL}/hooks/settings.json${NC}"
        echo ""
        echo "Or view the template:"
        echo -e "${BLUE}  curl -sSL ${REPO_URL}/hooks/settings.json${NC}"
    else
        # Download settings template
        if curl -sSfL "${REPO_URL}/hooks/settings.json" -o ".claude/settings.json" 2>/dev/null; then
            echo -e "${GREEN}✅ Hook installed and configured!${NC}"
        else
            echo -e "${YELLOW}⚠️  Hook script installed, but settings.json download failed${NC}"
            echo "   View template: ${REPO_URL}/hooks/settings.json"
        fi
    fi
fi

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

if [ "$INSTALL_HOOKS" = true ]; then
    echo "  4. Auto-load context (optional):"
    echo "     SessionStart hook will show helpful tips"
    echo "     when Claude Code starts"
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$INSTALL_HOOKS" = false ]; then
    echo -e "${BLUE}💡 Tip: Add hooks for helpful reminders:${NC}"
    if [ "$PROJECT_INSTALL" = true ]; then
        echo "   Run: ./install.sh --project --with-hooks"
    else
        echo "   cd your-project"
        echo "   curl -sSL install.sh | bash -s -- --with-hooks"
    fi
    echo ""
fi

echo "📖 Documentation: https://github.com/nikhilchintawar/devflow"
echo ""
