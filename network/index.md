---
title: network
layout: page
---

# 🛜 Network

Network attacks are a category of attacks that target wireless networks. These attacks can be used to gain unauthorized access to a network, intercept data, or disrupt network services. Some common network attacks include:

- Wifi Security Attacks : WEP cracking, WPA/WPA2 handshake capture, WPA3 downgrade attacks, etc.

- Denial of Service (DoS) Attacks : Deauth attacks, jamming, CTS flooding, etc.

- Man-in-the-Middle (MitM) Attacks : Evil twin attacks (Rogue AP), SSL Stripping, Wifi phishing, etc.

- Eavesdropping Attacks : Packet sniffing, traffic analysis, decoding, etc.

- Other Exploits : Default credentials, firmware vulnerabilities (RCE/ACE), etc.

## 🐚 Shell

The shell contains all the tools needed to perform the attack category & wordlists.

**Start the shell with the following command:**

```bash
nix develop --refresh github:nix4cyber/n4c#network
```

## 📦 Applications

### Wireshark

Wireshark is a network protocol analyzer. It is used to capture and analyze network traffic in real-time. It can be used to troubleshoot network issues, analyze network performance, and detect security threats.

```bash
nix-shell -p wireshark --run wireshark
```
