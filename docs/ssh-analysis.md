# SSH Hardening Analysis
**Author:** Ibrahim  
**Project:** Linux Hardening & Security Audit  
**System:** Ubuntu 24.04 LTS

---

## 1. Purpose
SSH is the primary remote administrative interface. Hardening SSH reduces risk of unauthorized access, credential theft, lateral movement, and privilege escalation.

This document explains the configuration changes applied, why they matter, how to validate them safely, and how to roll back if something goes wrong.

---

## 2. Changes applied (recommended / used in this repo)
These are the settings used or recommended to be placed in `configs/sshd_config` and reviewed before copying to `/etc/ssh/sshd_config`.

Basic restrictions

PermitRootLogin no
PermitEmptyPasswords no
PasswordAuthentication no # Prefer key-based auth; set to yes temporarily only if required
ChallengeResponseAuthentication no

Connection controls

MaxAuthTries 3
MaxSessions 2
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2
TCPKeepAlive no

Forwarding and agent

AllowTcpForwarding no
PermitTunnel no
AllowAgentForwarding no

Logging and monitoring

LogLevel VERBOSE
PrintLastLog yes

Optional — change default port (requires firewall updates)
Port 2222

**Why each change matters (short):**
- `PermitRootLogin no` — prevents direct root access.
- `PasswordAuthentication no` — forces stronger key-based auth; mitigates brute-force password cracking.
- `MaxAuthTries` and `MaxSessions` — limits brute-force/parallel sessions.
- `AllowAgentForwarding no` / `AllowTcpForwarding no` — prevent credential and port proxy abuse.
- `ClientAlive*` settings — detect and drop dead/stalled sessions.
- `LogLevel VERBOSE` — improves forensic detail for suspicious logins.

---

## 3. Safe deployment procedure (do this remotely)
**Important:** Running SSH changes remotely can lock you out. Use the steps below to change config safely.

1. **Create a backup copy of current config**
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.autobak."$(date +%s)"
Copy the new config into place (but do not restart yet)

sudo cp configs/sshd_config /etc/ssh/sshd_config


Syntax test

sudo sshd -t


If this returns nothing (exit 0), syntax OK. If errors are printed, fix them before proceeding.

Open a second SSH session (keep the first session open)

Keep your original SSH shell active so you can revert if the new config breaks new sessions.

Reload sshd (not restart)

sudo systemctl reload ssh


reload is safer because it re-reads config without killing existing sessions. If your system does not support reload cleanly, use sudo systemctl restart ssh only after testing.

Verify you can open a new SSH session from another terminal/device

If you cannot, revert immediately:

sudo cp /etc/ssh/sshd_config.autobak.* /etc/ssh/sshd_config
sudo systemctl restart ssh

4. Troubleshooting & hostkey issues

If you see sshd: no hostkeys available -- exiting:

List hostkeys:

ls -l /etc/ssh/ssh_host_*


If keys are missing, regenerate them:

sudo dpkg-reconfigure openssh-server
# or explicit regeneration
sudo ssh-keygen -A


After regenerating keys, restart ssh:

sudo systemctl restart ssh

5. Verification commands (run locally or via SSH)
# Show active sshd process and socket
sudo systemctl status ssh --no-pager -l

# Check that sshd listens on expected ports
ss -tlnp | grep sshd

# Confirm key-based login works (from client):
ssh -i ~/.ssh/id_ed25519 youruser@yourhost

# Check for Fail2Ban interaction (should show bans if testing brute force)
sudo fail2ban-client status sshd

# Inspect auth log for evidence
sudo tail -n 200 /var/log/auth.log


Expected outputs:

PermitRootLogin no should appear in /etc/ssh/sshd_config.

sshd is active (running) and listening on the expected port.

New SSH sessions succeed with keys; password auth fails (if disabled).

6. Testing Fail2Ban with safe brute-force

You can test Fail2Ban locally using a controlled fail from another machine or by temporarily lowering maxretry and using a disposable test account. After tests, revert settings.

Safer approach: use fail2ban-client to simulate/jail:

sudo fail2ban-client set sshd banip 1.2.3.4
sudo fail2ban-client set sshd unbanip 1.2.3.4

7. Interview talking points

Explain why key-based auth is preferable and how agent forwarding can leak keys.

Explain ClientAlive* vs TCPKeepAlive.

Discuss logging trade-offs: VERBOSE increases evidence but also log volume.

Describe safety steps to change SSH remotely (backup, syntax test, open second session).

Explain how Fail2Ban and SSH hardening complement each other.

8. Rollback plan

If a config breaks SSH accessibility:

Restore backup:

sudo cp /etc/ssh/sshd_config.autobak.* /etc/ssh/sshd_config


Restart ssh:

sudo systemctl restart ssh


If remote access still fails, use console/VM access or cloud provider serial console.

9. Appendix: reference sshd_config snippet used in this project

(See configs/sshd_config in repo)

# minimal secure example included in configs/
