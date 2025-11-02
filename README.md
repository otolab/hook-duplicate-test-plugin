# Hook Duplicate Test Plugin

This plugin is designed to reproduce and demonstrate the hook duplicate execution issue in Claude Code.

## Issue Description

When hooks are registered via plugins, they appear to be executed twice:
- Each hook execution spawns two separate processes (different PIDs)
- The hooks appear duplicated in `/hooks` command output
- This affects all hook types including SessionStart, Notification, and PreCompact
- The issue has been present since the plugin system was implemented

## What This Plugin Does

This plugin registers three types of hooks:
- `SessionStart`: Triggered when a new session starts
- `Notification`: Triggered on notifications
- `PreCompact`: Triggered before conversation compaction

Each hook execution is logged to `~/claude-hook-duplicate-test.log` with:
- Timestamp (with milliseconds)
- Hook type
- Process ID (PID)

## Installation

### Method 1: From GitHub (after publishing)

```bash
/plugin marketplace add otolab/hook-duplicate-test-plugin
/plugin install hook-duplicate-test@otolab-marketplace
```

### Method 2: Local installation

1. Clone this repository
2. Copy the `plugins/hook-duplicate-test` directory to `~/.claude/plugins/`
3. Restart Claude Code

## Reproduction Steps

1. Install this plugin
2. Check registered hooks:
   ```bash
   /hooks
   ```
   **Expected**: Each hook type appears once
   **Actual**: Each hook type appears **twice**

3. Start a new session (triggers SessionStart hook)
4. Check the log file:
   ```bash
   cat ~/claude-hook-duplicate-test.log
   ```
   **Expected**: One log entry per hook execution
   **Actual**: **Two log entries** with different PIDs

## Example Log Output

If the bug is present, you'll see something like:

```
[2025-11-03 10:00:00.123] Hook: SessionStart | PID: 12345
[2025-11-03 10:00:00.125] Hook: SessionStart | PID: 12346
```

Notice:
- Two entries for the same hook
- Different PIDs (12345 vs 12346)
- Nearly identical timestamps

## Cleanup

To remove test logs:

```bash
rm ~/claude-hook-duplicate-test.log
```

## Related Issues

- Issue #10777: Skill execution message appears twice (display-only issue)
- Issue #6674: Hook navigation infinite loop (UI issue)

This issue is different - it's actual duplicate **execution**, not just display.

## License

MIT
Issue #10871: https://github.com/anthropics/claude-code/issues/10871
