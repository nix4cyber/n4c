---
title: "Nix Shells"
description: "Nix4cyber (or n4c) is a framework that uses the Nix package manager to provide reproducible cybersecurity toolkits."
toc: false
seo:
  title: "Nix Shells - Cybersecurity"
  description: "Nix4cyber (or n4c) is a framework that uses the Nix package manager to provide reproducible cybersecurity toolkits."
---

**Nix4cyber** (or n4c) is a framework that uses the **Nix package manager** to
provide reproducible cybersecurity **toolkits**. The project is organized into
toolkits (e.g., OSINT, Web, Networking), each with a nix shell that
defines its specific software environment.

This approach ensures that all dependencies are isolated and consistent,
allowing users to perform security tasks with a predictable set of tools.

[See available toolkits here](/cheatsheets/cheatsheets)

## Usage

To use nix4cyber, you need to have [Nix](https://nixos.org/) installed on your system.
You can then start a shell with the following command:

```sh
nix develop github:nix4cyber/n4c#<toolkit>
```

## Alias

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
