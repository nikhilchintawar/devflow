---
description: "Update .claude/ context files to reflect codebase changes"
model: "sonnet"
---

# UPDATE PROJECT CONTEXT

Intelligently update existing `.claude/` context files to reflect codebase changes.

**Purpose:** Refresh context after codebase evolution without losing human edits.

---

## EXECUTION WORKFLOW

### STEP 1: Verify Existing Context
```
Check for existing files:
- .claude/claude.md
- .claude/context.md
- .claude/architecture.md

IF missing → Error: "No context files found. Run /setup first."
```

---

### STEP 2: Read Existing Files

Read all three existing files to understand:
- Current state of documented rules
- Existing DETECTED/INFERRED/UNKNOWN labels
- Human-added notes and customizations
- Last generation date

**CRITICAL:** Preserve any human modifications not marked as DETECTED/INFERRED/UNKNOWN.

---

### STEP 3: Detect Codebase Changes

Analyze the current codebase (same methodology as `/setup`):
- Scan repository structure
- Identify entry points
- Determine current tech stack
- Map current architecture
- Identify current risk zones

---

### STEP 4: Compare & Identify Deltas

For each file, identify what has changed:

**Compare:**
- File counts and types
- Directory structure
- Entry points
- Dependencies
- Module organization
- Risk zones

**Categorize changes as:**
- ✅ **NEW** - Detected something that wasn't there before
- 📝 **CHANGED** - Existing detection has evolved
- ❌ **REMOVED** - Something that existed is now gone
- ⚪ **UNCHANGED** - No change detected

---

### STEP 5: Present Change Summary

Before updating files, show user a summary:

```markdown
# Context Update Summary

## Changes Detected

### Tech Stack
- ✅ NEW: [New dependency/framework found]
- 📝 CHANGED: [Existing item modified]
- ❌ REMOVED: [Item no longer detected]

### Architecture
- ✅ NEW: [New module/directory]
- 📝 CHANGED: [File counts, structure changes]
- ❌ REMOVED: [Deleted modules]

### Risk Zones
- ✅ NEW: [Newly detected risk areas]
- 📝 CHANGED: [Modified risk patterns]
- ❌ REMOVED: [Risk areas no longer present]

### File Metrics
- Total files: [old count] → [new count]
- Languages: [changes]
- Entry points: [changes]

## Human Edits Detected
[List any sections that appear to be human-modified]
→ These will be preserved during update

## Next Steps
- Type `apply` to update all three files with detected changes
- Type `preview [file]` to see proposed changes for specific file
- Type `cancel` to abort update
```

---

### STEP 6: Update Strategy

**For each file:**

1. **Preserve human customizations:**
   - Keep any text in "Human Review Required" sections
   - Keep any manually added items (not marked DETECTED/INFERRED/UNKNOWN)
   - Keep any custom notes or warnings

2. **Update detected items:**
   - Refresh all DETECTED labels with current evidence
   - Update INFERRED items based on new patterns
   - Convert UNKNOWN to DETECTED if now discoverable
   - Mark removed items with ~~strikethrough~~ and "REMOVED: no longer detected"

3. **Add new findings:**
   - Add newly detected patterns
   - Add newly discovered risk zones
   - Add new dependencies or modules

4. **Update metadata:**
   - Change "Generated YYYY-MM-DD" date to current date
   - Add "Updated YYYY-MM-DD" note

---

### STEP 7: Generate Updated Files

Use the same templates as `/setup` but with intelligent merging:

**claude.md updates:**
- Refresh High-Risk Zones with current file references
- Update Prohibited Actions based on new risk areas
- Preserve manually added constraints
- Update Code Style Notes with new tooling

**context.md updates:**
- Refresh "What This Project Does" with new entry points
- Update External Dependencies with new integrations
- Refresh Domain Constraints with new risk patterns
- Preserve human-added context

**architecture.md updates:**
- Update Tech Stack table with current versions
- Refresh Project Structure tree
- Update Module Boundaries with new modules
- Refresh Data Flow examples if entry points changed
- Update file counts and metrics

---

### STEP 8: Conflict Resolution

**IF human edit conflicts with new detection:**

```
⚠️ Conflict Detected:

File: .claude/context.md
Section: External Dependencies

Current (human-edited):
- PostgreSQL database (DETECTED: config/database.yml)

New detection:
- No database detected

Options:
1. Keep human version (trust manual edit)
2. Use new detection (trust code scan)
3. Mark as UNKNOWN (unable to confirm)

Choose [1/2/3]:
```

Wait for user decision before proceeding.

---

### STEP 9: Write Updated Files

After confirmation, update all three files with:
- ✅ Refreshed DETECTED items
- ✅ New discoveries
- ✅ Preserved human edits
- ✅ Updated generation dates
- ✅ Change notes at top of each file

---

## UPDATE RULES (MANDATORY)

### 1. Preserve Human Intelligence
```
✅ ALWAYS preserve:
- Manual additions to "Human Review Required"
- Custom constraints added by humans
- Notes marked with [HUMAN], [MANUAL], or similar
- Sections with no DETECTED/INFERRED/UNKNOWN labels

❌ NEVER overwrite:
- Human-resolved UNKNOWN items
- Manually added prohibited actions
- Custom domain knowledge
```

### 2. Evidence-Based Updates
```
Only update items where:
- Code evidence has demonstrably changed
- New patterns are detected
- Items are verifiably removed

Do NOT update based on:
- Speculation about changes
- Assumed improvements
- Naming conventions alone
```

### 3. Change Tracking
```
For significant changes, add notes:

Example:
## Tech Stack
| Component | Technology | Evidence |
|-----------|------------|----------|
| Framework | Next.js 14 | DETECTED: package.json:12 (Updated 2026-01-04: was Next.js 13) |
```

### 4. Deletion Handling
```
When something is removed:
- Don't delete the line immediately
- Mark with ~~strikethrough~~ and REMOVED note
- Keep for one update cycle for reference

Example:
- ~~Express routes~~ (REMOVED 2026-01-04: no longer detected)
```

---

## EDGE CASES

### Case 1: Major Refactor Detected
```
IF > 30% of structure changed:
→ Warn user: "Major changes detected. Consider running /setup instead for clean regeneration."
→ Ask: "Continue with update or regenerate?"
```

### Case 2: No Changes Detected
```
IF no differences found:
→ Report: "No codebase changes detected since [last update date]."
→ Ask: "Force regenerate anyway? (y/n)"
```

### Case 3: Files Manually Deleted
```
IF .claude/*.md files missing:
→ Error: "Context files incomplete. Run /setup to regenerate."
```

### Case 4: Conflicting Changes
```
IF multiple conflicts detected:
→ Present all conflicts at once
→ Allow batch resolution (all option 1, all option 2, or individual)
```

---

## OUTPUT FORMAT

### Pre-Update Summary
```markdown
# Context Update Ready

**Last Updated:** [date from existing files]
**Codebase Scanned:** [file count] files

## Summary
- ✅ [N] new items detected
- 📝 [N] items changed
- ❌ [N] items removed
- ⚪ [N] items unchanged
- 🔒 [N] human edits preserved

## Changes by File
**claude.md:** [N] changes
**context.md:** [N] changes
**architecture.md:** [N] changes

Type `apply` to update files.
```

### Post-Update Confirmation
```markdown
# Context Files Updated ✅

**Updated:** 2026-01-04

## Changes Applied
- claude.md: [N] updates
- context.md: [N] updates
- architecture.md: [N] updates

## Preserved
- [N] human edits maintained
- [N] custom constraints kept

## Next Steps
- Review changes: `git diff .claude/`
- Commit updates: `git add .claude/ && git commit -m "Update project context"`
- Use `/start` to load refreshed context
```

---

## ANTI-PATTERNS (FORBIDDEN)

**DO NOT:**
```
❌ Regenerate from scratch (that's /setup's job)
❌ Remove human customizations
❌ Update items without code evidence
❌ Add improvement suggestions
❌ Speculate about "likely" changes
❌ Assume removed items are mistakes
```

**DO:**
```
✅ Preserve human intelligence
✅ Only update with hard evidence
✅ Ask when conflicted
✅ Track what changed and why
✅ Respect manual overrides
```

---

## EXECUTION START

### Step 0: Acknowledge
```
Checking for existing context files...
Scanning codebase for changes...
Comparing current state with documented state...
```

### Execute Steps 1-9
[Follow workflow above]

### Present Summary & Wait
Show change summary and wait for user command:
- `apply` - Write updates
- `preview [file]` - Show specific file changes
- `cancel` - Abort update

---

**NOW BEGIN UPDATE ANALYSIS**
