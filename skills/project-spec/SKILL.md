---
name: "project-spec"
description: "Turn a project idea into six signed-off planning files (product, users, requirements, tech decisions, tech requirements, build spec) that Claude Code builds from. Use for any new build: app, tool, plugin, SaaS, dashboard or client system, even when the user only says PRD, spec or 'I want to build'."
---

# Project spec

Turns a project idea into six planning files, one stage at a time, each signed off before the next. The sixth file, the build spec, is self-contained: Claude Code builds from it alone. The other five are the reasoning behind it.

This replaces the single PRD. Stages 01 to 03 together are the PRD. Small one-off edits, quick fixes and plain questions don't need this.

The core idea, from the RoughCut AI example this is based on: the spec is only as good as the detail you put in. A feature that isn't written down won't get built, and a feature that's written down but has no acceptance check may still get skipped. Every rule below exists to close one of those two gaps.

## Output

Six files in a `spec/` folder inside the project folder:

```
<project-folder>/spec/
  01-product.md
  02-users.md
  03-requirements.md
  04-tech-decisions.md
  05-tech-requirements.md
  06-build-spec.md
```

Where the project folder goes depends on where you're running:

- **A workspace with its own rules** (a CLAUDE.md, a vault with a projects index): follow those rules for the folder location. If a folder for the project already exists, add `spec/` inside it. Keep any index files and memory up to date as the project moves.
- **A code repo (Claude Code):** the repo is the project folder and the spec folder is `docs/spec/`, so the build can start without copying anything. Read `spec/` as `docs/spec/` everywhere below.
- **Anywhere else:** ask where the files should go.

UI references (screenshots, Figma links, competitor pages) go in `spec/references/` and are linked from the stage that uses them.

## Ground rules

- **One stage at a time, signed off.** A wrong guess about users leaks into the tech choices. Draft a stage, show it, get an explicit OK, then move on. Never write stage N+1 on an unapproved stage N.
- **Ask, don't guess.** Anything unknown goes in that file's "Open questions". When the user picks an answer or accepts a default, move it to "Assumptions confirmed" with the answer written in. A file with open questions left is not signed off.
- **Check what already exists first.** Before proposing custom work, look at the user's prior projects, starters and templates, existing specs, connected tools, and off-the-shelf products. If something already does the job, say so. Reuse beats rebuild.
- **Look facts up.** Competitor features and prices, library versions, licences, platform limits and API quotas change. Search before stating them, and cite the source in the file.
- **Push back.** If the idea, the scope or a choice looks wrong, say so plainly with the reason. No flattery, no agreeing to agree. Flag contradictions with earlier stages before writing anything.
- **Concrete over generic.** Numbers, names, real examples, real competitors. "Fast" becomes "rough cut of a 45-minute file in under 5 minutes on a 16 GB M1". If a sentence would fit any project, cut it or make it specific.
- **Trace everything.** Each requirement has an ID. Each tech decision names the requirement it serves. Each build-spec checkbox names the requirement it proves.
- **Writing.** Plain English, sentence-case headings, no em dashes, straight quotes, no AI filler words. If the user has writing rules, follow them in every file.

## The flow

### Step 0: intake

1. Let the user describe the idea in their own words. Don't interrupt with a form.
2. Restate it as a one-liner and check you understood.
3. Check what exists: prior projects in the workspace, similar products, starters. Report findings in two or three lines.
4. Agree the project name and folder. Create `spec/`.
5. Say which stage you're starting and roughly how many rounds of questions to expect.

### Steps 1 to 5: each stage

For each of stages 01 to 05:

1. **Ask the stage questions** listed under that stage below. Ask only what earlier answers haven't covered. Use AskUserQuestion when available: at most four questions per round, each with concrete options and your recommended one first. Offer a default for everything, so the user can answer fast.
2. **Research** anything factual the stage needs.
3. **Draft the file** using the template below. Fill every section. If a section truly doesn't apply, write one line saying why ("No accounts: single-user local tool"), don't delete it.
4. **Show it.** Send the file, and in chat give the three to five decisions that matter most plus the open questions. Don't paste the whole file.
5. **Revise** until the user says OK. Then write the "Assumptions confirmed" block and mark the file signed off in its header (`Status: signed off YYYY-MM-DD`).

**Fast mode.** If the user says "just draft them" or isn't around to answer, draft stages 01 to 05 in one go using your best defaults, mark every default as an open question, and stop for sign-off before writing 06. Say at the top which reading you took.

### Step 6: build spec

1. Generate `06-build-spec.md` from the signed-off 01 to 05. Never edit 06 by hand to add something new: put it in the earlier stage it belongs to, then regenerate. This stops 06 drifting from its sources.
2. Run the coverage check (below) and fix every gap.
3. Show it, get sign-off.
4. Tell the user how to hand it over (see "Handing to Claude Code").

### When things change later

If the user changes direction after a stage is signed off, don't patch around it. Re-ask the questions the change affects, update the earliest affected file, then every file after it. Record the change in a "Changes" note at the top of each touched file (date, what changed, why), like the platform pivot in the RoughCut 04 file. Then regenerate 06.

## Stage 01: product

**Ask about:** the mission behind it, the problem and who has it, how they cope today, which competitors exist and what they charge, what the "after" looks like, what it is deliberately not, business model (paid, free, open source, client work, internal tool), licence, platforms, what success looks like in a year, any UI references.

**Template:**

```markdown
# <Project name> *(working name if not final)*

Status: draft | signed off YYYY-MM-DD

## Mission
<The deeper goal beyond this one app, and how it shapes every downstream decision. Business model and why.>

## One-liner
<One sentence: what it does, for whom, and the main difference.>

## The problem
<Who has it, how often, how much time or money it costs, with numbers.>
<What existing tools do, named, with prices and limits, and the structural flaw they share. Cite sources.>
<The gap no one fills. That gap is the product.>

## The value
<The "after" picture: a concrete scene of the user getting the result.>
<The key interaction-model difference from the closest competitor.>
Versus <main competitor>, the user gets:
- <difference> : <why it matters, who it unlocks>

What it deliberately is not: <the scope it refuses and where that work goes instead>.

## Product category
<Category, who it competes with on which axis, and the white space it sits in.>

## Business model and licence
<Paid / free / open source / client project / internal. Pricing if any. Licence and why.>

## Platforms
<Where it runs on day one, and later.>

## What success looks like
<A concrete scene one year in. Plus measurable signals: users, revenue, time saved, client outcome.>

## UI and product references
<Each reference with what to keep from it: the specific affordances, layouts and controls.>

---

### Open questions
1. <question> : <your recommended default>

### Assumptions confirmed
1. **<topic> : RESOLVED.** <the answer and why>
```

## Stage 02: users

**Ask about:** the primary user and a secondary one if any, what drives them, their current workaround, tech comfort, their attitude to the thing the product changes (AI, privacy, cost, whatever is central), who is not the target. If there is more than one kind of user, ask about roles and permissions too. Then languages (RTL included: Arabic matters for GCC clients), accessibility needs, devices.

**Template:**

```markdown
# Users and usage

Status: draft | signed off YYYY-MM-DD

## Personas

### Primary: "<name>," the <short label>
- **Background:** <who, what they do, context>
- **What drives them:** <values and motivations, practical and principled>
- **Current workaround:** <what they do today and what it costs them>
- **Tech comfort:** <what they will and won't do: install, configure, terminal>
- **Relationship to <the central theme>:** <their stance, in one phrase if possible>
- **Devices and environment:** <desktop/mobile, OS, connection, language>

### Secondary: "<name>," the <short label>
<Same fields, plus why they matter and why they are not the beachhead.>

### Not the target
<Who this is not for, and what we won't bend the product toward to please them.>

## Roles and permissions
<If more than one kind of user: a table of role, what they can see, what they can do. Otherwise one line saying single-user.>

## Jobs to be done
- When **<persona> <situation>**, they want to **<motivation>**, so they can **<outcome>**.
<One per real job, including the edge jobs (refining, escalating, exporting, extending).>

## Primary user journey
1. **Discovery:** <where they hear of it and the pitch that lands>
2. **Setup:** <first run, one-time steps, how long>
3. **First use:** <the first thing they do and see>
4. **Aha moment:** <the specific moment it clicks>
5. **Optional power-up:** <advanced path, if any>
6. **Finish:** <how the work leaves the product>
7. **Ongoing use:** <why they come back>

## Core loop
**The repeated action:** <a -> b -> c -> d>

**What pulls users back:**
- <reason, concrete>

## Language, accessibility and locale
<Languages, RTL, date and currency formats, accessibility level (e.g. WCAG 2.2 AA), font needs.>

---

### Open questions
### Assumptions confirmed
```

## Stage 03: requirements

These are capability statements: what the product must do, not how. Tech waits for 04.

**Ask about:** the core features for v1 grouped by area, priority of each, what's out of scope, accounts and auth, the data it handles, integrations, performance targets on named hardware, offline needs, privacy and compliance, and the standard-states checklist below.

**IDs and priority.** Give every requirement an ID `FR-<AREA>-<NN>` (e.g. `FR-EDIT-03`) and every non-functional one `NFR-<NN>`. Tag each Must, Should, Could or Won't (v1). Every Must gets an acceptance line: how a tester would know it works.

**Standard-states checklist.** The undo that went missing from RoughCut is the typical failure: things every user expects but nobody says. For each item, either write a requirement or list it under out of scope with a reason:
undo and redo; empty states; loading and progress; error states and messages; confirm before destructive actions; autosave or save-and-reopen; search and filter; keyboard shortcuts; settings and preferences that persist; first-run and onboarding; offline or bad-connection behaviour; permissions per role; notifications; import and export; delete and restore; audit log; multi-language and RTL; accessibility; mobile layout; rate limits and quotas.

**Template:**

```markdown
# Functional requirements

Status: draft | signed off YYYY-MM-DD

Requirements say what the product must do, not how. Tech choices are in Stage 4. Each traces to the product (Stage 1) and the journey or core loop (Stage 2).

## Core features (MVP)

### <Area name>
- **FR-<AREA>-01 [Must]** The app must <capability>.
  *Acceptance:* <observable test: given X, when Y, then Z>
- **FR-<AREA>-02 [Should]** ...

<Repeat per area. Order areas by the user journey.>

## Standard states
<Each item from the checklist: requirement ID, or "out of scope: reason".>

## Account and auth
<Accounts or none, sign-up and login methods, roles, sessions, password reset, SSO. Or one line why there is none.>

## Data the product handles
- **<Entity>** : <what it is, where it lives, who owns it, how long it's kept>

## Integrations
- **<System>** : <what flows in or out, direction, auth method, quota limits>

## Non-functional requirements
- **NFR-01 Performance:** <numbers: load time, processing time, on what hardware>
- **NFR-02 Privacy and security:** <what data never leaves, encryption, compliance>
- **NFR-03 Availability / offline:** <...>
- **NFR-04 Scale:** <users, records, file sizes it must handle>
- **NFR-05 Platforms and browsers:** <...>
- **NFR-06 Accessibility and locale:** <...>
<Add others as needed: extensibility, licensing, cost ceilings.>

## Out of scope for MVP
- **<Feature>** : <why, and when it might come back (v2, never)>

---

### Open questions
### Assumptions confirmed
```

## Stage 04: tech decisions

For every layer: what was chosen, what else was considered, and why, traced to a requirement ID or the mission. This is where a future reader (or Claude Code) learns why not to swap something.

**Ask about:** fixed constraints first (house stack, client hosting, team skills, budget, existing code to reuse), then each layer. Check the user's prior projects and starters before proposing anything new. Look up current versions and licences, plus known issues and deprecations.

**Template:**

```markdown
# Tech decisions

Status: draft | signed off YYYY-MM-DD

For each decision: what was chosen, what else was considered, and why, traced to a requirement (Stage 3) or the mission and users (Stages 1 and 2).

> **Constraints going in:** <fixed stack, hosting, budget, team, deadlines, existing code reused>
> **Changes:** <date: pivot and why, if any>

## Overall architecture
- **Choice:** <shape of the system in two or three sentences>
- **Considered:** <alternatives with one-line reasons each was dropped>
- **Why:** <traced to FR/NFR IDs and the mission>

## <Layer: frontend / backend / database / auth / hosting / file storage / background jobs / AI and models / integrations / email and notifications / payments / search / analytics / CI/CD / testing / distribution>
- **Choice:** <tool and version>
- **Considered:** <...>
- **Why:** <... (FR-x, NFR-y)>
- **Landmines:** <known bugs, version pins, quota limits, from research. Cite sources.>

<One section per layer that exists. Skip a layer with one line if it doesn't apply.>

## Reused from existing work
<Starters, components, packages or patterns from earlier projects, and where they live.>

## Cost
<Monthly running cost at launch and at the NFR scale target: hosting, APIs, models, licences.>

## Licensing
<Project licence and each dependency's compatibility. Anything to verify at build time.>

## Top technical risks
1. **<Risk>** : <why it's risky, and the early spike that would prove or kill it>

---

### Open questions
### Assumptions confirmed
```

## Stage 05: tech requirements

The engineering blueprint: turns 03 and 04 into data models, the API or command surface, components, state, background jobs.

**Ask about:** only what 03 and 04 leave open: ID and time formats, soft vs hard delete, multi-tenancy, API style, error format, state ownership, which operations are long-running.

**Template:**

```markdown
# Technical requirements

Status: draft | signed off YYYY-MM-DD

The engineering blueprint. Tech context: <one line stack recap from Stage 4>.

## Architecture
<ASCII diagram of layers and how they talk.>
<The keystone idea in one paragraph: the one structure everything else depends on.>

## Data models
<Conventions: ID type, timestamps, time units, soft delete, tenancy.>

### <Entity>
| Field | Type | Notes |
|-------|------|-------|
| id | uuid | primary key |
| ... | ... | FK, constraints, indexes, enum values |

<Every entity from Stage 3 "Data the product handles". Add relationships and indexes.>

## API / command surface
<Style: REST, RPC, tool registry, server actions. Error format. Auth per endpoint.>

### <Group>
- **`<name>(<inputs>) -> <output>`** : <what it does> (FR-x). Auth: <role>. Errors: <cases>. <Long-running? emits progress.>

## Permissions
<Role x action table, or how authorisation is enforced.>

## Pages, screens and key components
### <Screen>
- **Purpose:** <...> (FR-x)
- **Components:** <list, with what each shows and does>
- **States:** <empty, loading, error, success>

## State management
<Source of truth, caching, how the UI hears about changes, undo/redo ownership, persistence.>

## Background and long-running tasks
- **<Task>** : <trigger, progress reporting, retries, failure handling>

## Security
<Input validation, secrets handling, auth tokens, rate limiting, local endpoints, file access, OWASP items that apply.>

## Logging and observability
<What gets logged, where errors go, what never gets logged (secrets, personal data).>

## Testing strategy
<Unit, integration, end-to-end. What must have tests. Test data. How to run them.>

## Environment and configuration
- `<VAR>` : <purpose, default>. No secrets in the repo.

## Migrations and seed data
<Schema versioning, seed or demo data, import of existing data.>

---

### Open questions
### Assumptions confirmed
```

## Stage 06: build spec

Generated from 01 to 05. It must stand alone: Claude Code should build from this file without opening the others.

**Template:**

```markdown
# Build spec: <project name>

> **This is the hand-off document for Claude Code.** It is self-contained: build from this file alone. It pulls together the product, users, requirements and tech decisions from stages 1 to 5. Where it says "see Stage N", that is optional background.

Status: signed off YYYY-MM-DD. Sources: 01 to 05 as of that date.

## 1. What we're building
<One paragraph: what, for whom, the main difference, the mission.>

## 2. Stack (decided, see Stage 4)
| Layer | Choice |
|-------|--------|
<Every layer from Stage 4, with versions.>

## 3. Architecture and principles
<Diagram from Stage 5.>

**Non-negotiable principles:**
1. <Principle> : <what it means in code>
<The rules that must hold in every milestone: privacy, non-destructive, state ownership, security, etc.>

## 4. Repository structure
<Tree with a short note per folder.>

## 5. Data model
<Every entity with its key fields. Point to Stage 5 for full tables.>

## 6. API / command surface
<Every operation, grouped, one line each.>

## 7. Screens
<Each screen with its components and states.>

## 8. Build plan (milestones)

### M0: de-risk (do this first)
<A throwaway spike of the top technical risk from Stage 4.>
- **Exit criteria:** <what must be proven, and the fallback if it fails>

### M<n>: <name>
- **Builds:** <FR IDs covered>
- **Tasks:** <list>
- **Exit criteria:** <tests pass, behaviour demonstrable>

## 9. Acceptance criteria
<One checkbox per Must requirement, in plain words, with its ID. Group into POC (proves the core idea) and MVP (shippable v1).>
- [ ] **FR-<AREA>-01** <observable behaviour>

## 10. Standard states
<From Stage 3: each covered item with its ID, each excluded item with "out of scope".>

## 11. Out of scope for MVP
<From Stage 3. Don't build these even if they look easy.>

## 12. Top risks and mitigations
<From Stage 4.>

## 13. Instructions for Claude Code
- Build milestone by milestone, in order. Finish M0 before any feature work.
- Keep a `PROGRESS.md` at the repo root: milestone status, decisions made, deviations from this spec and why.
- At the end of each milestone, run the tests and tick the acceptance boxes it covers. Don't move on with a failing box.
- Don't add features outside this spec. If something seems missing, note it in `PROGRESS.md` and ask.
- If a spec decision turns out to be wrong in practice, stop and explain. Don't silently swap a stack choice.
- Commit after each milestone with a message naming the milestone.
- Keep secrets out of the repo. Use the env vars in Stage 5.

---

*Companion files in `docs/spec/`: 01-product, 02-users, 03-requirements, 04-tech-decisions, 05-tech-requirements. This build spec is the entry point.*
```

## Coverage check (before signing off 06)

Run this and fix every gap before showing 06. It's what catches the "missing undo" class of problem.

```bash
cd <project-folder>/spec
# Must IDs, matching the template's "**FR-AREA-01 [Must]**" format
grep -oE '\*\*FR-[A-Z]+-[0-9]+ \[Must\]' 03-requirements.md | grep -oE 'FR-[A-Z]+-[0-9]+' | sort -u > /tmp/must.txt
wc -l < /tmp/must.txt   # if this prints 0, the pattern doesn't match the file: fix the pattern, don't skip the check
# each Must needs an acceptance checkbox in 06
for id in $(cat /tmp/must.txt); do grep -q -- "- \[ \] \*\*$id\*\*" 06-build-spec.md || echo "no checkbox: $id"; done
# each Must needs to sit in a milestone's Builds line
for id in $(cat /tmp/must.txt); do grep "Builds:" 06-build-spec.md | grep -qw -- "$id" || echo "no milestone: $id"; done
# every NFR in 03 needs a checkbox in 06
for id in $(grep -oE 'NFR-[0-9]+' 03-requirements.md | sort -u); do grep -q -- "- \[ \] \*\*$id\*\*" 06-build-spec.md || echo "no checkbox: $id"; done
```

Then check by reading:
- Every entity in 03 "Data the product handles" has a table in 05 and a line in 06.
- Every layer in 04 is in the 06 stack table, with the same choice.
- Every standard-states item is covered or listed out of scope, in both 03 and 06.
- Every 04 risk has a mitigation in 06, and the top one is M0.
- No file has open questions left.
- No em dashes or placeholder brackets left in any file.

Tell the user the result in one or two lines: "All 23 Must requirements are covered; added undo to M3."

## Handing to Claude Code

When 06 is signed off, tell the user:

1. Copy the `spec/` folder into the code repo as `docs/spec/`. Skip this if the spec was written in the repo already.
2. Start Claude Code in the repo and give it: "Read docs/spec/06-build-spec.md and build it, starting with M0. Follow section 13."
3. Come back here when a milestone ends or something in the spec turns out wrong, so the change goes into the right stage and 06 is regenerated.

Then update the project's status in any index files and memory the workspace keeps.