# Sysctl Hardening Analysis  
**Author:** Ibrahim  
**Project:** Linux Hardening & Security Audit  
**System:** Ubuntu 24.04 LTS  
**Date:** $(date)

---

## 1. Purpose of Sysctl Hardening

Sysctl controls kernel parameters affecting networking, memory, process handling, and security features.  
Hardening these parameters helps:

- Reduce attack surface  
- Prevent spoofing & MITM attacks  
- Increase kernel-level protections  
- Enforce safer defaults  

This file explains each hardened parameter implemented on this system.

---

## 2. Key Parameters and Their Security Impact

### **2.1 Network Security Settings**

| Parameter | Value | Purpose |
|----------|--------|---------|
| `net.ipv4.conf.all.rp_filter` | 1 | Enables reverse path filtering (anti-spoofing). |
| `net.ipv4.conf.all.send_redirects` | 0 | Prevents malicious ICMP redirect attacks. |
| `net.ipv4.conf.default.accept_redirects` | 0 | Blocks redirect packets that could reroute traffic. |
| `net.ipv4.conf.all.accept_source_route` | 0 | Prevents source-routed packet attacks. |
| `net.ipv4.icmp_echo_ignore_broadcasts` | 1 | Prevents smurf attacks (ICMP floods). |
| `net.ipv4.tcp_syncookies` | 1 | Protects against SYN flood DoS attacks. |
| `net.ipv6.conf.all.accept_ra` | 0 | Prevents rogue IPv6 router advertisements. |

These settings significantly reduce exposure to common network-based attacks.

---

### **2.2 Kernel Protection Settings**

| Parameter | Value | Purpose |
|----------|--------|---------|
| `kernel.randomize_va_space` | 2 | Enables full ASLR (memory randomization). |
| `kernel.kptr_restrict` | 1 | Prevents leaking kernel memory addresses to userspace. |
| `kernel.dmesg_restrict` | 1 | Restricts access to kernel logs (protects sensitive info). |
| `kernel.yama.ptrace_scope` | 1 | Blocks unwanted process tracing (prevents code injection). |
| `kernel.sysrq` | 176 | Limits SysRq functions to prevent misuse. |

---

### **2.3 Filesystem Security**

| Parameter | Value | Purpose |
|----------|--------|---------|
| `fs.protected_symlinks` | 1 | Prevents symlink-based privilege escalation. |
| `fs.protected_hardlinks` | 1 | Protects against hardlink attacks. |
| `fs.protected_regular` | 2 | Strengthens file write protections. |
| `fs.protected_fifos` | 1 | Prevents unsafe FIFO usage. |

---

### **2.4 Additional Protections**

| Parameter | Value | Purpose |
|----------|--------|---------|
| `vm.mmap_min_addr` | 65536 | Prevents NULL pointer dereference attacks. |
| `kernel.unprivileged_userns_clone` | 1 | Controls user namespaces (potential privilege boundary). |
| `fs.inotify.max_user_watches` | 65536 | Supports monitoring of many files (for security tools). |
| `net.core.default_qdisc` | fq_codel | Helps with network fairness / reduces latency. |

---

## 3. Issues Detected by Lynis

Lynis reported:

- Some values differ from expected hardened profiles.  
- `99-hardening.conf` contained invalid syntax at lines 1, 15, 20.

These must be corrected in the next iteration.

---

## 4. Improvement Plan (Phase C)

- Validate and fix syntax errors in sysctl config.  
- Add missing key parameters from CIS Benchmark.  
- Create profile-specific sysctl templates.  
- Apply automated linting to avoid invalid rules.

---

## 5. Conclusion

The sysctl configuration substantially increases system resilience against L3/L4 attacks, memory exploits, and filesystem abuse.  
Minor syntax issues must be resolved, but the foundational hardening is solid and already improves overall system security posture.

