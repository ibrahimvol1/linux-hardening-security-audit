SSH Hardening Guide
This document explains safe SSH hardening steps and a recommended sshd_config snippet.

Goals

Prevent root login over SSH

Reduce authentication attempts

Limit user access

Disable risky features (TCP forwarding, password auth if using keys)

Recommended sshd_config snippet

Place these entries in /etc/ssh/sshd_config (merge with defaults; backup original first).
# SSH hardening (sample)
Port 22
Protocol 2
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
PermitEmptyPasswords no
AllowUsers ibrahim
AllowTcpForwarding no
X11Forwarding no
UseDNS no
LoginGraceTime 30
MaxAuthTries 3
MaxSessions 2
ClientAliveInterval 300
ClientAliveCountMax 2
AllowAgentForwarding no
LogLevel VERBOSE
Banner /etc/issue.net

Steps
Backup current config:

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak


Edit /etc/ssh/sshd_config and apply the recommended snippet.

If you use SSH key auth only, ensure your public keys are in ~/.ssh/authorized_keys first.

Test the config:

sudo sshd -t


Restart SSH:

sudo systemctl restart ssh


If you use a non-root account for admin, add that account to AllowUsers (as above).
Testing remote connectivity
From another host:

ssh -v youruser@yourhost

Rollback

If you lose connectivity, use console/VM access or single-user mode and restore:

sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh


