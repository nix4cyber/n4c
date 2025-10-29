---
title: "nix4cyber"
description: "A modular, open‑source toolkit for cyber‑security professionals built with nix & markdown"
lead: "A modular, open‑source toolkit for cyber‑security professionals built with nix & markdown"
seo:
  title: "Nix4cyber - Cheatsheets & nix shells for cybersecurity"
  description: "A modular, open‑source toolkit for cyber‑security professionals built with nix & markdown"
---

## Overview

N4C (**nix4cyber**) is a personal knowledge-base and toolbox for CTF (capture the flag) & OSINT

It combines three core components:

- [Nix-based shells](/shells): pre-configured environments for specific security domains (web, cracking, networking, forensic, ...).
- [Cheat‑sheets](/cheatsheets/home): quick reference guides organized by category.
- [CTF write‑ups](/writeups): markdown-formatted reports of challenges we've solved.

All content is served through a static website built with [Hugo](https://gohugo.io/) and the [Doks](https://github.com/DELIGHT-LABS/hugo-theme-doks) (<3) theme, hosted on Netlify. The project is fully open‑source under the MIT license and lives on GitHub.

## Usage

To use nix4cyber, you need to have [Nix](https://nixos.org/) installed on your system.
You can then start a shell with the following command:

```sh
nix develop github:nix4cyber/n4c#<toolkit>
```

You could also install the alias `n4c` ([see here](/shells#alias)) and only type `n4c <toolkit>`

More informations about shells & toolkits [here](/shells)

## Disclaimer

Nix4Cyber is intended solely for _lawful, ethical, and educational purposes_.
It is designed to assist cybersecurity professionals, researchers, and students in conducting authorized security assessments, penetration testing, and digital forensics within environments where they have explicit permission to operate.

By using this project, you agree to comply with all applicable laws and regulations. The maintainers of Nix 4 Cyber are not responsible for any misuse of the tools or scripts provided. Unauthorized or malicious use of this project is strictly prohibited and may violate local, national, or international laws.

Use responsibly. Always obtain proper authorization before conducting any security testing.
