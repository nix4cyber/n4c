---
title: "Archive"
description: "Comprehensive guide for cracking password-protected archives including ZIP, RAR, and 7z files. Learn how to use fcrackzip, zip2john, and hashcat conversion tools to recover passwords from encrypted compressed files."
seo:
  title: "Archive Password Cracking Guide - ZIP, RAR, 7z Password Recovery"
  description: "Complete archive cracking tutorial using fcrackzip, zip2hashcat, rar2hashcat, 7z2hashcat, and zip2john. Dictionary and brute-force attack methods for recovering passwords from encrypted compressed files with hashcat and John the Ripper."
---

## Zip cracking

### Fcrackzip

fcrackzip searches each given zipfile for encrypted files and tries to obtain the password. All files must be encrypted with the same password, and the more files you provide, the better.

```bash
fcrackzip -u -D -p "$wordlist" "$zipfile"
```

The `-u` flag will try to decompress the first file by calling unzip with the guessed password. This weeds out false positives when not enough files have been given.
The `-D` flag selects dictionary mode. In this mode, fcrackzip will read passwords from a file, which must contain one password per line and should be alphabetically sorted.
The `-p` flag will set initial (starting) password for brute-force searching to string, or use the file with the name string to supply passwords for dictionary searching.

- Examples :

```bash
fcrackzip -u -D -p /tmp/wordlists/passwords/password.txt "$zipfile"
```

Uses the wordlist /tmp/wordlists/passwords/password.txt to try to crack the password.

```bash
fcrackzip -l 4-8 -u "$zipfile"
```

Brute-forces a password with a length of 4 to 8 characters.

```bash
fcrackzip --method cpmask --charset A --init AAAA "$ppmfile"
```

Checks the obscured image test.ppm for all four character passwords.

## Archive2hash conversion tools

### zip2hashcat, rar2hashcat, 7z2hashcat

`zip2hashcat` is a tool to convert zip files to a hash that can be cracked with [hashcat](/cheatsheets/hash#hashcat).
If the password is different between the files in the archive, then it will not work.

```bash
zip2hashcat "$zipfile" > "$hashfile"
```

Same for `rar2hashcat` and `7z2hashcat`.

### zip2john

Like `zip2hashcat` but for [John the Ripper](/cheatsheets/cracking/hash/#john-the-ripper)

```bash
zip2john "$zipfile" > "$hashfile"
```
