#!/bin/sh

FILE="/home/aditya/Desktop/file.txt"
LOG_FILE="/home/aditya/Desktop/file_changes.log"

# Check if file exists
if [ ! -f "$FILE" ]; then
	echo "Error: File '$FILE' not found"
	exit 1
fi

# Check if inotifywait is available
if ! command -v inotifywait > /dev/null 2>&1; then
	echo "Error: inotifywait not found. Please install inotify-tools"
	exit 1
fi

echo "Monitoring '$FILE' for changes..."
echo "Press Ctrl+C to stop"
echo ""

# Monitor file changes
while true; do
	inotifywait -q -e close_write "$FILE" 2>&1 | grep -v "Watches established" > /dev/null
	TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
	echo "[$TIMESTAMP] File '$FILE' has been modified" | tee -a "$LOG_FILE"
done
