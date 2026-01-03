# Architecture (DRAFT - Generated 2026-01-04)

## Tech Stack
| Component | Technology | Evidence |
|-----------|------------|----------|
| Language | Bash 3.x+ | DETECTED: install.sh:1, uninstall.sh:1 |
| Format | Markdown + YAML frontmatter | DETECTED: commands/setup.md:1-4 |
| Distribution | GitHub raw files + curl | DETECTED: install.sh:12, README.md:26 |
| Runtime | CLI via Claude Code | DETECTED: commands executed as prompts |

## Project Structure
```
devflow/
├── commands/           # DETECTED: Claude Code command definitions
│   ├── setup.md       # DETECTED: Codebase analysis prompt (465 lines)
│   ├── start.md       # DETECTED: Session init prompt (122 lines)
│   └── reference.md   # DETECTED: Documentation reference
├── install.sh         # DETECTED: Installation script (104 lines)
├── uninstall.sh       # DETECTED: Cleanup script (51 lines)
├── README.md          # DETECTED: User documentation (234 lines)
├── old/               # DETECTED: Archived legacy files (excluded via .gitignore)
└── .git/              # DETECTED: Git repository metadata
```

## Code Organization Pattern
- DETECTED: Flat file structure with functional separation
- Evidence: Commands in `commands/`, scripts at root, documentation at root

**No layering detected** - Project is a collection of independent files:
```
Installation Scripts → Command Files → User Environment
(install.sh/uninstall.sh) → (commands/*.md) → (~/.claude/commands/)
```

## Module Boundaries
- Module 1: `install.sh` - Installation logic (DETECTED: handles global/project installs, creates directories)
- Module 2: `uninstall.sh` - Cleanup logic (DETECTED: removes installed commands)
- Module 3: `commands/setup.md` - Analysis engine (DETECTED: generates .claude/ context files)
- Module 4: `commands/start.md` - Session initializer (DETECTED: loads context, presents summary)
- Module 5: `README.md` - User documentation (DETECTED: installation, usage, examples)

## Data Flow
**Example: User installs DevFlow globally**
```
1. Entry: User runs curl | bash (README.md:26)
2. Download: install.sh fetches from GitHub (install.sh:74)
3. Placement: Files copied to ~/.claude/commands/ (install.sh:11, 65-77)
4. Discovery: Claude Code finds commands on next launch (INFERRED: auto-discovery)
5. Execution: User types /setup → setup.md prompt loads (start.md:22)
```

**Example: User runs /setup in project**
```
1. Entry: /setup command invoked in Claude Code session
2. Processing: setup.md prompt executes analysis workflow (setup.md:38-92)
3. Generation: Three .claude/*.md files created (setup.md:22-28)
4. Output: Draft files presented for review (setup.md:442-447)
5. Approval: User confirms, files written to .claude/ (setup.md:458)
```

## Critical Dependencies
- Claude Code CLI: Command discovery and execution (DETECTED: README.md:17)
- curl: Remote file downloads (DETECTED: install.sh:74)
- bash: Script execution engine (DETECTED: shebang in both scripts)
- Git (optional): For committing generated context (DETECTED: README.md:197, 214)

## Configuration Management
- DETECTED: No configuration files (commands are static prompts)
- DETECTED: Installation location controlled by `--project` flag (install.sh:34-36)
- DETECTED: Environment variable usage: `$HOME` for global install path (install.sh:11)
- Secrets management: N/A (DETECTED: no secrets or credentials)

## Data Storage
**No databases** - Project does not persist data

**File Storage:**
- DETECTED: Command files stored at `~/.claude/commands/` (global) or `.claude/commands/` (project)
- DETECTED: Generated context files at `.claude/` in user's project (setup.md:25-27)
- DETECTED: Archived files in `old/` directory (gitignored)

## External Integrations
| Service | Purpose | Location in Code |
|---------|---------|------------------|
| GitHub | Command file distribution | DETECTED: install.sh:12, README.md:26 |
| Claude Code | Command execution platform | DETECTED: README.md:17, commands/*.md frontmatter |

## Deployment Artifacts
- DETECTED: No build process (distributed as source files)
- Installation: Via curl piped to bash (DETECTED: README.md:26, 34)
- Artifacts: 2 shell scripts + 3 markdown command files (DETECTED: install.sh:13)

## Architectural Constraints (Detected)
- DETECTED: Must use Markdown format for commands (Claude Code requirement: setup.md:1-4)
- DETECTED: YAML frontmatter required for command metadata (setup.md:1-4, start.md:1-4)
- DETECTED: Files must be in `~/.claude/commands/` or `.claude/commands/` (install.sh:11, 36)
- DETECTED: Commands must be .md files with no subdirectories (install.sh:74, flat structure)
- INFERRED: No runtime dependencies beyond bash/curl/Claude (install.sh uses only standard tools)

## Testing Approach
- Framework: UNKNOWN (no test files detected)
- Coverage: UNKNOWN (no test infrastructure)
- Test location: N/A (DETECTED: 0 test files found)

⚠️ **Human Review Required:**
- Validate command discovery mechanism assumptions
- Add deployment/distribution strategy details
- Verify architectural constraints are complete
- Consider adding testing strategy
