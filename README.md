# File Monitoring System

A lightweight shell script-based file monitoring system that tracks changes to files in real-time and maintains a detailed log of all modifications.

## Features

- 🔍 **Real-time Monitoring** - Continuously watches a file for any changes
- 📝 **Automatic Logging** - Records all file modifications with timestamps
- 🎯 **Simple Interface** - Easy-to-use menu-driven system
- 🔄 **Interactive Controls** - Start/stop monitoring with keyboard shortcuts
- 📊 **Log Management** - View and clear monitoring logs easily

## Prerequisites

- Unix-like operating system (Linux, macOS, or WSL on Windows)
- Bash/Shell environment
- Basic file system permissions

## Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/file-monitoring-system.git
cd file-monitoring-system
```

Make it executable:

```bash
chmod +x file_monitor.sh
```

## How to Run

1.**Change log file directory:**
   ```bash
   ./file_changes.log
   ```

2. **Start the script:**
   ```bash
   ./file_monitor.sh
   ```

3. **Set a file to monitor:**
   - Select option `1` from the menu
   - Enter the full path of the file you want to monitor (e.g., `/home/user/test.txt`)

4. **Start monitoring:**
   - Select option `2` from the menu
   - The script will now watch for changes to your file
   - Press `Ctrl+C` to stop monitoring and return to the menu

5. **View logs:**
   - Select option `3` to view all recorded changes

## Usage Example

```bash
# Run the script
./file_monitor.sh

# In the menu, select:
# 1 - Set file to monitor
# Enter path: /home/aditya/test.txt

# 2 - Start monitoring
# (Script will now watch for changes)

# Make changes to the file in another terminal:
echo "test" >> /home/aditya/test.txt

# You'll see output like:
# [2025-10-29 14:30:45] File '/home/aditya/test.txt' has been modified
```

## Menu Options

| Option | Description |
|--------|-------------|
| 1 | Set file to monitor - Specify the file path you want to track |
| 2 | Start monitoring - Begin watching the file for changes |
| 3 | View monitoring log - Display all recorded modifications |
| 4 | Clear log - Remove all entries from the log file |
| 5 | Show current file - Display currently monitored file and its status |
| 6 | Exit - Close the application |

## Configuration

The log file is stored at:
```
/home/aditya/Desktop/file_changes.log
```

To change the log location, edit the `LOG` variable at the top of the script:

```bash
LOG="/your/custom/path/file_changes.log"
```

## Screenshots

<img width="607" height="414" alt="image" src="https://github.com/user-attachments/assets/ab6f2b6d-254f-490c-8fbf-7b430cf62913" /> <img width="666" height="416" alt="image" src="https://github.com/user-attachments/assets/1a4d08d6-14cb-4668-9dab-f9f84a0c8051" /> 
<img width="514" height="237" alt="image" src="https://github.com/user-attachments/assets/57c3ac94-81d6-4bb6-9540-80d84a3f4f30" /> <img width="869" height="514" alt="image" src="https://github.com/user-attachments/assets/35094317-db16-4fef-9038-65b822c13b3b" />
<img width="510" height="351" alt="image" src="https://github.com/user-attachments/assets/f2567415-37f8-4aef-bd49-f6b0422cb5c1" />
<img width="645" height="229" alt="image" src="https://github.com/user-attachments/assets/5115963d-a182-452e-8cc0-c742de184e87" />
<img width="686" height="244" alt="image" src="https://github.com/user-attachments/assets/f609af01-6ab2-4395-8642-a14a30cb40be" />

## How It Works

The script uses the `ls -l` command to capture file metadata and compares it every 2 seconds. When a change is detected (modification time, size, or permissions), it logs the event with a timestamp to the log file.
