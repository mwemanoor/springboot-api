#!/bin/bash

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
PROJECT_DIR="/home/ubuntu/springboot-api"

echo "[$TIMESTAMP] Starting update..." >> $LOG_FILE

# 1. Check if project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Project directory $PROJECT_DIR missing" >> $LOG_FILE
  exit 1
fi

# 2. Check if it's a Git repo
cd "$PROJECT_DIR" || exit 1
if [ ! -d ".git" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Not a Git repository" >> $LOG_FILE
  exit 1
fi

# 3. Proceed with updates
apt update && apt upgrade -y >> $LOG_FILE 2>&1
git pull origin main >> $LOG_FILE 2>&1 || {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Git pull failed" >> $LOG_FILE
  exit 1
}

# 4. Rebuild and restart
mvn clean package >> $LOG_FILE 2>&1
sudo systemctl restart springboot >> $LOG_FILE 2>&1

## Update packages
#apt update && apt upgrade -y >> $LOG_FILE 2>&1
#if [ $? -ne 0 ]; then
#    echo "[$TIMESTAMP] ERROR: Package update failed." >> $LOG_FILE
#    exit 1
#fi
#
## Pull latest Project  code
#cd $API_DIR
#git pull >> $LOG_FILE 2>&1
#if [ $? -eq 0 ]; then
#    echo "[$TIMESTAMP] Git pull succeeded." >> $LOG_FILE
#    systemctl restart springboot >> $LOG_FILE 2>&1
#else
#    echo "[$TIMESTAMP] ERROR: Git pull failed." >> $LOG_FILE
#    exit 1
#fi
#
#
#
#
## 1. Check if project directory exists
#if [ ! -d "$PROJECT_DIR" ]; then
#  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Project directory $PROJECT_DIR missing" >> $LOG_FILE
#  exit 1
#fi
#
## 2. Check if it's a Git repo
#cd "$PROJECT_DIR" || exit 1
#if [ ! -d ".git" ]; then
#  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Not a Git repository" >> $LOG_FILE
#  exit 1
#fi
#
## 3. Proceed with updates
#apt update && apt upgrade -y >> $LOG_FILE 2>&1
#git pull origin main >> $LOG_FILE 2>&1 || {
#  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Git pull failed" >> $LOG_FILE
#  exit 1
#}
#
## 4. Rebuild and restart
#mvn clean package >> $LOG_FILE 2>&1
#sudo systemctl restart springboot >> $LOG_FILE 2>&1