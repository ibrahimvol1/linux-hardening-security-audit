# Linux Hardening and Security Audit

**Repository:** linux-hardening-security-audit  
**Owner:** Mohammed Ibrahim  
**Platform tested:** Ubuntu 24.04 (kernel 6.14)

---

## Summary
This repository documents a complete, reproducible Linux hardening and security audit workflow suitable for internship / SOC portfolio demonstrations.  
It includes baseline scanning, hardening steps, automation scripts, Fail2Ban configuration, AIDE integrity monitoring, sysctl kernel tuning, and before/after audit evidence.

---

## Contents (high level)

- **hardening-steps.md** — step-by-step commands executed during the hardening process  
- **docs/03-ssh-hardening.md** — SSH hardening (recommended sshd_config considerations)  
- **configs/fail2ban/jail.local** — Fail2Ban SSH jail configuration  
- **configs/sysctl.conf** — kernel/network hardening sysctl settings  
- **scripts/auto-hardening.sh** — automated hardening script  
- **docs/security-report.md** — final audit summary and findings  
- **lynis-before.txt, lynis-after.txt** — Lynis audit results (baseline → hardened)  
- **docs/aide-report.md** — AIDE integrity baseline & changed entries  
- **docs/screenshots/** — screenshots of Lynis results, sysctl, system info  

---

## How to reproduce (concise)

### 1. Update the system

sudo apt update && sudo apt upgrade -y
2. Install audit & security tooling
sudo apt install -y lynis fail2ban aide chkrootkit debsums apt-show-versions needrestart

3. Clone this repository
git clone https://github.com/ibrahimvol1/linux-hardening-security-audit.git
cd linux-hardening-security-audit

4. Apply hardening configurations (manual review recommended)

Review configs/sysctl.conf

Review SSH recommendations in docs/03-ssh-hardening.md

Review configs/fail2ban/jail.local

Apply sysctl:

sudo cp configs/sysctl.conf /etc/sysctl.d/99-hardening.conf
sudo sysctl --system


Apply Fail2Ban:

sudo mkdir -p /etc/fail2ban/jail.d
sudo cp configs/fail2ban/jail.local /etc/fail2ban/jail.d/00-ssh.local
sudo systemctl restart fail2ban

5. Run Lynis (baseline → hardened)

Baseline:

sudo lynis audit system | tee lynis-before.txt


After hardening:

sudo lynis audit system | tee lynis-after.txt

6. Initialize and check AIDE integrity baseline
sudo aideinit
sudo aide --config=/etc/aide/aide.conf --check | sudo tee docs/aide-initial-check.txt

Notes for reviewers (interview-friendly)

This project demonstrates real system hardening, audit methodology, and security tooling used in SOC/Blue-Team environments.

Evidence (screenshots + logs) is provided under docs/screenshots and text outputs.

No private keys or AIDE databases are committed. Sensitive items are excluded via .gitignore.

The project is reproducible in any Ubuntu 24.04 VM.

Purpose

Prepared as a portfolio project for Cybersecurity internship / SOC analyst roles to demonstrate proficiency in:

Hardening Linux systems

Running and interpreting Lynis

Monitoring file integrity with AIDE

Deploying Fail2Ban

Kernel & SSH security tuning

Writing automation scripts
