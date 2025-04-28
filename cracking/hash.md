---
title: Hash
layout: page
parent: cracking
---

# Hash

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Hash identification

### Haiti

You can identify what type of hash you are dealing with using the `haiti` tool. It is a Ruby script that can identify over 600 different types of hashes.

```bash
haiti <hash>
```

You can also use the `--hashcat-only` flag to only show the corresponding Hashcat mode for the hash.

```bash
hashid --hashcat-only '$1$sAdr$A419uwu583q743wllMkpo2'
```

Or you can use the `--john-only` flag to only show the corresponding John the Ripper format for the hash.

```bash
hashid --john-only '$1$sAdr$A419uwu583q743wllMkpo2'
```

### Cyberchef

You can also use [CyberChef](https://gchq.github.io/CyberChef/), whether it is online or self-hosted to identify your hash's type. Just paste the hash into the input box and select the "Analyse hash" operation. CyberChef will try to identify the hash type and display it in the output box.
CyberChef can also be used to create hashes of different types.

## Hash cracking

### Hashcat

[Hashcat](https://hashcat.net/hashcat/) is a password recovery tool that can crack hashes using various methods, including brute force, dictionary attacks, and rule-based attacks. It supports a wide range of hash types and is highly optimized for performance.

```bash
hashcat -m <hash_type> -a <attack_mode> <hash_file> [wordlist]
```

Additionally, you can use different flags and options to customize the attack. For example, you can use the `-r` flag to specify a rule file (only works with the dictionary attack), or the `-w` flag to set the workload profile (up to 4, where 4 is the highest and most aggressive). You can also use the `-O` flag to enable optimized kernel, which can speed up the cracking process for certain hash types but has limits with bigger passwords and can sometimes slow the cracking down. Finally, you can also use `--opencl-device-types 1,2` to use both your CPU and your GPU for cracking.

**Below is an example of a command to crack a hash (from [hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)) using Hashcat and with various arguments:**

```bash
hashcat -m 500 -o result.txt --potfile-disable -r /tmp/OneRuleToRuleThemStill/OneRuleToRuleThemStill.rule --username "administrator:\$1\$28772684\$iEwNOgGugqO9.bIz5sk8k/" /tmp/wordlists/passwords/password.txt -w 4 --opencl-device-types 1,2 
```

What's best to do is to test different combinations of arguments in the first running seconds to see how you can get the best performance out of your machine for this specific hash type.

- **Bruteforce example:**

```bash
hashcat -m 500 hash.txt -a  3  ?1?1?1?1?1?1?1?1 --increment -1 ?l?d?u
```

### John the Ripper

[John the Ripper](https://www.openwall.com/john/) is another popular password recovery tool that can crack hashes using various methods, including brute force and dictionary attacks. It supports a wide range of hash types and is highly optimized for performance.

```bash
john --format=<hash_type> --wordlist=<wordlist> <hash_file>
```

- **Examples** :

```bash
john --mask="?d?d?d?d" passwords.txt
```

This command will try to crack the password using a mask attack with 4 digits.

```bash
john --format=md5 --wordlist=rockyou.txt --rules passwords.txt
```

This command will try to crack the password (which is md5 hash) using the rockyou.txt wordlist and applying rules to modify the words in the list.

### Crackstation

[Crackstation](https://crackstation.net/) is a free online hash cracking service that can crack various hash types using a large database of precomputed hashes. It is useful for quickly cracking hashes without the need to set up your own cracking environment.
Recommended for beginner users or for quick tests.
