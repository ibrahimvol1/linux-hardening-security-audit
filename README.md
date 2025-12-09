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
