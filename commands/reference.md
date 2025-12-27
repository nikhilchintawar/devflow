# Session Start - Extended Reference

This file contains edge cases, anti-patterns, and protocols for `/start` command.
**Not loaded by default** - reference only when needed.

---

## EDGE CASES

### Context Files Are Drafts

**If files contain "DRAFT - Generated [date]":**
```
Inform user:
"Context files marked as DRAFT. Review recommended.
- Approve if accurate
- Edit specific sections if needed
- Or proceed as-is (noting UNKNOWN items)"
```

### Directory Missing

**If `.claude/` doesn't exist:**
```
"No context found. Run `/init` first to generate:
- .claude/claude.md
- .claude/context.md
- .claude/architecture.md"
```

### Partial Context

**If some files missing:**
```
"Incomplete context:
✅ [existing files]
❌ [missing files]

Run `/init` to generate missing files, or proceed with partial?"
```

### Additional Context Files

**If user says "also read X.md":**
- Read the file
- Incorporate into model
- Note: `.claude/` files still take precedence

### Outdated Context

**If context seems stale:**
```
Signs:
- Code contradicts context.md
- Major refactors since [date]
- Files > 30 days old

Suggest: "Run `/init` to refresh context"
```

---

## ANTI-PATTERNS

**Never do these:**

```
❌ Start work without verifying context files exist
❌ Suggest improvements unprompted
❌ Ignore prohibited actions from claude.md
❌ Make assumptions not backed by context
❌ Proceed silently when rules conflict with request
❌ Read files out of order
❌ Infer from naming conventions
❌ Fill gaps with "probably/likely"
```

---

## CONTEXT REFRESH PROTOCOL

**Suggest refresh when:**
- Significant code changes vs context
- User mentions major refactor/migration
- Files > 30 days old (if visible)
- User asks "is this up to date?"

**How to suggest:**
```
"Context may be outdated (generated [date]).
Consider: `/init` to regenerate"
```

---

## RESPONSE TEMPLATES

### Success

```markdown
# Session Ready

**Project:** [name]
**Type:** [type]
**Stack:** [tech]

## Context Loaded
✅ Behavior rules
✅ Project context
✅ Architecture

## ⚠️ High-Risk Zones
- [zone] - [why]

## ❌ Prohibited Without Approval
- [action]

## 🛑 Stop & Ask Before
- [condition]

---
What should I work on?
```

### Failure

```markdown
# Cannot Start

Context files missing. Run `/init` first.
```

### Clarification Needed

```markdown
# Context Loaded - Clarification Needed

Unclear/contradictory rules found:
- [rule 1] - [why unclear]
- [rule 2] - [contradiction]

Please clarify before proceeding.
```

---

## CONFLICT RESOLUTION

**If context files contradict each other:**

```
Priority:
1. .claude/claude.md (behavior overrides all)
2. .claude/context.md (domain constraints)
3. .claude/architecture.md (structural info)

If still unclear → ASK USER
```

**If context contradicts visible code:**

```
Mention: "Context says X, but code shows Y at [file:line]"
Suggest: "Update context or clarify which is correct?"
```

---

## ASSUMPTION LOCK EXAMPLES

### ❌ Bad (Making Assumptions)

```
User: "Add caching"
Assistant: "I'll add Redis caching since this is a web app"
         ↑ Assumed Redis, assumed web app needs it
```

### ✅ Good (Locked Assumptions)

```
User: "Add caching"
Assistant: "Context doesn't specify caching strategy.
           Questions:
           - Which layer (database/API/client)?
           - What should be cached?
           - Redis/Memcached/in-memory?

           Or should I analyze code first?"
```

### ❌ Bad (Inferring from Names)

```
File: src/payments/
Assistant: "This handles Stripe payments"
         ↑ Inferred Stripe from directory name
```

### ✅ Good (Evidence-Based)

```
File: src/payments/
Assistant: *Reads file, finds import { Stripe } from 'stripe'*
          "This uses Stripe (DETECTED: stripe import)"
```

---

## VERIFICATION HOOK EXAMPLES

### Example 1: Contradictory Rules

```
.claude/claude.md: "❌ No refactoring without approval"
.claude/architecture.md: "Code organization: actively being refactored"

→ List both
→ Ask: "Should I refactor (architecture.md) or not (claude.md)?"
```

### Example 2: Unclear Constraint

```
.claude/claude.md: "Be careful with auth"

→ Too vague
→ Ask: "What specifically is prohibited in auth?
      - Changing logic?
      - Adding endpoints?
      - Fixing bugs?"
```

### Example 3: Missing Critical Info

```
.claude/context.md: "Money/Payments: YES"
.claude/claude.md: [No mention of payment constraints]

→ Inconsistent
→ Ask: "Payments detected but no rules specified.
       Should payments be high-risk/prohibited?"
```

---

## SESSION TYPES

### Standard Session (90% of time)

```
/start
→ Load context
→ Present summary
→ Wait for task
```

### Quick Session (context already known)

```
User: "I've already run /start, let's continue from yesterday"
→ Skip full summary
→ Just confirm: "Continuing with [project]. What's next?"
```

### Debug Session (something wrong)

```
User: "/start --verbose"
→ Show detailed load process
→ List each file read
→ Show parse errors if any
```

---

## COMMON FAILURE MODES

### Mode 1: Ignoring Assumption Lock

```
Problem: Claude infers without evidence
Fix: Every claim must have (DETECTED: ...) or be UNKNOWN
```

### Mode 2: Skipping Verification Hook

```
Problem: Claude proceeds despite unclear rules
Fix: Explicit check at step 4 before summary
```

### Mode 3: Silent Rule Override

```
Problem: User asks for prohibited action, Claude does it
Fix: Stop, reference rule, ask for approval
```

### Mode 4: Outdated Context

```
Problem: Context doesn't match current code
Fix: Detect, mention, suggest /init refresh
```

---

## QUICK REFERENCE CHECKLIST

**Before ANY work starts:**

```
[ ] Context files verified to exist
[ ] Files read in order (claude → context → architecture)
[ ] Assumption lock engaged (no speculation)
[ ] Verification hook passed (no unclear rules)
[ ] Summary presented to user
[ ] Waiting for explicit task (not suggesting)
```

**During work:**

```
[ ] Following .claude/claude.md rules
[ ] Stopping for prohibited actions
[ ] Asking when hitting stop conditions
[ ] Marking unknowns as UNKNOWN (not guessing)
```

**If stuck:**

```
[ ] Check context files for guidance
[ ] Reference this document for edge cases
[ ] Ask user for clarification
[ ] DO NOT proceed on assumptions
```
