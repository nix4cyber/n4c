---
title: "Docker Evasion"
description: "Docker Evasion refers to the techniques and exploits used by attackers to escape the confines of a Docker container and gain unauthorized access or elevated privileges on the host system."
seo:
  title: "Docker Container Evasion and Privilege Escalation Cheatsheet"
  description: "Essential guide to understanding and testing Docker container evasion techniques. Covers exploits used to break out of the containerized environment and gain unauthorized access or root privileges on the host system."
---

Docker Evasion refers to the techniques and exploits used by attackers to escape the confines of a [Docker container](https://www.docker.com/) and gain unauthorized access or elevated privileges on the host system (the machine running the Docker daemon and containers).

## Automated tools

{{<link-card
  title="Deepce"
  description="Docker pentesting tool for privilege escalation (Nmap, /etc/shadow dump, root user creation)."
  href="https://github.com/stealthcopter/deepce"
  target="_blank">}}

{{<link-card
  title="Docker escape tool"
  description="Utility focused on Docker privilege escalation via mounted sockets, devices, CVEs, and capability-based evasion."
  href="https://github.com/PercussiveElbow/docker-escape-tool"
  target="_blank">}}

## Challenges for Docker Evasion

- [Root-me - I'am groot](https://www.root-me.org/fr/Challenges/App-Script/Docker-I-am-groot)
- [Root-me - Sys Admin's docker](https://www.root-me.org/fr/Challenges/App-Script/Docker-Sys-Admin-s-Docker)
- [Root-me - Talk through me](https://www.root-me.org/fr/Challenges/App-Script/Docker-Talk-through-me)
