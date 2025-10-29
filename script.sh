#!/bin/sh

echo "Enter full path of the file:"
read file
LOG="/home/aditya/Desktop/file_changes.log"

if [ ! -f "$file" ]; then
    echo "Error: '$file' not found"
    exit 1
fi

trap 'echo "\nMonitoring stopped"; exit 0' INT TERM

echo "Monitoring '$file' for changes..."
echo "Ctrl+C to stop"
echo ""

prev_state=$(ls -l "$file")

while true; do
    sleep 2
    
    curr=$(ls -l "$file")
    
    if [ "$curr" != "$prev_state" ]; then
        time=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$time] File '$file' has been modified" | tee -a "$LOG"
        prev_state="$curr"
    fi
done
