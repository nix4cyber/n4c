---
title: home
layout: home
nav_order: 1
---

<div align="center">
    <img src="https://raw.githubusercontent.com/nix4cyber/n4c/main/assets/logo.png" width="120px" />
</div>

# Nix 4 cyber

Nix 4 cyber is a collection of tools and scripts to help you with your cyber security tasks. It is designed to be easy to use and flexible, allowing you to customize it to your needs. The project is organized into different categories, each containing a shell.nix file that defines the environment for that category.

Check the online documentation [here](https://nix4cyber.github.io/n4c/).

## Usage

To use Nix 4 cyber, you need to have Nix installed on your system. You can then navigate to the desired category and start the shell with the following command:

```bash
nix develop --refresh github:nix4cyber/n4c#<category>
```

Categories include "all" or one of "osint", "web", "network". For example, to start the OSINT environment, you would run:

## Alias

Add the following in your shell config:

```bash
function n4c() {
    nix develop --refresh "github:nix4cyber/n4c#${1:-all}" # -c zsh # Escape the $ with ''$ in nix
    # mkdir /tmp/$(date +"%d%m%y") && cd /tmp/$(date +"%d%m%y") # To create a temporary directory
}
```

Then you can use the following command to start the shell:

```bash
n4c <category>
```

## Disclaimer

Nix 4 Cyber is intended solely for lawful, ethical, and educational purposes. It is designed to assist cybersecurity professionals, researchers, and students in conducting authorized security assessments, penetration testing, and digital forensics within environments where they have explicit permission to operate.

By using this project, you agree to comply with all applicable laws and regulations. The maintainers of Nix 4 Cyber are not responsible for any misuse of the tools or scripts provided. Unauthorized or malicious use of this project is strictly prohibited and may violate local, national, or international laws.

Use responsibly. Always obtain proper authorization before conducting any security testing.
