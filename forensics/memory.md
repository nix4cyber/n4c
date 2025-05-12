---
title: Memory
layout: page
parent: forensics
---

# Memory

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Memory investigation

### Volatility 2

[Volatility 2](https://github.com/volatilityfoundation/volatility3) is a framework for extracting digital artifacts from volatile memory (RAM) samples.
Note that this is the older version of Volatility, and it may not support the latest memory dump formats or operating systems.

#### Retrieve profile

The first step is to identify the profile of the memory dump. This is important because different Operating Systems and their own versions have different structures.

```bash
volatility2 -f <dump_file> imageinfo
```

#### Process listing

Then, you can list the processes running in the memory dump with the profile you just retrieved.

```bash
volatility2 -f <dump_file> --profile=<profile> pslist
```

If you do not trust the linked list of the processes, you can search for the processes in the memory dump using the `psscan` command, and you'll even see processes hidden by rootkit for instance.

```bash
volatility2 -f <dump_file> --profile=<profile> psscan
```

If you want to see the processes in a tree format, you can use the `pstree` command.

```bash
volatility2 -f <dump_file> --profile=<profile> pstree
```

#### Memory dumps

You can also dump the memory of a process with the `memdump` command.

```bash
volatility2 -f <dump_file> --profile=<profile> memdump -p <pid> -D <output_directory>
```

#### Network scanning

You can also scan the memory dump for network connections with the `netscan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> netscan
```

#### Command-line arguments

You can also see the command-line arguments that were used to launch each running process with the `cmdline` command.

```bash
volatility2 -f <dump_file> --profile=<profile> cmdline -p <pid>
```

#### Registry analysis

You can also analyze the registry in the memory dump with the `hivelist` command.

```bash
volatility2 -f <dump_file> --profile=<profile> hivelist
```

You can then use the 'printkey' command to print the keys in a hive (key matches the name field in the output of the hivelist command).

```bash
volatility2 -f <dump_file> --profile=<profile> printkey -K "<key>" -p <pid>
```

#### Hash dumping

You can also dump the hashes of the processes in the memory dump with the `hashdump` command.

```bash
volatility2 -f <dump_file> --profile=<profile> hashdump
```
