---
title: Login
layout: page
parent: cracking
---

# Login

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Login bypass tools

### Hydra

[Hydra](https://github.com/vanhauser-thc/thc-hydra) is a very fast and flexible login cracker that supports many different protocols. It can be used to perform brute-force attacks against various services, including HTTP, FTP, SSH, and more.

```bash
hydra -l user -P passlist.txt ftp://192.168.0.1
```

You can also use the `-t` flag to define the number of connects in parallel per target which is defaulted to 16, or use the `-m` flag for more options specific to each module.

- Other examples :

```bash
  hydra -L userlist.txt -p defaultpw imap://192.168.0.1/PLAIN
  hydra -C defaults.txt -6 pop3s://[2001:db8::1]:143/TLS:DIGEST-MD5
  hydra -l admin -p password ftp://[192.168.0.0/24]/
  hydra -L logins.txt -P pws.txt -M targets.txt ssh
```

### Medusa

[Medusa](https://github.com/jmk-foofus/medusa) is a speedy, parallel, and modular, login brute-forcer.
There are many other modules that are supported such as :

- CVS
- FTP
- HTTP
- RLOGIN
- SSHv2

To display them, simply use this command :

```bash
medusa -d
```

And to get specific options for a given module :

```bash
medusa -M smbnt -q
```

The following command instructs Medusa to test all passwords listed in passwords.txt against a single user (administrator) on the host 192.168.0.20 via the SMB service. The "-e ns" instructs Medusa to additionally check if the administrator account has either a blank password or has its password set to match its username (administrator).

```bash
medusa -h 192.168.0.20 -u administrator -P passwords.txt -e ns -M smbnt
```
