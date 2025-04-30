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

### LinPEAS

LinPEAS is a script that search for possible paths to escalate privileges on Linux/Unix*/MacOS hosts.

```bash
curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh
```
