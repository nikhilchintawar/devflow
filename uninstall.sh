#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.claude/commands"
COMMANDS=("setup" "start")

echo ""
echo "🗑️  DevFlow - Uninstaller"
echo "========================="
echo ""

# Determine uninstall location
if [ "$1" = "--project" ]; then
    INSTALL_DIR=".claude/commands"
    echo -e "${YELLOW}📁 Uninstalling from project: ${INSTALL_DIR}${NC}"
else
    echo -e "${YELLOW}🌍 Uninstalling from global: ${INSTALL_DIR}${NC}"
fi

# Check if directory exists
if [ ! -d "${INSTALL_DIR}" ]; then
    echo -e "${RED}❌ Commands directory not found: ${INSTALL_DIR}${NC}"
    exit 1
fi

# Remove each command
echo ""
echo "🧹 Removing commands..."
for cmd in "${COMMANDS[@]}"; do
    if [ -f "${INSTALL_DIR}/${cmd}.md" ]; then
        echo "   Removing /${cmd}..."
        rm -f "${INSTALL_DIR}/${cmd}.md"
    else
        echo -e "   ${YELLOW}⚠️  /${cmd} not found (already removed?)${NC}"
    fi
done

echo ""
echo -e "${GREEN}✅ DevFlow commands uninstalled successfully!${NC}"
echo ""
echo "To reinstall, run:"
echo "  curl -sSL https://raw.githubusercontent.com/nikhilchintawar/devflow/main/install.sh | bash"
echo ""
