Security Report — Linux Hardening & Audit

Date: $(date -I)
Host tested: Ubuntu 24.04 (kernel reported in Lynis outputs)
Auditor: ibrahimvol1

Executive summary

Performed a baseline audit with Lynis, applied kernel and SSH hardening, added Fail2Ban, and installed integrity/malware tools. Hardening increased the Lynis hardening index (before -> after). This repo contains the before/after audits and the configuration applied.

Key findings

SSH was configured with default options (PermitRootLogin yes) — changed to no.

High number of enabled services — reviewed and disabled unneeded services.

No file integrity tool originally — installed AIDE and recommended scheduled checks.

Unattended upgrades were present but should be reviewed for policy.

Actions performed

Baseline Lynis scan saved to lynis-before.txt

Applied sysctl network hardening (configs/sysctl.conf)

Installed & configured Fail2Ban (configs/fail2ban/jail.local)

Hardened sshd_config (see docs/03-ssh-hardening.md)

Installed monitoring tools: AIDE, chkrootkit

Recommendations

Enforce key-based SSH authentication system-wide; disable password auth.
Security Audit Report – Ubuntu 24.04 Hardening

Author: ibrahimvol1
Repository: linux-hardening-security-audit
Platform Tested: Ubuntu 24.04 LTS (Kernel 6.14)
Audit Tools: Lynis, Fail2Ban, chkrootkit, debsums, sysctl security modules
Date: Current

1. Executive Summary

This report documents a full security audit and system-hardening workflow executed on Ubuntu 24.04.
The goal was to transform a default installation into a hardened, audit-ready system suitable for SOC and cybersecurity internship demonstrations.

The audit identified weaknesses in default configurations, network stack parameters, SSH security, kernel protections, and logging behavior. Hardenings were applied following CIS and industry best practices.

Lynis Hardening Index improved:

Before: 65

After: 76

A 10+ point increase demonstrates measurable security posture improvement.

2. Scope

The audit covers:

Baseline scanning using Lynis

SSH security evaluation

Review of kernel networking parameters

File permission checks

Malware/rootkit detection

Deployed hardening measures

Verification of improvements

This system is treated as a workstation/server with SSH exposed.

3. Baseline Findings (Before Hardening)
3.1 Lynis Baseline Summary

From lynis-before.txt:

Category	Issue
Boot security	No GRUB password
SSH	Default settings, no brute-force protection
Kernel	Redirects enabled, weak rp_filter, information leaks
Logging	Missing remote logging, deleted files in use
Authentication	No password aging policy, default umask
Network	Several unsafe/medium services
File integrity	AIDE not installed
AppArmor	Many unconfined processes
Malware	chkrootkit present but no integrity baseline
3.2 Key Risks Identified

Brute-force attacks on SSH

Kernel-level spoofing / redirect attacks

Weak logging and no file integrity verification

Users not protected with password aging

Privilege escalation potential via unsafe sysctl values

4. Hardening Actions Performed
4.1 Kernel & Network Hardening

Applied via:

configs/sysctl.conf → /etc/sysctl.d/99-hardening.conf


Key protections enabled:

Disable IP forwarding

Disable ICMP redirects

Enable rp_filter

Enable symlink/hardlink protection

Enforce ASLR

Restrict kernel pointers (kptr_restrict)

Disable source routing

Impact: Block spoofing, MITM, redirect manipulation, and reduce kernel exploitation surface.

4.2 SSH Hardening

Reviewed and improved SSH configuration:

Disable root login

Increase authentication logging

Limit authentication attempts

Disable AgentForwarding / TCPForwarding

Enforce secure session settings

Impact: Prevent brute-force, reduce exposure, increase traceability.

4.3 Fail2Ban Deployment

Installed and configured Fail2Ban with:

configs/fail2ban/jail.local


Settings:

maxretry = 3

bantime = 3600

findtime = 600

SSH jail enabled

Impact: Blocks automated SSH attackers and botnets effectively.

4.4 Malware & Integrity Tools

Installed:

chkrootkit

debsums

needrestart

Impact: Detect modified binaries, rootkits, and out-of-date libraries.

4.5 Automated Hardening Script

Created:

scripts/auto-hardening.sh


Features:

Safe sysctl deployment with backups

Fail2Ban setup

Logging to /tmp/auto-hardening.log

Prompts for sensitive actions

No dangerous SSH overwrites

Impact: Demonstrates automation skills and secure DevOps practices.

5. Post-Hardening Audit Results
5.1 Lynis After Hardening

From lynis-after.txt:

Hardening Index: 76

SSH scored as OK

Kernel parameters greatly improved

Fail2Ban detected and active

Logging improved

Fewer insecure services reported

No warnings

Lynis recommendations reduced from 39 → 32.

5.2 System Behavior Post-Hardening

SSH works properly with secure config

Networking protections active and validated via sysctl

Fail2Ban successfully bans test brute-force attempts

No service breakage observed

System stability unaffected

6. Remaining Gaps / Future Improvements

To reach production-grade security:

Recommended Enhancements
Area	Suggestion
File Integrity	Deploy and baseline AIDE
SSH	Add Multi-factor authentication
Logs	Forward logs to SIEM or remote server
Kernel	Lock module loading (modules_disabled)
MAC	Build stronger AppArmor profiles
Threat detection	Add OSQuery/Wazuh for telemetry

These areas represent Phase D of the project if extended further.

7. Conclusion

This security audit demonstrates hands-on capability across:

Vulnerability identification

Practical mitigation

Kernel & SSH hardening

Log and malware auditing

Process automation

Before/after measurement

The resulting repository is internship-ready and reflects real defensive tasks performed by SOC/Blue Team analysts.

System security posture has improved noticeably, risks reduced, and controls strengthened.

Appendices

Appendix A: lynis-before.txt

Appendix B: lynis-after.txt

Appendix C: suid-files.txt

Appendix D: configs/ folder with hardening templates

Appendix E: scripts/auto-hardening.sh
Schedule AIDE runs and store AIDE DB on a secure backup.

Implement centralized logging (rsyslog -> remote collector) for SOC ingestion.

Add automated monthly Lynis scans and store results for trend analysis.

Next steps for SOC-ready project

Create detection playbooks for alerts generated by Fail2Ban and AIDE.

Add a sample ELK/OSSIM stack ingest demo (logs forwarded locally).

Provide an analysis notebook showing how alerts map to TTPs.

