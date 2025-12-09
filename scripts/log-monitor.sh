#!/usr/bin/env bash
#
# log-monitor.sh
# Purpose: Quickly analyze authentication logs for security-relevant events.
# Author: Ibrahim
# Project: Linux Hardening & Security Audit

LOGFILE="/var/log/auth.log"

echo "======== SECURITY LOG MONITOR ========"
echo "Log source: $LOGFILE"
echo "Timestamp: $(date)"
echo

if [ ! -f "$LOGFILE" ]; then
  echo "[ERROR] Log file not found: $LOGFILE"
  exit 1
fi

echo "[1] Failed login attempts (last 200 lines)"
grep -i "failed\|authentication failure" "$LOGFILE" | tail -n 200
echo

echo "[2] Successful logins"
grep -i "session opened for user" "$LOGFILE" | tail -n 50
echo

echo "[3] Suspicious repeated failures (possible brute force)"
grep -i "failed password" "$LOGFILE" | awk '{print $(NF)}' | sort | uniq -c | sort -nr | head -n 10
echo

echo "[4] Sudo usage summary"
grep -i "sudo:" "$LOGFILE" | tail -n 50
echo

echo "[5] Any user added or removed"
grep -Ei "useradd|userdel" "$LOGFILE" | tail -n 20
echo

echo "[6] SSH key-based logins"
grep -i "Accepted publickey" "$LOGFILE" | tail -n 20
echo

echo "[DONE] Log analysis complete."
