#!/usr/bin/env bash
#
# fail2ban-stats.sh
# Purpose: Summarize Fail2Ban activity for SSH and other jails.
# Author: Ibrahim
# Project: Linux Hardening & Security Audit

echo "======== FAIL2BAN SECURITY SUMMARY ========"
echo "Timestamp: $(date)"
echo

echo "[1] Jails enabled"
sudo fail2ban-client status | sed '1,2d'
echo

echo "[2] SSH jail stats"
sudo fail2ban-client status sshd 2>/dev/null || echo "sshd jail not found"
echo

echo "[3] Top banned IPs"
sudo zgrep -h "Ban" /var/log/fail2ban.log* | awk '{print $NF}' | sort | uniq -c | sort -nr | head -n 15
echo

echo "[4] Recent Fail2Ban events (last 20)"
sudo tail -n 20 /var/log/fail2ban.log
echo

echo "[DONE] Fail2Ban analytics complete."
