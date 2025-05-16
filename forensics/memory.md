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

## Volatility 2

[Volatility 2](https://github.com/volatilityfoundation/volatility3) is a framework for extracting digital artifacts from volatile memory (RAM) samples.
Note that this is the older version of Volatility, and it may not support the latest memory dump formats or operating systems.
Below are some of the most common commands you can use with Volatility 2.

### Options

`-h` or `--help` will show you the help menu, and list all the available options and plugins.

```bash
volatility2 -h
```

`-f` is used to specify the memory dump file.

```bash
volatility2 -f <dump_file>
```

`--profile` is used to specify the profile of the memory dump. You can find the list of available profiles with the `imageinfo` command.

```bash
volatility2 -f <dump_file> --profile=<profile>
```

`-v` is used to enable verbose mode, and `-p` is used to specify the PID of a process.

```bash
volatility2 -f <dump_file> --profile=<profile> -v -p <pid>
```

### Retrieve profile

The first step is to identify the profile of the memory dump. This is important because different Operating Systems and their own versions have different structures.

```bash
volatility2 -f <dump_file> imageinfo
```

### Process listing

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

Finally, you can use the `psxview` command to find hidden processes with various process listings.

```bash
volatility2 -f <dump_file> --profile=<profile> psxview
```

### Services

You can list the services running in the memory dump with the `svcscan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> svcscan
```

### Memory dumps

You can dump the memory of a process with the `memdump` command.

```bash
volatility2 -f <dump_file> --profile=<profile> memdump -p <pid> -D <output_directory>
```

Or you can even dump the memory of all processes by removing the `-p` option. Once you have the memory dumps, using `strings` combined with `grep` can be useful to find interesting strings in the memory dumps.

### Network scanning

You can scan the memory dump for network connections with the `netscan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> netscan
```

Using `sockets`, you can see the sockets that are open in the memory dump.

```bash
volatility2 -f <dump_file> --profile=<profile> sockets
```

### Command history

You can see the command-line arguments that were used to launch each running processes with the `cmdline` command.

```bash
volatility2 -f <dump_file> --profile=<profile> cmdline
```

You can also see the command history with the `cmdscan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> cmdscan
```

Alternatively, you can use the `consoles` command to see the command history of all processes.

```bash
volatility2 -f <dump_file> --profile=<profile> consoles
```

### User information

You can list the details of user logon sessions with the `sessions` command.

```bash
volatility2 -f <dump_file> --profile=<profile> sessions
```

You can also inspect the environment variables with the `envars` command.

```bash
volatility2 -f <dump_file> --profile=<profile> envars
```

### Hash dumping

You can dump the account hashes in the memory dump with the `hashdump` command.

```bash
volatility2 -f <dump_file> --profile=<profile> hashdump
```

### Process dumping

You can dump a process to an executable file sample with the `procdump` command.

```bash
volatility2 -f <dump_file> --profile=<profile> procdump -p <pid> -D <output_directory>
```

### File analysis

You can list the file structure in the memory dump with the `filescan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> filescan
```

### Registry analysis

You can analyze the registry in the memory dump with the `hivelist` command.

```bash
volatility2 -f <dump_file> --profile=<profile> hivelist
```

With this, you can use the `hivedump` command to dump the registry hives.

```bash
volatility2 -f <dump_file> --profile=<profile> hivedump -o <hive_offset>
```

You can then use the 'printkey' command to print the keys in a hive (key matches the name field in the output of the hivelist command).

```bash
volatility2 -f <dump_file> --profile=<profile> printkey [-K "<key>"]
```

You can also use the `userassist` command to list the user assist keys and information in the memory dump.

```bash
volatility2 -f <dump_file> --profile=<profile> userassist
```

Finally, the `handles` command can be used to list the open handles of processes.

```bash
volatility2 -f <dump_file> --profile=<profile> handles
```

### Modules and libraries analysis

You can list the loaded modules (which include drivers) with the `modules` command.

```bash
volatility2 -f <dump_file> --profile=<profile> modules
```

You can also list the loaded DLLs for processes with the `dlllist` command.

```bash
volatility2 -f <dump_file> --profile=<profile> dlllist
```

### Malware detection artifacts

You can use the `malfind` command to detect malware in the memory dump.

```bash
volatility2 -f <dump_file> --profile=<profile> malfind
```

Analyzing mutexes can also be useful for detecting malware, and you can use the `mutantscan` command for that.

```bash
volatility2 -f <dump_file> --profile=<profile> mutantscan
```

Inspecting callbacks can also help in detecting malware, and you can use the `callbacks` command for that.

```bash
volatility2 -f <dump_file> --profile=<profile> callbacks
```

### Yara signatures

You can use Yara signatures to detect malware in the memory dump with the `yarascan` command.

```bash
volatility2 -f <dump_file> --profile=<profile> yarascan -y <yara_file>
```
