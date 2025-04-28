---
title: Archive
layout: page
parent: cracking
---

# Archive

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Zip cracking

### Fcrackzip

*fcrackzip* searches each given zipfile for encrypted files and tries to obtain the password. All files must be encrypted with the same password, and the more files you provide, the better.

```bash
fcrackzip -u -D -p [wordlist] [ZIP file]
```

```bash
fcrackzip -u -D -p ~/rockyou.txt ~/file.zip
```

The `-u` flag will try to decompress the first file by calling unzip with the guessed password. This weeds out false positives when not enough files have been given.
The `-D` flag selects dictionary mode. In this mode, fcrackzip will read passwords from a file, which must contain one password per line and should be alphabetically sorted.
The `-p` flag will set initial (starting) password for brute-force searching to string, or use the file with the name string to supply passwords for dictionary searching.

```bash
fcrackzip -c a -p aaaaaa sample.zip
```

Checks the encrypted files in sample.zip for all lowercase 6 character passwords (aaaaaa ... abaaba ... ghfgrg ... zzzzzz).

```bash
       fcrackzip --method cpmask --charset A --init AAAA test.ppm
```

Checks the obscured image test.ppm for all four character passwords.

## z2c
