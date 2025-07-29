[//]: # (Auto-generated from index.md)

<div align="center">
    <img src="https://raw.githubusercontent.com/nix4cyber/n4c/main/assets/logo.png" width="120px" />
</div>

# Nix 4 cyber 🛡️

**Nix 4 Cyber** (or n4c) is a framework that uses the **Nix package manager** to
provide reproducible cybersecurity **toolkits**. The project is organized into
categories (e.g., OSINT, Web, Networking), each with a shell.nix file that
defines its specific software environment.

This approach ensures that all dependencies are isolated and consistent,
allowing users to perform security tasks with a predictable set of tools. The
official documentation, including a full tool list and **usage examples**, is
available at [n4c.hadi.diy](https://n4c.hadi.diy).

## 🚀 Usage

To use Nix 4 cyber, you need to have Nix installed on your system. You can then
start the shell with the following command:

```bash
nix develop github:nix4cyber/n4c#<toolkit>
```

For example, to start the OSINT environment, you would run:

```bash
nix develop github:nix4cyber/n4c#osint
```

## 🧰 Available Toolkits

Here are the currently available environments, each providing a curated set of
tools for its specific domain:

### 🕸️ Web (web)

For web application penetration testing, including directory busting, spidering,
and vulnerability analysis.
[See tools and guides &rarr;](https://n4c.hadi.diy/web/)

### 🕵️ OSINT (osint)

A collection of tools for Open Source Intelligence gathering from public
sources. [See tools and guides &rarr;](https://n4c.hadi.diy/osint/)

### 🌐 Network (network)

Utilities for network scanning, traffic analysis, and wireless security.
[See tools and guides &rarr;](https://n4c.hadi.diy/network/)

### 🔓 Cracking (cracking)

Tools focused on password and hash cracking.
[See tools and guides &rarr;](https://n4c.hadi.diy/cracking/)

### 👑 Privilege Escalation (privesc)

Scripts and tools to help with enumerating and exploiting privilege escalation
vectors. [See tools and guides &rarr;](https://n4c.hadi.diy/privesc/)

### 🔍 Forensics (forensics)

A suite of tools for digital forensics and file analysis.
[See tools and guides &rarr;](https://n4c.hadi.diy/forensics/)

### ⚙️ Reverse Engineering (reverse)

Tools for disassembling and analyzing binaries.
[See tools and guides &rarr;](https://n4c.hadi.diy/reverse/)

### 🤫 Steganography (stegano)

Utilities to find and extract hidden data within files.
[See tools and guides &rarr;](https://n4c.hadi.diy/stegano/)

## ✨ Alias

Add the following in your shell config:

```bash
function n4c() {
    category=${1:-all}
    shift
    args=${*}
    nix develop "github:nix4cyber/n4c#${category}" ${args} # -c zsh # Escape the $ with ''$ in nix
    # mkdir -p /tmp/$(date +"%d%m%y") && cd /tmp/$(date +"%d%m%y") # To create a temporary directory
}
```

Then you can use the following command to start the shell:

```bash
n4c <category>
```

## ⚖️ Disclaimer

Nix 4 Cyber is intended solely for lawful, ethical, and educational purposes. It
is designed to assist cybersecurity professionals, researchers, and students in
conducting authorized security assessments, penetration testing, and digital
forensics within environments where they have explicit permission to operate.

By using this project, you agree to comply with all applicable laws and
regulations. The maintainers of Nix 4 Cyber are not responsible for any misuse
of the tools or scripts provided. Unauthorized or malicious use of this project
is strictly prohibited and may violate local, national, or international laws.

Use responsibly. Always obtain proper authorization before conducting any
security testing.
