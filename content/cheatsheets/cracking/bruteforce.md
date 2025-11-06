---
title: "Bruteforce"
description: "Essential bruteforce attack tools and techniques for credential testing. Master Hydra and Medusa to perform parallel login attacks against FTP, SSH, HTTP, MySQL, SMB, and other network services using wordlists and dictionary attacks."
seo:
  title: "Bruteforce Attack Guide - Hydra & Medusa Password Cracking"
  description: "Complete bruteforce tutorial using Hydra and Medusa for penetration testing. Learn parallel login attacks against SSH, FTP, HTTP Basic Auth, MySQL, VNC, SMB, and IMAP with practical command examples and optimization techniques."
---

## Hydra

[Hydra](https://github.com/vanhauser-thc/thc-hydra) is a very fast and flexible login cracker that supports many different protocols. It can be used to perform brute-force attacks against various services, including HTTP, FTP, SSH, and more.

```bash
hydra -l $user -P $wordlist ftp://$target_ip
```

You can also use the `-t` flag to define the number of connects in parallel per target which is defaulted to 16, or use the `-m` flag for more options specific to each module.
The uppercase flags are to be used when you want to use a list (when you don't know this credential), and the lowercase when you know this login information.

- Basic HTTP auth :

```bash
hydra -L $userlist -P $wordlist -u -f $target_ip -s $port http-get /
```

- SSH :

```bash
hydra -l $user -P $wordlist -u -f ssh://$target_ip:$port -t 4
```

- VNC :

```bash
hydra -l $user -P $wordlist -s $port $target_ip vnc
```

- Other examples :

```bash
  hydra -L $user_list -p $password imap://$target_ip/PLAIN
  hydra -L $user_list -P $wordlist -M $target_list ssh
```

## Medusa

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

The following command instructs Medusa to test all passwords listed in the wordlist against a single user on a given host via the SMB service. The "-e ns" instructs Medusa to additionally check if the administrator account has either a blank password or has its password set to match its username (administrator).

```bash
medusa -h $target_ip -u $user -P $wordlist -e ns -M smbnt
```
