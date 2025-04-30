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

A spider is a tool that crawls a website and collects information about its structure and content. It can be used to find hidden directories, files, and parameters.

```bash
katana -c 15 -p 15 -u $target > output
```
