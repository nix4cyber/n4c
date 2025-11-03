---
title: "Privilege Escalation"
description: "Essential cybersecurity cheatsheet for Privilege Escalation techniques on Linux and Windows systems. Covers command discovery (sudo), automated tools (LinPEAS), and exploitation resource databases (GTFOBins, LOLBAS)."
seo:
  title: "Privilege Escalation Cheatsheet: Linux and Windows Techniques"
  description: "Comprehensive guide for security professionals on privilege escalation. Learn to audit Linux sudo rights, use automated scripts like LinPEAS, and leverage resources such as GTFOBins and LOLBAS for exploiting binaries on Linux and Windows."
---

**Privilege Escalation**, often abbreviated as **Privesc**, is the crucial process in a penetration test or cyberattack where an unauthorized user attempts to exploit system vulnerabilities or misconfigurations to gain elevated access (e.g., from a standard user to an administrator or root user) to restricted resources or data on a compromised system.

## Linux

### Sudo

Lists the commands that the current user can run with sudo. This is useful for finding out if the user has permission to run any commands as root or other users.

```bash
sudo -l
```

### GTFOBins

GTFOBins is a curated list of Unix binaries that can be exploited by an attacker to bypass local security restrictions, if for instance the user can run them with sudo (as we just saw before) or as a setuid binary.
Refer to the [GTFOBins website](https://gtfobins.github.io/) for the full list of binaries and their exploits.

### LinPEAS

[LinPEAS](https://github.com/peass-ng/PEASS-ng/tree/master/linPEAS) is a script that search for possible paths to escalate privileges on Linux/Unix\*/MacOS hosts.

```bash
curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh
```

## Windows

### LOLBAS

The goal of the LOLBAS project is to document every binary, script, and library that can be used for Living Off The Land techniques.
Refer to the [LOLBAS website](https://lolbas-project.github.io/#) for the full list of binaries and their exploits.
