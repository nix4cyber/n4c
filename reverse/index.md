---
title: reverse
layout: page
---

# ⏪ Reverse Engineering

Reverse Engineering is the process of analyzing software (especially malware), firmware, hardware components, or network protocols to understand their internal structure, functionality, and behavior, typically without access to the original source code or design specifications.

## 🐚 Shell

The shell contains all the tools & files needed to perform the attack category.

**Start the shell with the following command:**

```bash
nix develop --refresh github:nix4cyber/n4c#reverse
```

## 📦 Applications

### Ghidra

Ghidra is a software reverse engineering (SRE) suite of tools developed by the National Security Agency (NSA). It helps analyze compiled code in a variety of formats, including executable files, libraries, and firmware images.

```bash
nix-shell -p ghidra --run ghidra
```
