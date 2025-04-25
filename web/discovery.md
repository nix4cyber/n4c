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

```bash
katana -c 15 -p 15 -u $target > output
```
