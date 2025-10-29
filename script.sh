#!/bin/sh

LOG="/home/aditya/Desktop/file_changes.log"
MONITORED_FILE=""

display_menu() {
    clear
    echo "======================================"
    echo "      FILE MONITORING SYSTEM"
    echo "======================================"
    echo "1. Set file to monitor"
    echo "2. Start monitoring"
    echo "3. View monitoring log"
    echo "4. Clear log"
    echo "5. Show current file"
    echo "6. Exit"
    echo "======================================"
    [ -n "$MONITORED_FILE" ] && echo "Current file: $MONITORED_FILE"
    echo ""
}

set_file() {
    echo ""
    echo "Enter full path of the file to monitor:"
    read file
    
    if [ ! -f "$file" ]; then
        echo "Error: '$file' not found"
        echo "Press Enter to continue..."
        read dummy
        return 1
    fi
    
    MONITORED_FILE="$file"
    echo "File set successfully: $MONITORED_FILE"
    echo "Press Enter to continue..."
    read dummy
}

start_monitoring() {
    if [ -z "$MONITORED_FILE" ]; then
        echo "Error: No file selected. Please set a file first (Option 1)"
        echo "Press Enter to continue..."
        read dummy
        return 1
    fi
    
    if [ ! -f "$MONITORED_FILE" ]; then
        echo "Error: File '$MONITORED_FILE' no longer exists"
        MONITORED_FILE=""
        echo "Press Enter to continue..."
        read dummy
        return 1
    fi
    
    clear
    echo "======================================"
    echo "Monitoring '$MONITORED_FILE'"
    echo "Press Ctrl+C to stop and return to menu"
    echo "======================================"
    echo ""
    
    trap 'echo "\nMonitoring stopped"; sleep 1; return 0' INT TERM
    
    prev_state=$(ls -l "$MONITORED_FILE")
    
    while true; do
        sleep 2
        
        curr=$(ls -l "$MONITORED_FILE" 2>/dev/null)
        
        if [ -z "$curr" ]; then
            echo "Warning: File no longer exists"
            break
        fi
        
        if [ "$curr" != "$prev_state" ]; then
            time=$(date '+%Y-%m-%d %H:%M:%S')
            echo "[$time] File '$MONITORED_FILE' has been modified" | tee -a "$LOG"
            prev_state="$curr"
        fi
    done
    
    trap - INT TERM
}

view_log() {
    echo ""
    if [ ! -f "$LOG" ]; then
        echo "No log file found at: $LOG"
    else
        echo "======================================"
        echo "MONITORING LOG"
        echo "======================================"
        cat "$LOG"
        echo "======================================"
    fi
    echo ""
    echo "Press Enter to continue..."
    read dummy
}

clear_log() {
    echo ""
    if [ ! -f "$LOG" ]; then
        echo "No log file to clear"
    else
        echo "Are you sure you want to clear the log? (y/n)"
        read confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            > "$LOG"
            echo "Log cleared successfully"
        else
            echo "Operation cancelled"
        fi
    fi
    echo "Press Enter to continue..."
    read dummy
}

show_current_file() {
    echo ""
    if [ -z "$MONITORED_FILE" ]; then
        echo "No file currently set"
    else
        echo "Currently monitored file: $MONITORED_FILE"
        if [ -f "$MONITORED_FILE" ]; then
            echo "File exists: Yes"
            ls -lh "$MONITORED_FILE"
        else
            echo "File exists: No (file may have been deleted)"
        fi
    fi
    echo ""
    echo "Press Enter to continue..."
    read dummy
}

while true; do
    display_menu
    echo -n "Enter your choice [1-6]: "
    read choice
    
    case $choice in
        1) set_file ;;
        2) start_monitoring ;;
        3) view_log ;;
        4) clear_log ;;
        5) show_current_file ;;
        6) 
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select 1-6"
            echo "Press Enter to continue..."
            read dummy
            ;;
    esac
done
