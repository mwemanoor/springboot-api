#!/bin/bash

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
API_DIR="/home/ubuntu"

echo "[$TIMESTAMP] Starting update..." >> $LOG_FILE

# Update packages
apt update && apt upgrade -y >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    echo "[$TIMESTAMP] ERROR: Package update failed." >> $LOG_FILE
    exit 1
fi

# Pull latest API code
cd $API_DIR
git pull >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Git pull succeeded." >> $LOG_FILE
    systemctl restart springboot >> $LOG_FILE 2>&1
else
    echo "[$TIMESTAMP] ERROR: Git pull failed." >> $LOG_FILE
    exit 1
fi