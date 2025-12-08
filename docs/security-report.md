Security Assessment Report – Ubuntu 24.04 Host

Date: (Fill your date)
Author: Ibrahim

1. Executive Summary

This report summarizes the security state of a freshly configured Ubuntu 24.04 workstation after applying basic hardening controls. The goal was to reach an internship-level security posture: stable configuration, reduced attack surface, logs enabled, and baseline monitoring tools active.

The hardening level after assessment improved from a Lynis Hardening Index of 65 → 76, indicating measurable improvements in system security.

2. System Context

Host OS: Ubuntu 24.04 LTS

Kernel: 6.14.x

User Access: Single local user (non-root administrative via sudo)

Purpose: Learning, security practice, and safe experimentation

Network Exposure: Primarily LAN, SSH access allowed

3. Summary of Hardening Actions Completed
3.1 System-Level
Control	Status	Notes
Sysctl hardening	Applied	Network and kernel protections improved
Fail2Ban	Active	SSH anti-bruteforce enabled
AIDE (file integrity)	Installed	Baseline created on next run
chkrootkit	Installed	Rootkit scans available
debsums	Installed	Package integrity verification available
SSH hardening	Partially applied	Root login disabled, fewer sessions, safer defaults
Auto-hardening script	Working	Logged actions into /tmp/auto-hardening.log
4. Security Findings (From Lynis Audit)
4.1 High-Level Observations

No critical warnings found.

System services vary in exposure; many run with defaults.

Some kernel sysctl values differ from recommended hardened values (expected before Phase B).

4.2 Opportunities for Improvement
Area	Issue Identified	Action Required
GRUB security	No password set	Add GRUB password (Phase B)
Partitioning	/home, /tmp, /var not separated	Optional, requires reinstall
USB controls	USB storage not restricted	Add USBGuard (Phase B)
Log management	No external log forwarding	Optional for workstation
SSH	Port still default (22)	Change after stabilizing config
Sysctl	Some values differ from benchmark	Tune in Phase B
5. Hardening Score Evaluation

Initial score: 65

After hardening: 76

A typical secure workstation baseline is between 70–80, so this is within a realistic internship-level configuration.

6. Conclusions

The system is now:

more resistant to network-based attacks,

better monitored,

safer against brute-force attempts,

operating with improved kernel protections.

Additional Phase B work will elevate the system to enterprise-grade security.

7. Next Steps (Phase B Preview)

Apply full sysctl tuning

Lock down compilers

Add AppArmor profiles

Enhance SSH protections

Add firewall rules beyond defaults

Begin monitoring automation

END OF REPORT
