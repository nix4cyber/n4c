---
title: "Archive"
description: ""
seo:
  title: ""
  description: ""
---

## Zip cracking

### Fcrackzip

fcrackzip searches each given zipfile for encrypted files and tries to obtain the password. All files must be encrypted with the same password, and the more files you provide, the better.

```bash
fcrackzip -u -D -p [wordlist] [ZIP file]
```

The `-u` flag will try to decompress the first file by calling unzip with the guessed password. This weeds out false positives when not enough files have been given.
The `-D` flag selects dictionary mode. In this mode, fcrackzip will read passwords from a file, which must contain one password per line and should be alphabetically sorted.
The `-p` flag will set initial (starting) password for brute-force searching to string, or use the file with the name string to supply passwords for dictionary searching.

- Examples :

```bash
fcrackzip -u -D -p /tmp/wordlists/passwords/password.txt ~/file.zip
```

Use the wordlist /tmp/wordlists/passwords/password.txt to try to crack the password of the zip file ~/file.zip.

```bash
fcrackzip -c a -p aaaaaa sample.zip
```

Checks the encrypted files in sample.zip for all lowercase 6 character passwords in the first place.

```bash
fcrackzip --method cpmask --charset A --init AAAA test.ppm
```

Checks the obscured image test.ppm for all four character passwords.

## Archive2hash conversion tools

### zip2hashcat, rar2hashcat, 7z2hashcat

zip2hashcat is a tool to convert zip files to a hash that can be cracked with hashcat. If the password is different between the files in the arhcive, then it will not work.

```bash
zip2hashcat files.zip > hash.txt
```

Same for rar2hashcat and 7z2hashcat.

### zip2john

```bash
zip2john files.zip > hash.txt
```
