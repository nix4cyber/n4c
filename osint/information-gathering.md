---
title: Information gathering
layout: page
parent: osint
---

# Information gathering

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Command line tools

| **From** | **Use** |
| --- | --- |
| Email | `holehe <email>` |
| Domain | `theharvester -d <domain> -l 100` |
| | `theharvester -d <domain> -l 100 -b all` (full)|
| Username | `sherlock <username>` |
| Image | `exiftool <image>` |
| Instagram | `instaloader profile <username>` |
| Github | `trufflehog github --org=<username,org>` |

## Online tools

| **From** | **Use** |
| --- | --- |
| Visualiser | [OSINTracker](https://www.osintracker.com/) |
| IP | [Shodan](https://www.shodan.io/) |
| Name | [Webmii](https://webmii.com/) |
| SSID | [Wigle](https://wigle.net/) |
| Image | [PimEyes](https://pimeyes.com/) |
| | [TinEye](https://tineye.com) |
| | [Pic2Map (exif geolocation)](https://www.pic2map.com/) |
| Email | [DeHashed](https://dehashed.com/search) |
| | [Hunter](https://hunter.io/) |
| | [HaveIBeenPwned](https://haveibeenpwned.com/) |
| Misc | [Goosint](https://goosint.com/) |
| | [OSINT Framework](https://osintframework.com/) |
| | [OSINT Dojo](https://osintdojo.com/) |

## Full OSINT Frameworks

- [Recon-ng](https://github.com/lanmaster53/recon-ng) is a modular Python framework for automating OSINT collection via many built-in modules
- [SpiderFoot](https://github.com/smicallef/spiderfoot) is an open-source tool aggregating dozens of data sources to profile domains, IPs, or identifiers
