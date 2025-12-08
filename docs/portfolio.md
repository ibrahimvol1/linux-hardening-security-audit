Linux Hardening & Security Audit Portfolio

Author: Ibrahim
Repo: linux-hardening-security-audit

1. Objective

This project demonstrates practical, real-world Linux system hardening and security auditing skills appropriate for SOC Analyst, Cybersecurity Intern, and DevSecOps trainee roles.

The purpose is to showcase:

Ability to secure an OS

Ability to perform vulnerability assessment

Ability to configure security tools

Ability to explain risks, mitigations, and logic (crucial for interviews)

2. Scope

This work focuses on:

Ubuntu 24.04 workstation hardening

SSH security improvements

Kernel and system parameter tuning

Service minimization and control

File integrity and malware monitoring

Automated security tooling

Threat modeling

Before/after comparisons (Lynis)

Everything in this repository is built by hand on a real machine, not simulated.

3. Phase A Achievements
3.1 Hardening Steps Implemented

Disabled unnecessary services (CUPS, Avahi)

Configured SSH securely (no root login, no agent forwarding, strict session limits)

Fail2Ban deployed with custom jail rules

Sysctl kernel hardening profile applied (network protection, pointer restrictions, anti-spoofing, anti-redirects)

Installed integrity and security tooling:

AIDE

debsums

chkrootkit

needrestart

Performed full Lynis audit before and after

Documented findings, mitigation, and results

Created threat model for the system

3.2 Audit Improvements (Before → After)
Category	Before	After
Hardening Index	65	76
Firewall	Present	Hardened + fail2ban
SSH	Default	Hardened config
Malware Scanning	None	chkrootkit enabled
Integrity Checking	None	AIDE + debsums
Kernel Settings	Default	Hardened sysctl

This demonstrates measurable progress — something interviewers love.

4. Screenshots Recommended for GitHub

Add these later to make the repo visually appealing:

Screenshot of Lynis before

Screenshot of Lynis after

Screenshot of Fail2Ban status

Screenshot of sysctl changes

Screenshot of SSH config diff

Images increase portfolio value significantly.

5. Skills Demonstrated
Technical Skills:

Linux administration

Secure configuration

Hardening frameworks (sysctl, Fail2Ban, SSH)

File integrity monitoring

Threat modeling

Vulnerability scanning (Lynis)

Log analysis

SOC / Security Analyst Skills:

Identifying attack surfaces

Evaluating risk

Creating security controls

Documenting findings

Using scripting to automate tasks

6. Why This Project Is Internship-Ready

Recruiters look for:

Practical work

Clear documentation

Ability to explain security decisions

Real logs, configs, and results

This repository now checks all boxes.
During an interview, this project will allow you to talk confidently about:

Threat surfaces

Hardening decisions

Tools like Fail2Ban and AIDE

Why certain kernel parameters matter

How to evaluate before/after posture

You now have a real, demonstrable security project.

7. Next Steps (Phase B, C, D)

Future phases (you will complete next):

Build monitoring scripts

Implement USBGuard

Add AppArmor custom profile

Automate integrity checks

Create attack simulation lab

Add custom dashboards for logs

Optional: Deploy ELK stack on VM

These will elevate the repo from “good” to “excellent”.

END OF FILE
