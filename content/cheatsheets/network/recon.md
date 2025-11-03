---
title: "Scanning"
description: "A comprehensive cybersecurity cheatsheet for network and port scanning. Covers fast scanning with Masscan and detailed analysis with Nmap, including target specification, scan types, version detection, and output formats."
seo:
  title: "Network and Port Scanning Cheatsheet (Masscan & Nmap) for Security"
  description: "Essential reference guide for security professionals on network and port scanning. Quick commands for Masscan and in-depth techniques for Nmap (Host Discovery, Scan Types, Version Detection, Evasion, and NSE scripts)."
---

## Masscan

Masscan is a fast port scanner that can be used to scan large networks quickly. It is capable of scanning the entire Internet in under 5 minutes, making it one of the fastest port scanners available.

### Target specification

If you want to scan a specific host, you can use the following command:

```bash
masscan "$ip" -p "$port"
```

If you want to scan a subnet, you can use the following command:

```bash
masscan "$ip/$subnet" -p "$port"
```

Excluding an IP address can be done using the `--exclude` option:

```bash
masscan "$ip/$subnet" --exclude="$ip1" -p "$port"
```

### Port specification

You can specify which ports to scan using the `-p` option. You can specify a single port, a range of ports, a list of ports and more.

```bash
masscan "$ip" -p "$port"
masscan "$ip" -p "$port1,$port2,$port3"
masscan "$ip" -p "$port1-$port2"
```

You can scan all ports using the `-p 0-65535` option:

```bash
masscan "$ip" -p 0-65535
```

You can also do an UDP scan using the `-pU` option:

```bash
masscan "$ip" -pU "$port"
```

You can also scan the most common ports using the `--top-ports` option:

```bash
masscan "$ip" --top-ports "$number_of_ports"
```

### Timing and Performance

The `--offline` option can be used in order to not send any traffic but to estimate the time it would take to scan the target.

```bash
masscan "$ip" --offline
```

You can use the `--rate` option to set the rate of packets per second. The default is 100 packets per second.

```bash
masscan "$ip" --rate "$packets_per_second"
```

### Output formats

Masscan can be used to output the scan results in various formats. You can use the `-oB` option to output the results in binary format:

```bash
masscan "$ip" -oB output_file.bin
```

You can then read a binary output using the `--readscan` option:

```bash
masscan --readscan output_file.bin
```

You can use the `-oG` option to output the results in grepable format:

```bash
masscan "$ip" -oG output_file.grep
```

You can use the `-oL` option to output the results in list format:

```bash
masscan "$ip" -oL output_file.list
```

### Other options

You can use the `--banners` option to enable banner grabbing:

```bash
masscan "$ip" --banners
```

Although this option works better with the `--source-ip` option:

```bash
masscan "$ip" --banners --source-ip "$altip"
```

You can include a ping scan using the `--ping` option:

```bash
masscan "$ip" --ping
```

Saving the sent packets in a pcap file can be done using the `--pcap` option:

```bash
masscan "$ip" --pcap output_file.pcap
```

### Useful examples

- **Quick port identification:**

```bash
masscan "$ip/$subnet" -p 0-65535 --rate 1000000 --open-only --http-user-agent \
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0"\
 -oL output_file.list
```

- **Mutiple targets specific scan:**

```bash
masscan "$target1" "$target2" "$target3" -p 80,433 --rate 100000 --banners --open-only \
--http-user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0"\
--source-ip "$altip" -oL output_file.pcap
```

## Nmap

Nmap is the original powerful network scanning tool that can be used to discover hosts, services, OSes and even more, although it is not as fast as masscan. As a random reddit user said, "Masscan is like a flamethrower, where Nmap is like a precision tool".

### Target specification

If you want to scan a specific host, you can use the following command:

```bash
nmap "$ip"
```

If you want to scan a range of IP addresses, you can use the following command:

```bash
nmap "$ip1-$ip2"
```

If you want to scan a subnet, you can use the following command:

```bash
nmap "$ip/$subnet"
```

Finally, if you want to scan a list of IP addresses from a file, you can use the following command:

```bash
nmap -iL ips.txt
```

### Host discovery

Nmap can be used to discover hosts on a network. By default, Nmap will perform host discovery before scanning. You can disable host discovery using the `-Pn` option:

```bash
nmap -Pn "$ip"
```

Likewise, you can use the `-sn` option to perform host discovery only:

```bash
nmap -sn "$ip"
```

### Scan types

Nmap supports a variety of scan types. Here are some of the most common ones:

- **TCP SYN port scan**: This is the default scan type as root. It sends a SYN packet to each port and waits for a response. If a SYN-ACK packet is received, the port is open. If a RST packet is received, the port is closed. This scan type is fast and stealthy.

```bash
nmap -sS "$ip"
```

- **TCP connect port scan**: This scan type is similar to the TCP SYN scan. It is slower and less stealthy than the TCP SYN scan.

```bash
nmap -sT "$ip"
```

- **TCP ACK port scan**: This scan type is used to map out firewall rulesets. It sends an ACK packet to each port and waits for a response. If a RST packet is received, the port is unfiltered. If no response is received, the port is filtered.

```bash
nmap -sA "$ip"
```

- **UDP port scan**: This scan type sends a UDP packet to the desired ports. If an ICMP port unreachable message is received, the port is closed. If no response is received, the port is open or filtered.

```bash
nmap -sU "$ip"
```

### Port specification

You can specify which ports to scan using the `-p` option. You can specify a single port, a range of ports, a list of ports and more.

```bash
nmap "$ip" -p "$port"
nmap "$ip" -p "$port1,$port2,$port3"
nmap "$ip" -p "$port1-$port2"
```

You can scan all ports using the `-p-` option:

```bash
nmap "$ip" -p-
```

You can also scan the most common ports using the `-top-ports` option:

```bash
nmap "$ip" -top-ports "$number_of_ports"
```

### Detection

All of the further options are used to detect the services, versions and operating system of the target. You can use the `-A` option to enable all of these immediately:

```bash
nmap "$ip" -A
```

Nmap can be used to detect the services and versions running on the open ports. You can use the `-sV` option to enable service and version detection:

```bash
nmap "$ip" -sV
```

You can also use the `-sV -version-intensity` option to set the intensity of the version detection. Going from 0 to 9, where 0 is the least intensive and 9 is the most intensive.

```bash
nmap "$ip" -sV -version-intensity "$intensity"
```

You can detect the operating system of the target using the `-O` option:

```bash
nmap "$ip" -O
```

### Performance

Nmap can be used to speed up the scanning process. You can use the `-T` option to adjust the scan speed and stealth based on your target environment and detection risk. The timing templates go from 0 to 5, where 0 is the slowest and 5 is the fastest, default being 3.

```bash
nmap "$ip" -T"$template"
```

You can also use options like `-min-rate`, `-max-rate`, `-min-parallelism`, `-max-parallelism`, `-max-retries`, `-host-timeout`, `-min-hostgroup`, `-max-hostgroup`, and more to tune how the scan is performed.

### Firewalls and IDS Evasion/Spoofing

Nmap can be used to evade firewalls and intrusion detection systems (IDS). You can use the `-f` option to fragment the packets:

```bash
nmap "$ip" -f
```

You can also use the `-mtu` option to set the maximum transmission unit (MTU) of the packets:

```bash
nmap "$ip" -mtu "$mtu"
```

The `-D` option can be used to decoy the scan by sending packets from multiple IP addresses:

```bash
nmap "$ip" -D "$decoy1,$decoy2,$decoy3,$your_ip,$decoy4"
```

You can also use the `-S` option to spoof the source IP address of the packets:

```bash
nmap "$ip" -S "$spoofed_ip"
```

You can use the `-e` option to specify the network interface to use for the scan:

```bash
nmap "$ip" -e "$interface"
```

You can use the `-proxies` option to relay connections through proxies:

```bash
nmap "$ip" -proxies "$proxy1,$proxy2,$proxy3"
```

You can use the `--data-length` option to add random data to the packets:

```bash
nmap "$ip" --data-length "$length"
```

### NSE (Nmap Scripting Engine)

Nmap has a powerful scripting engine that can be used to automate tasks and perform advanced scans. You can use the `-sC` option to enable the default scripts, which allows you to get more information about the services running on the target:

```bash
nmap "$ip" -sC
```

You can also use the `-script` option to specify a specific script or a category of scripts:

```bash
nmap "$ip" -script="$category" #eg http*,banner
```

You can remove the intrusive scripts as such:

```bash
nmap "$ip" -script "not intrusive"
```

You can also use the `-script-args` option to pass arguments to the scripts:

```bash
nmap "$ip" -script-args "$arg1=$value1,$arg2=$value2"
```

Some useful scripts include:

```bash
nmap -n -Pn -p 80 -open -sV -vvv -script banner,http-title -iR 1000 # searches random web servers
nmap -script whois* domain.com # whois lookup
```

Vulnerability scanning examples:

```bash
nmap -p80 -script http-sql-injection "$ip"
nmap -p80 -script http-unsafe-output-escaping "$ip"
```

### Output formats

Nmap can be used to output the scan results in various formats. You can use the `-oN` option to output the results in normal format:

```bash
nmap "$ip" -oN output_file.txt
```

You can use the `-oX` option to output the results in XML format:

```bash
nmap "$ip" -oX output_file.xml
```

You can use the `-oG` option to output the results in grepable format:

```bash
nmap "$ip" -oG output_file.grep
```

And there are many more formats available, feel free to check the [Nmap documentation](https://nmap.org/book/man-output.html) for more information.
