# AIDE Integrity Verification Report  
**System:** Ubuntu 24.04  
**Author:** ibrahimvol1  
**Date:** Initial Baseline After Hardening  

AIDE (Advanced Intrusion Detection Environment) was used to generate a file-system integrity baseline and detect modifications introduced by the Linux hardening steps.

---

## 1. Purpose of AIDE

AIDE creates a cryptographic database describing the expected state of the system (permissions, hashes, ownership, file attributes).  
After hardening, it allows us to verify:

- Whether critical files changed unexpectedly  
- Whether new files were added (expected during hardening)  
- Whether any system configuration was modified  

This is essential for SOC / Blue-Team workflows.

---

## 2. Baseline Initialization

AIDE was initialized using:

```bash
sudo aideinit
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
Runtime for initialization: ~44 minutes (normal for full FS scan).

3. First Integrity Check

Command:

sudo aide --config=/etc/aide/aide.conf --check


Output was saved to:

docs/aide-initial-check.txt
docs/aide-changes-summary.txt

4. Summary of Detected Changes

From aide-changes-summary.txt:

Added entries: 28

Removed entries: 13

Modified entries: 0

These changes align with expected activity:

Added Items (Expected)

New sysctl hardening module at /etc/sysctl.d/99-hardening.conf

Fail2Ban configuration: /etc/fail2ban/jail.d/00-ssh.local

AIDE database files: /var/lib/aide/aide.db

Log files created during package installs

Automation script artifacts under /home/ibrahim/Linux Hardning and Security Audit/scripts

Removed Items (Expected)

Temporary files replaced by package upgrades

Old cache files overwritten by system updates

No suspicious or unauthorized changes were detected.

5. Cryptographic Hash Summary (From Database)

AIDE produced secure multi-hash signatures:

MD5, SHA1, SHA256, SHA512

RMD160, TIGER, CRC32, HAVAL, WHIRLPOOL, GOST

This ensures strong verification against tampering.

6. Security Interpretation

The AIDE results show:

No unexpected file modifications

All changes correspond to system hardening operations

Strong integrity baseline created for future monitoring

AIDE is ready for scheduled daily checks (optional)

This makes the host suitable for SOC/Blue-Team demonstrations and interview discussions.

7. Recommendations for Production Use

To extend this portfolio:

(A) Automate AIDE Daily Checks

Add a cron job:

sudo nano /etc/cron.daily/aide-check


Inside:

#!/bin/sh
/usr/bin/aide --config=/etc/aide/aide.conf --check | mail -s "AIDE Daily Report" admin@example.com


Make executable:

sudo chmod +x /etc/cron.daily/aide-check

(B) Store the AIDE database securely

Copy to offline / read-only media:

sudo cp /var/lib/aide/aide.db ~/aide-backups/

8. Screenshots (Included in repo)

docs/screenshots/sysctl-hardened.png

docs/screenshots/lynis-after.png

docs/screenshots/system-info.png

Final Notes

The AIDE implementation demonstrates:

Ability to configure Linux host integrity monitoring

Understanding of secure baseline creation

Ability to interpret file system changes

Readiness for SOC/Blue-Team internship interviews

AIDE is now fully integrated into your hardening project.
