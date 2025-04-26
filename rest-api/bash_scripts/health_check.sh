#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Check CPU, Memory, Disk
echo "[$TIMESTAMP] Health Check:" >> $LOG_FILE
echo "CPU Usage: $(top -bn1 | grep load | awk '{printf "%.2f%%\n", $(NF-2)}')" >> $LOG_FILE
echo "Memory Usage: $(free -m | awk 'NR==2{printf "%.2f%%\n", $3*100/$2}')" >> $LOG_FILE
echo "Disk Space: $(df -h / | awk 'NR==2{print $5}')" >> $LOG_FILE

# Check Nginx
if systemctl is-active --quiet nginx; then
    echo "Nginx is running." >> $LOG_FILE
else
    echo "WARNING: Nginx is down!" >> $LOG_FILE
fi

# Test API endpoints
ENDPOINTS=("http://localhost:8080/students" "http://localhost:8080/subjects")
for endpoint in "${ENDPOINTS[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" $endpoint)
    if [ "$status" -eq 200 ]; then
        echo "SUCCESS: $endpoint returned 200" >> $LOG_FILE
    else
        echo "WARNING: $endpoint returned $status" >> $LOG_FILE
    fi
done