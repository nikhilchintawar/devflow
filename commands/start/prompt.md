# SESSION START - Load Project Context

Load pre-generated context files and prepare for development work.

---

## STEPS

### 1. Verify Files Exist
```
Check for:
- .claude/claude.md       (behavior rules)
- .claude/context.md      (project identity)
- .claude/architecture.md (system structure)
```

**If missing:** Inform user to run `/init` first. STOP.

---

### 2. Read Files (in order)

**Read in this sequence:**
1. `.claude/claude.md` → Behavior rules, prohibited actions, risk zones
2. `.claude/context.md` → What project is, domain constraints
3. `.claude/architecture.md` → Tech stack, structure, data flow

---

### 3. ASSUMPTION LOCK (CRITICAL)

**If ANY detail is not explicitly in:**
- `.claude/context.md`
- `.claude/architecture.md`
- Or directly visible in code

→ Mark it as **UNKNOWN**
→ **ASK before proceeding**

**DO NOT:**
- Infer from naming
- Assume from patterns
- Fill gaps with "probably"

---

### 4. Verify Understanding

**Before presenting summary, check:**

If ANY rule or constraint is unclear or contradictory:
- List it explicitly
- Request clarification
- DO NOT proceed until resolved

---

### 5. Present Summary

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

---

### 6. Wait for Task

- DO NOT suggest work
- DO NOT start unprompted
- WAIT for user instruction

---

## AUTHORITY HIERARCHY

When task conflicts with context:

```
1. .claude/claude.md (HIGHEST - behavior rules)
2. .claude/context.md (domain constraints)
3. .claude/architecture.md (structure patterns)
4. General instructions
```

**If user request conflicts:**
1. Stop immediately
2. Reference specific rule: "`.claude/claude.md` prohibits [X]"
3. Ask: "Should I proceed with explicit approval?"
4. Wait for confirmation

---

## NOW BEGIN

Execute steps 1-6 above.
