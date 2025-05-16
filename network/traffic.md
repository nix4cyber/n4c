---
title: Traffic
layout: page
parent: network
---

# Traffic

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Wireshark

Wireshark is a network protocol analyzer. It is used to capture and analyze network traffic in real-time, or to analyze past captures. It can be used to troubleshoot network issues, analyze network performance, and detect security threats.

To start Wireshark, run the following command:

```bash
wireshark
```

Here's a [cheatsheet](https://assets.ctfassets.net/kvf8rpi09wgk/a2PBJT7Qq9XL7Bbf81Ajh/e28b9c889edc13ddb1e81ed5ce678809/Wireshark_Cheat_Sheet__6_.pdf) to help you get started with Wireshark.

## tshark

tshark is the command-line version of Wireshark. It can be used for the same purposes as Wireshark, but it is more suitable for scripting and automation.

### List interfaces

To list all the available network interfaces, run the following command:

```bash
tshark -D
```

### Capture packets

To capture packets on a specific interface, run the following command:

```bash
tshark -i <interface>
```

You can specify a duration with the `-a` option (in seconds), specify a file to save the capture with the `-w` option, and specify a filter with the `-f` option:

Example :

```bash
tshark -i <interface> -a duration:60 -w capture.pcap -f "port bootpc"
```

### Working with Capture Files

tshark is commonly used to analyze previously saved packet capture files (`.pcap` or `.pcapng`). To read a capture file, use the `-r` option followed by the filename:

```bash
tshark -r <capture_file>
```

Use the `-Y` option to apply a display filter to the packets in the capture file. For example, to filter for HTTP GET requests in a capture file, you can use:

```bash
tshark -r <capture_file> -Y "http.request.method==GET"
```

Or to only display ICMP packets, specifically echo requests (type 8):

```bash
tshark -r <capture_file> -Y "icmp.type==8"
```

There are also capture filters that can be applied when reading a file. For example, to filter for packets from a specific IP address:

```bash
tshark -r <capture_file> -f "<ip_address>"
```

Or to capture ICMPv6 traffic between two specific IP addresses on a specific interface:

```bash
tshark -ni <interface> -f "host <ip1> and host <ip2> and ip6 proto icmp6" 
```

### Extracting Specific Fields

The `-T fields` option is incredibly useful for extracting specific data fields from packets, making it easy to parse tshark output for scripting or further analysis with other tools. The `-e` option is used to specify the fields you want to extract.

For instance, to capture HTTP requests and display the `http.host` and `http.user_agent` fields:

```bash
tshark -i <interface> -Y http.request -T fields -e http.host -e http.user_agent
```

To capture DNS queries and display the query name and the corresponding response address:

```bash
tshark -i <interface> -f "udp port 53" -n -T fields -e dns.qry.name -e dns.resp.addr
```

You can also do this with a capture file, as shown below:

```bash
tshark -r example.pcap -Y http.request -T fields -e http.host -e ip.dst -e http.request.full_uri
```

### Analyzing Specific Protocols (HTTP, SSL/TLS)

tshark's display filters and field extraction capabilities are powerful for analyzing specific application-layer protocols, for instance, we can analyze HTTP POST requests containing the string "password" :

```bash
tshark -i <interface> -Y 'http.request.method == POST and tcp contains "password"' | grep password
```

The following command extracts the source IP, destination IP, and the Server Name Indication (SNI) from Client Hello messages (handshake type 1). The SNI is particularly useful as it's often sent unencrypted, revealing the target domain even in encrypted traffic.

```bash
tshark -n -r <capture_file> -Y 'ssl.handshake.type==1' -T fields -e ip.src -e ip.dst -e ssl.handshake.extensions_server_name
```

### Statistical Analysis

tshark can generate various statistics from captured traffic using the `-q` and `-z` options.

To get a breakdown of the protocols present in a capture file, you can use the following command:

```bash
tshark -r HTTP_Traffic.pcap -q -z io,phs
```

tshark's output can be piped to standard Unix tools for further analysis (as you saw with `grep` before). For example, to count the occurrences of different HTTP User-Agent strings in a capture file:

```bash
tshark -r example.pcap -Y http.request -T fields -e http.user_agent | sort | uniq -c | sort -rn | head -30
```

This extracts user agents, sorts them, counts unique occurrences, sorts the counts in reverse numerical order, and shows the top 30.
