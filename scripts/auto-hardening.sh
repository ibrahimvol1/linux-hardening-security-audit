#!/usr/bin/env bash

scripts/auto-hardening.sh
Minimal automation: applies safe configuration files from repo.
REVIEW THIS SCRIPT before running with sudo.

set -euo pipefail
echo "Auto-hardening bootstrap: review script before running."

1) Copy sysctl module (safe)

sudo cp configs/sysctl.conf /etc/sysctl.d/99-hardening.conf
sudo sysctl --system

2) Install recommended packages (unattended)

sudo apt update
sudo apt install -y fail2ban aide chkrootkit debsums needrestart

3) Deploy fail2ban config (safe to overwrite local jail.local)

sudo mkdir -p /etc/fail2ban/jail.d
sudo cp configs/fail2ban/jail.local /etc/fail2ban/jail.d/00-ssh.local
sudo systemctl restart fail2ban

4) Secure sshd_config (this will overwrite /etc/ssh/sshd_config)
PLEASE EDIT /etc/ssh/sshd_config MANUALLY BEFORE RUNNING THIS PART
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.autobak
sudo cp configs/sshd_config /etc/ssh/sshd_config
sudo sshd -t && sudo systemctl restart ssh

echo "Auto-hardening: finished initial steps. Review logs and perform final checks."
