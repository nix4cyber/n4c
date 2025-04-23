---
title: Google dorks
layout: page
parent: osint
---

# Google dorks

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Basics

- `-` excludes a term
- `+` includes a term
- `OR` searches for either term
- `""` searches for an exact phrase
- `*` acts as a wildcard
- `site:` restricts the search to a specific domain
- `inurl:` restricts the search to a specific URL
- `intitle:` restricts the search to a specific title
- `intext:` restricts the search to a specific text
- `allintext:` restricts the search to all text
- `filetype:` restricts the search to a specific file type
- `link:` shows pages that link to a specific URL

## Information gathering

Replace "Name" with a name or other identifiers used online.
Always remember to use these queries solely for legal and ethical purposes on information you own or have permission to check.

- **File Types:**  
  - `"Name" filetype:pdf`  
  - `"Name" filetype:doc OR filetype:docx OR filetype:xls OR filetype:ppt`  
  - `"Name" filetype:html`  

- **Social Media & Professional Networks:**  
  - `site:linkedin.com/in "Name"`  
  - `site:facebook.com "Name"`  
  - `site:twitter.com "Name"`  
  - `site:instagram.com "Name"`  

- **Profile & Resume Searches:**  
  - `inurl:"profile" "Name"`  
  - `intitle:"Name" "profile"`  
  - `"Name" intext:"resume"`  
  - `intitle:"Curriculum Vitae" OR intitle:"CV" "Name"`  

- **Email and Contact Information:**  
  - `"Name" intext:"@gmail.com"`  
  - `"Name" intext:"email"`  
  - `"Name" AND "contact"`  

- **Forums and Public Repositories:**  
  - `site:pastebin.com "Name"`  
  - `site:github.com "Name"`  
  - `site:forums "Name"`  

- **Directory Listings and Miscellaneous:**  
  - `intitle:"index of" "Name"`  
  - `allintext:"Name"`  
  - `"Name" AND "location"`  
  - `"Name" AND "address"`  
  - `"Name" AND "birthday"`  

- **Exclusion Searches:**  
  - `"Name" -site:facebook.com`  
  - `"Name" -site:twitter.com`  

## Advanced Google Operators

- `related:site` finds websites similar to the specified URL  
- `cache:URL` displays Google’s cached version of a page, even if the site is offline  
- `info:URL` returns a summary of what Google knows about the domain (cache, similar sites, inbound links, etc.)  
- `define:term` shows a word or phrase definition directly in the results  
- `inanchor:word` filters pages where the anchor text includes the specified word  
- `around(n)` restricts results to pages where two words appear within *n* words of each other  
