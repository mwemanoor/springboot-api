#!/bin/bash

# update_server.sh
# Purpose: Automate server and API updates with email alert on failure

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
GIT_DIR="/home/ubuntu/springboot-api"
PROJECT_DIR="/home/ubuntu/springboot-api/rest-api"
SERVICE_NAME="springboot"
EMAIL_TO="mwemanoor@gmail.com"
EMAIL_SUBJECT="🚨 Server Update Failed on $(hostname)"

log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

send_error_email() {
    ERROR_MESSAGE="$1"
    echo -e "$ERROR_MESSAGE\n\nSee full log at $LOG_FILE" | mail -s "$EMAIL_SUBJECT" "$EMAIL_TO"
}

fail_and_exit() {
    log "ERROR: $1"
    send_error_email "$1"
    exit 1
}

log "Starting update..."

# 1. Check if Git directory exists
[ -d "$GIT_DIR" ] || fail_and_exit "Git directory $GIT_DIR missing."

# 2. Check if it's a Git repo
cd "$GIT_DIR" || fail_and_exit "Failed to cd into $GIT_DIR."
[ -d ".git" ] || fail_and_exit "Not a Git repository in $GIT_DIR."

# 3. System update
log "Updating Ubuntu packages..."
apt update && apt upgrade -y >> "$LOG_FILE" 2>&1 || fail_and_exit "System update failed."

# 4. Pull latest code
log "Pulling latest code from GitHub..."
git pull origin main >> "$LOG_FILE" 2>&1 || fail_and_exit "Git pull failed."

# 5. (Optional) Build the project
# Uncomment if you need to build
# log "Building the project..."
# cd "$PROJECT_DIR" || fail_and_exit "Failed to cd into $PROJECT_DIR."
# mvn clean package >> "$LOG_FILE" 2>&1 || fail_and_exit "Maven build failed."

# 6. Restart the service
log "Restarting the service $SERVICE_NAME..."
sudo systemctl restart "$SERVICE_NAME" >> "$LOG_FILE" 2>&1 || fail_and_exit "Failed to restart service $SERVICE_NAME."

log "Update completed successfully."
