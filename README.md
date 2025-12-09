# Linux Hardening and Security Audit

**Repository:** linux-hardening-security-audit  
**Owner:** Mohammed Ibrahim  
**Platform Tested:** Ubuntu 24.04 (Kernel 6.14)

---

## Summary
This repository documents a complete, reproducible Linux hardening and security audit workflow suitable for cybersecurity internships and SOC portfolio demonstrations.  
It includes baseline scanning, hardening steps, automation scripts, Fail2Ban configuration, AIDE integrity monitoring, sysctl kernel tuning, and before/after audit evidence.

---

## Contents (High Level)

- **hardening-steps.md** — step-by-step notes and commands executed  
- **docs/03-ssh-hardening.md** — SSH hardening (recommended `sshd_config` settings)  
- **configs/fail2ban/jail.local** — Fail2Ban SSH jail configuration  
- **configs/sysctl.conf** — kernel/network hardening sysctl settings  
- **scripts/auto-hardening.sh** — automated hardening script  
- **docs/security-report.md** — summary report and findings  
- **lynis-before.txt**, **lynis-after.txt** — Lynis audit outputs  
- **docs/aide-report.md** — AIDE integrity baseline + changed entries  
- **docs/screenshots/** — screenshots: system info, sysctl, Lynis, etc.

---

## How to Reproduce (Concise)

### 1. Update the system
```bash
sudo apt update && sudo apt upgrade -y
```
### 2. Install audit & hardening tooling
```bash
sudo apt install lynis fail2ban aide chkrootkit debsums needrestart -y
```
### 3. Run baseline security scan
```bash
sudo lynis audit system | tee lynis-before.txt
```
### 4. Apply hardening configuration (Before Hardning)

Review configs before applying:

configs/sysctl.conf

configs/fail2ban/jail.local

docs/03-ssh-hardening.md

scripts/auto-hardening.sh

Run the automated hardening: 
```bash
bash scripts/auto-hardening.sh
```
### 5. Run Lynis audit again (after hardening)
```bash
sudo lynis audit system | tee lynis-after.txt
```
### 6. Initialize AIDE baseline
```bash
sudo aideinit
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```
### 7. Run AIDE integrity check
```bash
7. Run AIDE integrity check
```
### 8. Move screenshots (sysctl, Lynis, system info) into repo
```bash
mv ~/Pictures/Screenshots/*.png docs/screenshots/
```
### 9. Commit results and push to GitHub
```bash
git add .
git commit -m "Add audit artifacts, screenshots, and hardening results"
git push origin main
```
### Notes for Reviewers (Interview Friendly)

This project demonstrates real-world Linux system hardening, baseline scanning, kernel tuning, and file integrity monitoring.

Evidence (screenshots, logs, summaries) is included under docs/ and docs/screenshots/.

Sensitive files (private keys, AIDE DBs) are excluded using .gitignore.

All steps are reproducible in any Ubuntu 24.04 VM.

Designed specifically for SOC Analyst / Blue Team internship interviews.

### Purpose

A professional portfolio project demonstrating proficiency in:

Linux hardening

Sysctl kernel tuning

SSH hardening

Fail2Ban configuration

AIDE integrity monitoring

Lynis audit interpretation

Bash automation scripting

Prepared for internship and SOC/Blue Team interviews.

