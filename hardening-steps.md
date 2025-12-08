# Hardening Steps (executed)

This file lists the commands I executed, why I ran them, and the effect.

## Summary of actions
1. System update and upgrade
   - `sudo apt update && sudo apt upgrade -y`
2. Firewall enabled
   - `sudo ufw enable`
3. SSH hardening (sshd_config changes)
   - `PermitRootLogin no`
   - `AllowTcpForwarding no`
   - `ClientAliveCountMax 2`
   - `LogLevel VERBOSE`
   - `MaxAuthTries 3`
   - `MaxSessions 2`
   - `TCPKeepAlive no`
   - `AllowAgentForwarding no`
4. Installed and configured Fail2ban
   - `sudo apt install fail2ban -y`
   - custom jail: `/etc/fail2ban/jail.d/00-ssh.local`
5. Installed chkrootkit and AIDE (file integrity)
6. Ran Lynis before and after, saved reports to lynis-before.txt and lynis-after.txt

Each step in the audit has a short explanation and the exact command used.
