---
title: Discovery
layout: page
parent: web
---

# Discovery

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Directory discovery

### Robots.txt

```bash
curl -s $url/robots.txt
```

### Dirb

```bash
dirb $url
```

### Go buster

```bash
gobuster dir -u $url -w $wordlist -t 50
```

### Spider

A spider is a tool that crawls a website and collects information about its
structure and content. It can be used to find hidden directories, files, and
parameters.

```bash
katana -c 15 -p 15 -u $target > output
```

## Subdomain discovery

### Dmarc

DMARC can reveal more domains associated with a target.

Go to `dmarc.live/info/yourTarget.com`, it allows you to find domains using the
same DMARC record.

## Fuff

**Fuff (or ffuf)** is a fast web fuzzer written in Go, mainly used in
cybersecurity to discover hidden directories, files, API endpoints, subdomains,
vhosts and more. Its speed and flexibility make it a must-have for pentesters
and bug bounty hunters.

```bash
# Flags:
# -rate 50 -t 50 # Limit requests to 50 per second with 50 concurrent threads
# -ic # Ignore case
# -c # Colored output
# -X POST|GET|PUT # Set method
# -e .php,.asp,.bak,.db # Set the extension
# -recursion -recursion-depth 3 # Recursive fuzzing up to 3 levels deep
# -fc 404,500 # Exclude responses with status codes 404 and 500

# Examples:
ffuf -w wordlist.txt -u https://domain.com/FUZZ # Basic directory/file fuzzing using a wordlist
ffuf -w subdomains.txt -u https://FUZZ.domain.com # Subdomain fuzzing
ffuf -w vhosts.txt -u https://domain.com -H "Host: http://FUZZ.domain.com" # Virtual host fuzzing by modifying the Host header
ffuf -w wordlist.txt -u https://domain.com/page.php?FUZZ=value # GET parameter fuzzing in the query string
ffuf -w wordlist.txt -u https://domain.com/api -X POST -d 'FUZZ=value' # POST body parameter fuzzing
ffuf -w wordlist.txt -u https://domain.com/FUZZ -b 'session=abcdef' # Use a session cookie during fuzzing
ffuf -w headers.txt -u https://domain.com -H "X-Custom-Header: FUZZ" # HTTP header fuzzing
ffuf -w passwords.txt -X POST -d "username=admin&password=FUZZ" -u https://domain.com/login # Password brute-forcing for user "admin"
ffuf -w users.txt:USER -w passwords.txt:PASS -u "https://domain.com/login?username=USER&password=PASS" -mode pitchfork # Pitchfork mode: matches each line from both wordlists (USER[i], PASS[i])
ffuf -w users.txt:USER -w passwords.txt:PASS -u "https://domain.com/login?username=USER&password=PASS" -mode clusterbomb # Clusterbomb mode: tests every user with every password combination
```

## File upload

Here's some [google dorks](../osint/google-dorks.md) to find file upload
vulnerabilities:

```txt
site:http://domain.com "Select File"
site:http://domain.com "Browse"
site:http://domain.com "Drag and drop your file"
site:http://domain.com "Attach File"
site:http://domain.com "Select files"
site:http://domain.com "File upload"
site:http://domain.com "Upload your file"
site:http://domain.com "Submit File"
site:http://domain.com "Upload Documents"
site:http://domain.com "Upload Image"
site:http://domain.com "Drop files here to upload"
site:http://domain.com "Choose files to upload"
site:http://domain.com "Add File"
site:http://domain.com "Upload PDF"
site:http://domain.com "Upload Video"
site:http://domain.com "Upload Photo"
site:http://domain.com "Import File"
site:http://domain.com "Upload Resume"
site:http://domain.com "Upload files"
site:http://domain.com "Upload and Submit"
site:http://domain.com "Choose a file"
site:http://domain.com "Click to upload"
site:http://domain.com "Choose an image to upload"
```
