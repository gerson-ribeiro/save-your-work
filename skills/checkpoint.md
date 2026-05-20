---
name: checkpoint
description: Start a development session with automatic progress checkpoints. Reads or generates .project/PROGRESS_TRACKING.md, asks user what to do (or resumes automatically in automode), and saves a checkpoint after each completed task and phase.
---

# Checkpoint Dev Session

You are starting a development session with automatic progress tracking. Follow each step exactly and in order.

---

## Step 1: Initialize tracking file

If `.project/` directory does not exist in the current working directory, create it: `mkdir .project`. Then proceed to generate `PROGRESS_TRACKING.md` from scratch (follow the "file does NOT exist" path below, skipping the plan file search — create a minimal tracking file with a placeholder Phase 1 and prompt the user to add tasks manually).

Check if `.project/PROGRESS_TRACKING.md` exists in the current working directory.

**If the file does NOT exist:**

Locate a plan file in `.project/` using this priority order:
1. `PLAN.md`
2. `IMPLEMENTATION_PLAN.md`
3. `SPEC.md`
4. First `*.md` file whose content contains phase/task heading patterns (`## Phase`, `## Fase`, `- [ ]`)

Read the plan file. Extract:
- Project name (from the file's `#` heading, or the directory name as fallback)
- Phases (headings that follow patterns like `## Phase N`, `## Fase N`, `### Phase N`)
- Tasks per phase (lines matching `- [ ]`, `**Task N:**`, or `- Task N:`)

Generate `.project/PROGRESS_TRACKING.md` using this exact format:

```
# <Project Name> — Progress Tracking

**Status:** 🟡 In Progress
**Last Updated:** <today's date YYYY-MM-DD>
**Current Phase:** Phase 1 — <Phase 1 Name> (0%)
**Last Completed:** —
**Next Task:** Task 1 — <first task description>
**Progress:** 0/<total tasks> tasks (0%)

---

## Phase 1 — <Name>

- [ ] Task 1: <description>  ⏳ Pending
- [ ] Task 2: <description>  ⏳ Pending

---

## Phase 2 — <Name>

- [ ] Task 3: <description>  ⏳ Pending
```

**If the file DOES exist:**

Read and extract: Current Phase, Last Completed, Next Task, Progress count.

---

## Step 2: Check automode

Check the system context for auto mode activation. You are in automode if the system prompt contains "Auto Mode Active" or "Auto mode is active". You are NOT in automode if that signal is absent.

**If in automode:** skip directly to Step 3b.

**If NOT in automode:** proceed to Step 3a.

---

## Step 3a: Ask user (interactive mode only)

Present the current state:

```
📋 Current Phase: <phase name and completion %>
✅ Last Completed: <task description, or "— (not started)" if none>
⏳ Next Task: <next pending task>
📊 Progress: <X/Y tasks (Z%)>
```

Ask the user:
> "Continue from where you left off (<Next Task>) or start a specific task?"

Wait for the user's answer before proceeding. If they name a specific task, start there instead of Next Task.

---

## Step 3b: Resume automatically (automode)

Without asking anything, resume from the task listed in **Next Task** in the header of `PROGRESS_TRACKING.md`.

---

## Step 4: Auto-checkpoint — run after EVERY completed task

"Task" means one item from `.project/PROGRESS_TRACKING.md` — a line matching `- [ ] Task N: ...`. When you finish the work described by that line, that is task completion.

After you complete each task during this session, immediately update `.project/PROGRESS_TRACKING.md`:

**4a. Mark the task as done:**

Find the task line in the file. Change:
```
- [ ] Task N: <description>  ⏳ Pending
```
to:
```
- [x] Task N: <description>  ✅ <today's date YYYY-MM-DD>
```

**4b. Update the header block:**

Replace the header values:
```
**Last Updated:** <today's date YYYY-MM-DD>
**Current Phase:** Phase <N> — <Name> (<X%>)
**Last Completed:** Task <N> — <description>
**Next Task:** Task <N+1> — <description of next pending task, or "— (all done)" if none>
**Progress:** <completed count>/<total count> tasks (<Z%>)
```

Calculate `<X%>` as: (completed tasks in current phase / total tasks in current phase) × 100, rounded to nearest integer.

Count a task as completed only when marked `[x]`. If the current phase has zero tasks, use 0%. Include the task just marked as completed in the count before calculating.

**4c. Phase completion — only when the last task of a phase is done:**

After updating the task and header, if ALL tasks in the current phase are now marked `[x]`, append this block immediately after the last task in that phase (before the next `---`). If this is the last phase in the file (no following `---`), append the Phase Summary block at the end of the file.

```
### Phase Summary
**Completed on:** <today's date YYYY-MM-DD>
**Tasks:** <N>/<N>
**Notes:** <2-3 sentences describing what was built in this phase>
```

Generate the Notes content yourself based on what was implemented during this phase.

**4d. Project completion — only when the last task of the entire project is done:**

After updating the header, if `Next Task` is now `— (all done)`, also:
1. Set `**Status:** ✅ Complete` in the header
2. Show the user:
```
🎉 All tasks complete!
📊 Final progress: <X/X tasks (100%)>
```

---

## Reminders

- The last saved checkpoint is what `/resume` uses to recover from a crash — so checkpoint every task, no exceptions.
