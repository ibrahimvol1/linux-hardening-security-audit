#!/usr/bin/env bash
# Minimal automation for reproducibility (run interactively with sudo)
set -euo pipefail

echo "Updating packages..."
apt update && apt upgrade -y

echo "Enabling UFW..."
ufw --force enable

echo "Installing fail2ban and chkrootkit..."
apt install -y fail2ban chkrootkit

echo "Creating basic Fail2ban SSH jail..."
cat > /etc/fail2ban/jail.d/00-ssh.local <<'JAIL'
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 600
bantime = 3600
JAIL

echo "Done. Review /etc/fail2ban/jail.d/00-ssh.local before restarting services."
