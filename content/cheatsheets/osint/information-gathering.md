---
title: "Information Gathering"
description: ""
seo:
  title: ""
  description: ""
---

## Command line tools

| **From**  | **Use**                                        |
| --------- | ---------------------------------------------- |
| Email     | `holehe $email`                                |
|           | `ghunt email $email` (for google account)      |
|           | `github-recon $email` (for github account)     |
| Domain    | `theHarvester -d $domain -l 100`               |
|           | `theHarvester -d $domain -l 100 -b all` (full) |
| Username  | `sherlock $username`                           |
| Image     | `exiftool $imagePath`                          |
| Instagram | `instaloader profile $username`                |
| Github    | `trufflehog github --org=$usernameOrOrg>`      |
|           | `github-recon $username`                       |

## Online tools

| **For**    | **Use**                                                |
| ---------- | ------------------------------------------------------ |
| Visualiser | [OSINTracker](https://www.osintracker.com/)            |
| IP         | [Shodan](https://www.shodan.io/)                       |
|            | [Censys](https://search.censys.io/)                    |
| Domain     | [Whois](https://www.whois.com/whois/)                  |
| Name       | [Webmii](https://webmii.com/)                          |
|            | [BreachDirectory](https://breachdirectory.org/)        |
|            | [LeakLookup](https://leak-lookup.com/search)           |
|            | [IntelX](https://intelx.io/)                           |
| SSID       | [Wigle](https://wigle.net/)                            |
| Image      | [PimEyes](https://pimeyes.com/)                        |
|            | [TinEye](https://tineye.com)                           |
|            | [Pic2Map (exif geolocation)](https://www.pic2map.com/) |
| Username   | [DeHashed](https://dehashed.com/search)                |
|            | [BreachDirectory](https://breachdirectory.org/)        |
|            | [IntelX](https://intelx.io/)                           |
|            | [LeakLookup](https://leak-lookup.com/search)           |
|            | [Oathnet](https://oathnet.org/)                        |
| Email      | [DeHashed](https://dehashed.com/search)                |
|            | [Hunter](https://hunter.io/)                           |
|            | [HaveIBeenPwned](https://haveibeenpwned.com/)          |
|            | [BreachDirectory](https://breachdirectory.org/)        |
|            | [LeakLookup](https://leak-lookup.com/search)           |
|            | [IntelX](https://intelx.io/)                           |
|            | [Oathnet](https://oathnet.org/)                        |
| Phone      | [Epieos](https://epieos.com/)                          |
| Misc       | [Goosint](https://goosint.com/)                        |
|            | [OSINT Framework](https://osintframework.com/)         |
|            | [OSINT Dojo](https://osintdojo.com/)                   |

## Full OSINT Frameworks

- [Recon-ng](https://github.com/lanmaster53/recon-ng) is a modular Python
  framework for automating OSINT collection via many built-in modules
- [SpiderFoot](https://github.com/smicallef/spiderfoot) is an open-source tool
  aggregating dozens of data sources to profile domains, IPs, or identifiers
