#!/bin/zsh

SOURCE_DIR="/Users/sriharshamadireddy/Desktop/personalProject/dist"
DESTINATION_DIR="/home/ubuntu/personalProject/dist"
KEY_FILE="/Users/sriharshamadireddy/.ssh/develop-kp.pem"
USER="ubuntu"
EC2_IP="<ip>"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1"
}

log_message "Watching for changes in $SOURCE_DIR"

fswatch -o "$SOURCE_DIR" | while read -r
do
    log_message "Change detected. Syncing files..."
    rsync -av -e "ssh -i $KEY_FILE" "$SOURCE_DIR" "$USER@$EC2_IP:$DESTINATION_DIR"
    log_message "Sync complete."
done

