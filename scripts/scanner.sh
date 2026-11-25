#!/bin/bash

CONFIG_FILE="configs/targets.conf"
LOG_FILE="logs/scan_results.log"

echo "--- Starting DevSecOps Scan ---" | tee -a $LOG_FILE

while IFS= read -r site
do
    if [ -z "$site" ]; then continue; fi

    echo "Checking: $site" | tee -a $LOG_FILE
    STATUS=$(curl -L -s -o /dev/null -w "%{http_code}" $site)

    if [ "$STATUS" == "200" ]; then
        echo "  [PASS] $site is UP" | tee -a $LOG_FILE
    else
        echo "  [FAIL] $site is DOWN (Status: $STATUS)" | tee -a $LOG_FILE
    fi
    echo "------------------------" | tee -a $LOG_FILE
done < "$CONFIG_FILE"

echo "--- Scan Completed ---" | tee -a $LOG_FILE
