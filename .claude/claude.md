# Claude Rules (DRAFT - Generated 2026-01-04)

## Required Reading
- Read `context.md` before any task
- Read `architecture.md` before structural changes
- Read `commands/setup.md` before modifying analysis logic
- Read `commands/start.md` before modifying session initialization
- Read `commands/update.md` before modifying context update logic

## Authority Model
- **Human decides:** Command prompt structure, analysis methodology, installation approach
- **AI executes:** Approved implementations, documentation updates, script improvements
- **Always ask first:** Changes to command templates, analysis rules, installation logic

## Prohibited Actions
❌ Modifying command prompt templates without explicit approval
❌ Changing installation/uninstall scripts without testing
❌ Altering analysis methodology or evidence labeling system
❌ Adding new dependencies or external tools
❌ Removing safety checks from installation scripts

## Stop & Ask Conditions
- Changes to `.md` command file structure or YAML frontmatter
- Modifications to installation paths (`~/.claude/commands/` or `.claude/commands/`)
- Changes to evidence labeling system (DETECTED/INFERRED/UNKNOWN)
- Alterations to command discovery mechanism
- Adding new commands beyond `/setup`, `/start`, and `/update`

## High-Risk Zones (Handle with Extreme Care)
- `commands/setup.md` - Analysis engine and template generation logic (DETECTED: 465 lines, core functionality)
- `commands/start.md` - Session initialization and context loading (DETECTED: 122 lines, authority hierarchy)
- `commands/update.md` - Context update and merge logic (DETECTED: preserves human edits)
- `install.sh` - File system operations and curl downloads (DETECTED: creates directories, downloads files)
- `uninstall.sh` - File deletion operations (DETECTED: removes command files)

## Code Style Notes
- Scripting: Bash with `set -e` for safety (DETECTED: install.sh:2, uninstall.sh:2)
- Documentation: Markdown with YAML frontmatter (DETECTED: commands/*.md)
- Output formatting: ANSI color codes for CLI feedback (DETECTED: install.sh:5-8)
- No testing framework detected (DETECTED: no test files found)
- No linting configuration detected (DETECTED: no .shellcheckrc, .markdownlint.json found)

⚠️ **Human Review Required:**
- Validate that command modification restrictions are appropriate
- Add any project-specific workflow constraints
- Verify installation safety requirements are complete
