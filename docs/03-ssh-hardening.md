# SSH Hardening Guide (Ubuntu 24.04)

This document explains SSH security risks, recommended mitigations, and the hardened `sshd_config` used in this audit.

---

## 1. Goals of SSH Hardening
- Prevent unauthorized access  
- Reduce brute-force attack success probability  
- Minimize remote exploitation surface  
- Improve audit visibility through detailed logging  
- Ensure safe rollback path if connectivity issues occur  

---

## 2. Risks Addressed
| Risk | Description | Mitigation |
|------|-------------|------------|
| Brute-force attacks | Attackers repeatedly guess passwords | Fail2Ban + MaxAuthTries |
| Root login compromise | If root credentials leak → full system takeover | Disable PermitRootLogin |
| Port forwarding abuse | Attackers open tunnels for lateral movement | Disable AllowTcpForwarding |
| Credential theft | SSH agent hijacking | Disable AllowAgentForwarding |
| Log evasion | Minimal logs by default | Set LogLevel VERBOSE |

---

## 3. Recommended Hardened `sshd_config`

Place in:

Port 22
Protocol 2
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
PermitEmptyPasswords no

Restrict users

AllowUsers ibrahim

Disable risky features

AllowTcpForwarding no
X11Forwarding no
UseDNS no

Authentication throttling

LoginGraceTime 30
MaxAuthTries 3
MaxSessions 2
ClientAliveInterval 300
ClientAliveCountMax 2

Logging

AllowAgentForwarding no
LogLevel VERBOSE

Banner

Banner /etc/issue.net


---

## 4. Deployment Steps

### 4.1 Backup current config


sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak


### 4.2 Edit the configuration


sudo nano /etc/ssh/sshd_config


Paste the hardened configuration.

### 4.3 Validate config (VERY IMPORTANT)


sudo sshd -t


If no errors appear → safe to restart.

### 4.4 Restart SSH


sudo systemctl restart ssh


### 4.5 Test connectivity from another system
To avoid locking yourself out:



ssh youruser@yourhost


---

## 5. Rollback Procedure (If Locked Out)

If SSH stops working:

1. Use **VM console**, **physical machine**, or **recovery shell**  
2. Restore:



sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh


---

## 6. Outcome

After applying these SSH hardening measures:

- Attack surface reduced  
- Brute-force protection active  
- Root login fully disabled  
- Forwarding features restricted  
- Extensive logging available for SOC review  

This configuration aligns with CIS Benchmark Level 1 guidance for SSH server protection.

