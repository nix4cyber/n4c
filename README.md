<div align="center">
    <img alt="nixy logo" src="https://raw.githubusercontent.com/nix4cyber/n4c/main/assets/images/logo-transparent.png" width="120px" />
</div>

# Nix4cyber (n4c)

> A modular, open‑source toolkit for cyber‑security professionals built with nix & markdown

![Netlify](https://img.shields.io/badge/Netlify-00C7B7?style=for-the-badge&logo=netlify&logoColor=white)
![Hugo](https://img.shields.io/badge/Hugo-FF4088?style=for-the-badge&logo=hugo&logoColor=white)
![MIT License](https://img.shields.io/badge/MIT-green?style=for-the-badge)

## Overview

N4C (**nix4cyber**) is a personal knowledge-base and toolbox for CTF (capture the flag) & OSINT

It combines three core components:

- [Nix-based shells](https://n4c.hadi.diy/shells): pre-configured environments for specific security domains (web, cracking, networking, forensic, ...).
- [Cheat‑sheets](https://n4c.hadi.diy/cheatsheets/home): quick reference guides organized by category.
- [CTF write‑ups](https://n4c.hadi.diy/writeups): markdown-formatted reports of challenges we've solved.

All content is served through a static website built with [Hugo](https://gohugo.io/) and the [Doks](https://github.com/DELIGHT-LABS/hugo-theme-doks) (<3) theme, hosted on Netlify. The project is fully open‑source under the MIT license and lives on GitHub.

## Usage

To use nix4cyber, you need to have [Nix](https://nixos.org/) installed on your system.
You can then start a shell with the following command:

```sh
nix develop github:nix4cyber/n4c#<toolkit>
```

You could also install the alias `n4c` ([see here](https://n4c.hadi.diy/shells#alias)) and only type `n4c <toolkit>`

More informations about shells & toolkits [here](https://n4c.hadi.diy/shells)

### Example

```sh
# Example: Launch the web pentesting toolkit
nix develop github:nix4cyber/n4c#web

# Inside the shell
nmap -A target.com
```

## Disclaimer

Nix4cyber is intended solely for lawful, ethical, and educational purposes.
It is designed to assist cybersecurity professionals, researchers, and students in conducting authorized security assessments, penetration testing, and digital forensics within environments where they have explicit permission to operate.

By using this project, you agree to comply with all applicable laws and regulations. The maintainers of Nix 4 Cyber are not responsible for any misuse of the tools or scripts provided. Unauthorized or malicious use of this project is strictly prohibited and may violate local, national, or international laws.

Use responsibly. Always obtain proper authorization before conducting any security testing.

## Contributing

Contributions are welcome!  
Feel free to open issues, propose new toolkits, or share CTF write-ups via pull requests.
