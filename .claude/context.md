# Project Context (DRAFT - Generated 2026-01-04)

## Project Identity
**Name:** DevFlow (DETECTED: README.md:1)
**Type:** Claude Code CLI command collection (DETECTED: install.sh copies .md files to ~/.claude/commands/)
**Primary Language:** Shell Script & Markdown - 100% of codebase (DETECTED: 2 .sh files, 4 .md files active)

## What This Project Does
- DETECTED: Installs slash commands (`/setup`, `/start`, `/update`) for Claude Code CLI (install.sh:13, README.md:9-11)
- DETECTED: Analyzes codebases to generate `.claude/` context files (setup.md:22-28)
- DETECTED: Loads project context at session start (start.md:6-8)
- DETECTED: Updates existing context files while preserving human edits (update.md)
- DETECTED: Provides global or project-specific installation options (install.sh:30-55)
- DETECTED: Uninstalls commands via cleanup script (uninstall.sh:33-43)
- INFERRED: Enables teams to share AI context via git-committed `.claude/` files (README.md:214)

## What This Project Does NOT Do
- DETECTED: No code execution or compilation (no runtime files)
- DETECTED: No network services or APIs (no server processes)
- DETECTED: No data storage or databases (no persistence layer)
- DETECTED: No testing or CI/CD (no test files or workflow configs)
- DETECTED: No package management (no package.json, go.mod, requirements.txt)
- DETECTED: No build process (no Makefile, Dockerfile, or build scripts)

## Intended Users
- DETECTED: Developers using Claude Code CLI (README.md:17, multiple references to `claude` command)
- DETECTED: Teams sharing AI context across projects (README.md:214)
- INFERRED: GitHub-based distribution (install.sh:12 uses raw.githubusercontent.com URLs)

## External Dependencies
- DETECTED: Claude Code CLI - Required for command execution (README.md:17, install.sh:21-27)
- DETECTED: curl - For remote installation (install.sh:74, README.md:26)
- DETECTED: bash - Script runtime (install.sh:1, uninstall.sh:1)
- DETECTED: GitHub - Command file hosting (install.sh:12)
- DETECTED: Standard Unix tools - mkdir, rm, cp (used throughout scripts)

## Domain Constraints
**Critical Business Logic Areas:**
- Money/Payments: NO (DETECTED: no payment-related code found)
- Auth/Identity: NO (DETECTED: no authentication logic found)
- PII/Sensitive Data: NO (DETECTED: only analyzes code structure, no data collection)
- Compliance Requirements: UNKNOWN (not detectable from code)

## Non-Goals (Detected by Absence)
- No web interface (DETECTED: no HTML/CSS/JS files)
- No mobile support (DETECTED: no mobile-specific code)
- No offline mode needed (DETECTED: commands are local files)
- No scheduled jobs (DETECTED: no cron or background processes)
- No real-time features (DETECTED: no websockets or polling)
- No multi-language support (DETECTED: all documentation in English)

⚠️ **Human Review Required:**
- Confirm target user personas beyond "developers using Claude Code"
- Add any compliance context for enterprise usage
- Verify domain constraints accurately reflect project scope
