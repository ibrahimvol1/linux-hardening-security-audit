**Repository:** linux-hardening-security-audit  
**Owner:** Mohammed Ibrahim  
**Platform tested:** Ubuntu 24.04 (kernel 6.14)

## Summary
This repository documents a complete, reproducible Linux hardening and security audit workflow suitable for internship / SOC portfolio demonstrations. It includes configuration changes, automation scripts, Lynis audit outputs, and a final security report.

## Contents (high level)
- `hardening-steps.md` — step-by-step notes and commands executed
- `docs/03-ssh-hardening.md` — SSH hardening (sshd_config recommendations)
- `configs/fail2ban/jail.local` — sample Fail2Ban SSH jail configuration
- `configs/sysctl.conf` — kernel/network hardening sysctl settings
- `scripts/auto-hardening.sh` — automated hardening script (review before running)
- `docs/security-report.md` — summary report & findings
- `lynis-before.txt`, `lynis-after.txt` — Lynis outputs

## How to reproduce (concise)
1. Update the system:
   ```bash
   sudo apt update && sudo apt upgrade -y
Install audit tooling:

bash
Copy code
sudo apt install lynis fail2ban aide chkrootkit debsums apt-show-versions needrestart -y
Review and apply configs/ and docs/ items. Test in a VM before production.

Re-run Lynis and save report to lynis-after.txt.
Notes for reviewers
This repo demonstrates baseline scanning, hardening changes, and automation for reproducible audits.

Avoid committing private keys or AIDE DBs. .gitignore should exclude such artifacts.

