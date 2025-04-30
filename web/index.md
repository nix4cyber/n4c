---
title: web
layout: page
---

# 🌐 Web

Web attacks are a category of attacks that target web applications and services. These attacks can be used to exploit vulnerabilities in web applications, steal sensitive data, or disrupt services.

## 🐚 Shell

The shell contains all the tools & files needed to perform the attack category.

**Start the shell with the following command:**

```bash
nix develop --refresh github:nix4cyber/n4c#web
```

## 📦 Applications

### Burp Suite

Burp Suite is a popular web application security testing tool. It is used to find vulnerabilities in web applications and perform security assessments.

```bash
NIXPKGS_ALLOW_UNFREE=1 nix-shell -p burpsuite --run burpsuite
```

### OWASP ZAP

OWASP ZAP (Zed Attack Proxy) is an open-source web application security scanner. It is used to find vulnerabilities in web applications and perform security assessments.

```bash
nix-shell -p zap --run zap
```
