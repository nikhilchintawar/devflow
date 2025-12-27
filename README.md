# DevFlow

**Smart project context management for Claude Code**

DevFlow provides powerful slash commands for Claude Code CLI that analyze your codebase and maintain intelligent project context throughout your development sessions.

## Features

- **`/setup`** - Analyzes your codebase and generates comprehensive `.claude/` context files
- **`/start`** - Loads project context to prepare Claude for development work
- **Code-first analysis** - Trust what the code does, not what docs claim
- **Zero speculation** - Every claim is labeled as DETECTED, INFERRED, or UNKNOWN
- **Risk zone detection** - Automatically identifies sensitive areas (payments, auth, etc.)

## Prerequisites

- [Claude Code CLI](https://code.claude.com) installed

## Installation

### Quick Install (Global)

Install commands globally to use across all projects:

```bash
curl -sSL https://raw.githubusercontent.com/nikhilchintawar/devflow/main/install.sh | bash
```

### Project-Specific Install

Install to current project only:

```bash
curl -sSL https://raw.githubusercontent.com/nikhilchintawar/devflow/main/install.sh | bash -s -- --project
```

### Manual Install

```bash
git clone https://github.com/nikhilchintawar/devflow.git
cd devflow
./install.sh
```

## Usage

### 1. Setup Your Project

Navigate to your project and start Claude Code:

```bash
cd your-project
claude
```

Then run the setup command:

```
/setup
```

This will:
- Analyze your codebase structure
- Detect tech stack and frameworks
- Identify risk zones (payments, auth, etc.)
- Generate three context files in `.claude/`:
  - `claude.md` - AI behavior rules for this project
  - `context.md` - What the project actually does
  - `architecture.md` - System structure and data flow

### 2. Start Development Sessions

Each time you begin working:

```
/start
```

This will:
- Load project context from `.claude/` files
- Present high-risk zones and prohibited actions
- Prepare Claude with project-specific constraints
- Wait for your development task

### Example Workflow

```bash
# First time in a project
$ cd my-app
$ claude
> /setup
# Review generated .claude/ files
# Edit if needed, then commit to git

# Later development sessions
$ claude
> /start
# Context loaded, ready to work
> Add user authentication using JWT
```

## What Gets Generated

### `.claude/claude.md`
Rules for how Claude should behave in your project:
- Prohibited actions
- Stop & ask conditions
- High-risk zones to handle carefully
- Code style preferences

### `.claude/context.md`
What your project actually is:
- Project identity and type
- Core functionality
- External dependencies
- Domain constraints (payments, auth, PII, etc.)

### `.claude/architecture.md`
How your system is structured:
- Tech stack breakdown
- Code organization patterns
- Module boundaries
- Data flow examples
- Critical dependencies

## Analysis Approach

DevFlow uses **code-first analysis**:

- ✅ **Code is truth** - Analyzes actual implementation
- ✅ **Evidence-based** - Every claim labeled with evidence
- ✅ **No speculation** - Marks unknowns as UNKNOWN
- ❌ **No assumptions** - Won't infer from naming alone
- ❌ **No suggestions** - Documents reality, not ideals

## Uninstall

### Remove Global Commands

```bash
curl -sSL https://raw.githubusercontent.com/nikhilchintawar/devflow/main/uninstall.sh | bash
```

### Remove Project Commands

```bash
curl -sSL https://raw.githubusercontent.com/nikhilchintawar/devflow/main/uninstall.sh | bash -s -- --project
```

Or manually:

```bash
# Remove global commands
rm -f ~/.claude/commands/setup.md ~/.claude/commands/start.md

# Remove project commands
rm -f .claude/commands/setup.md .claude/commands/start.md
```

## Development

### Project Structure

```
devflow/
├── commands/
│   ├── setup.md             # /setup command
│   ├── start.md             # /start command
│   └── reference.md         # Reference documentation
├── install.sh               # Installation script
├── uninstall.sh            # Uninstall script
└── README.md               # This file
```

### Testing Locally

```bash
# Install to test directory
mkdir -p ~/.claude/commands
cp -r commands/* ~/.claude/commands/

# Test in a project
cd test-project
claude
/setup
```

## How It Works

1. **Installation** - Copies command files to `~/.claude/commands/` (global) or `.claude/commands/` (project)
2. **Discovery** - Claude Code automatically discovers commands
3. **Execution** - Commands run as prompts when invoked
4. **Context** - Generated files persist in `.claude/` (commit to git)

## Best Practices

- **Commit `.claude/` files** - Share context with your team
- **Run `/setup` after major refactors** - Keep context fresh
- **Review generated files** - Edit UNKNOWN items with actual info
- **Use `/start` every session** - Ensures Claude has full context

## FAQ

**Q: Do I need to run `/setup` every time?**
A: No! Only run `/setup` once per project (or when architecture changes significantly). Run `/start` at the beginning of each development session.

**Q: Can I edit the generated `.claude/` files?**
A: Yes! The files are marked as DRAFT. Review and edit them to add project-specific knowledge that can't be detected from code.

**Q: What if my project is too large?**
A: The `/setup` command has built-in scaling strategies. For 500+ files, it focuses on structure and entry points rather than deep analysis.

**Q: Can teams use this?**
A: Absolutely! Commit the `.claude/` directory to git. Team members just need to run `/start` to load the shared context.

**Q: How do I update commands?**
A: Re-run the install script. It will overwrite existing commands with the latest versions.

## Contributing

Issues and pull requests welcome at [github.com/nikhilchintawar/devflow](https://github.com/nikhilchintawar/devflow)

## License

MIT

## Author

Built by [@nikhilchintawar](https://github.com/nikhilchintawar)

---

**Made for [Claude Code](https://code.claude.com)** - The official CLI for Claude
