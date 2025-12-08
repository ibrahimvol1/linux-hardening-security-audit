Threat Model – Ubuntu 24.04 Hardened Workstation

Author: Ibrahim
Date: (fill in)

1. Overview

This document describes the threat model for a personal workstation used for cybersecurity learning, tool usage, and internship preparation. The threat model outlines assets, adversaries, attack surfaces, and protections currently applied.

This is suitable for an internship-level portfolio and demonstrates understanding of structured security analysis.

2. Assets (What we protect)
Asset	Description	Value
System configuration	Hardening, SSH, sysctl, services	High
User data	Documents, browser data, credentials	High
System integrity	Executables, kernel, configs	High
Network communication	SSH, HTTPS	Medium
Logs	Audit logs, fail2ban logs	Medium
3. Adversaries (Who may attack)
3.1 External Threat Actors

Opportunistic attackers scanning port 22

Malware delivered via browser

Remote brute-force attackers

3.2 Internal / Local Threats

Malicious USB devices

Untrusted software installed manually

Accidental misconfiguration

3.3 Skill Levels
Adversary	Skill Level	Threat
Script Kiddie	Low	Moderate
Automated Bots	Medium	High
Skilled attacker	High	High (but unlikely for personal system)
4. Attack Surfaces
4.1 Network Attack Surface

Open services:

SSH (port 22)

Local services (systemd-resolved, dbus, etc.)

Risks:

Brute-force attempts

Misconfiguration of SSH

Mitigations:

Fail2Ban enabled

SSH hardened (no root login, restricted sessions)

Strong key-based authentication

4.2 Local Attack Surface

Risks:

USB-based malware

Privilege escalation

Misconfigured file permissions

Mitigations:

AIDE + debsums for file integrity

Kernel hardening via sysctl

Permissions reviewed with Lynis

4.3 Software Supply Chain

Risks:

Installing unverified .deb packages

Vulnerable packages in system

Mitigations:

Ubuntu security repo enabled

needrestart + apt-check for updates

chkrootkit for detection

5. Risk Classification
Threat	Likelihood	Impact	Risk Level
SSH brute-force	High	Medium	High
Local privilege escalation	Medium	High	Medium
Malware infection from browser	Medium	Medium	Medium
USB attacks	Low	High	Medium
Kernel zero-day	Low	Very High	Medium
6. Mitigation Summary

Already implemented (Phase A):

Fail2Ban enabled

SSH hardening

Kernel/sysctl improvements

Package integrity tools installed

Log analysis tools available

To be implemented (Phase B):

USBGuard (USB control)

Custom AppArmor profiles

Hardened SSH port + additional restrictions

Custom sysctl policy tuning

Automated log monitoring

7. Conclusion

This workstation faces common threats found in real-world security assessments.
The current protections significantly reduce attack surface and provide strong foundations for an internship-ready portfolio.

Phase B will raise this to near enterprise-level posture.

END OF FILE
