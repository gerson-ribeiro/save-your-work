# save-your-work

Two Claude Code skills for automatic development session tracking. `/checkpoint` saves progress after every task and resumes from where you left off. `/resume` recovers crashed sessions instantly. Works with any project that has a plan file.

## Skills

### `/checkpoint` — Start a session

Run at the beginning of every development session.

- If `.project/PROGRESS_TRACKING.md` doesn't exist, generates it automatically from your plan file (`PLAN.md`, `IMPLEMENTATION_PLAN.md`, etc.)
- Shows where you left off and asks whether to continue or pick a specific task
- In auto mode, resumes silently without asking
- Saves a checkpoint after every completed task
- Adds a phase summary when a phase is fully done
- Marks the project as complete when all tasks are done

### `/resume` — Recover a crashed session

Run when a session was interrupted unexpectedly.

- Reads the last saved checkpoint
- Resumes immediately from the next pending task — no questions asked
- Continues auto-checkpointing just like a normal `/checkpoint` session

## Installation

**Via Claude Code plugin system:**

```
/plugin install save-your-work@github:gerson-ribeiro/save-your-work
```

**Manual installation (Windows):**

```bat
git clone https://github.com/gerson-ribeiro/save-your-work.git
cd save-your-work
install.bat
```

**Manual installation (macOS / Linux):**

```bash
git clone https://github.com/gerson-ribeiro/save-your-work.git
cd save-your-work
chmod +x install.sh && ./install.sh
```

## Example use cases

**Starting a new session on a long implementation:**
```
/checkpoint
# → reads PROGRESS_TRACKING.md, shows: "Last completed: Task 8. Next: Task 9 — Setup auth middleware. Continue?"
```

**Session crashes mid-task:**
```
/resume
# → ⚡ Resuming... Last completed: Task 8. Next: Task 9. Picks up immediately.
```

**First run on a project with a plan file:**
```
/checkpoint
# → PROGRESS_TRACKING.md doesn't exist. Reads PLAN.md, generates tracking file with all tasks as ⏳ Pending, then asks where to start.
```

**Running in auto mode (non-interactive pipeline):**
```
claude --automode /checkpoint
# → resumes from Next Task silently, checkpoints after every task without asking anything.
```

## How it works

Both skills read and write `.project/PROGRESS_TRACKING.md` in your project directory. This file tracks tasks, phases, and completion dates across sessions.

On first run, `/checkpoint` scans `.project/` for a plan file and generates the tracking file automatically. Supported plan file names: `PLAN.md`, `IMPLEMENTATION_PLAN.md`, `SPEC.md`, or any `.md` file containing phase/task headings.

## Tracking file format

```markdown
# My Project — Progress Tracking

**Status:** 🟡 In Progress
**Last Updated:** 2026-05-20
**Current Phase:** Phase 1 — Infrastructure (80%)
**Last Completed:** Task 4 — Setup database schema
**Next Task:** Task 5 — Create API endpoints
**Progress:** 4/10 tasks (40%)

---

## Phase 1 — Infrastructure

- [x] Task 1: Initialize repository  ✅ 2026-05-18
- [x] Task 2: Setup Docker  ✅ 2026-05-18
- [ ] Task 3: ...  ⏳ Pending
```

## License

MIT
