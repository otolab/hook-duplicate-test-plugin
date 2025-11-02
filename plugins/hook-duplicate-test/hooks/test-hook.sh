#!/bin/bash

# Hook duplicate execution test script
# This script logs each execution with timestamp and process ID

HOOK_TYPE="$1"
LOG_FILE="$HOME/claude-hook-duplicate-test.log"

# Get current timestamp with milliseconds
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    MILLIS=$(($(date +%s%N)/1000000 % 1000))
    TIMESTAMP="${TIMESTAMP}.${MILLIS}"
else
    # Linux
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S.%3N')
fi

# Get process ID
PID=$$

# Log the execution
echo "[${TIMESTAMP}] Hook: ${HOOK_TYPE} | PID: ${PID}" >> "${LOG_FILE}"

# Also output to stdout for visibility
echo "Hook ${HOOK_TYPE} executed at ${TIMESTAMP} (PID: ${PID})"

exit 0
