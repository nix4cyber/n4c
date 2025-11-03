---
title: "Google Dorks"
description: "Essential cheatsheet for Google Dorking, using advanced search operators to perform Open Source Intelligence (OSINT) and identify publicly exposed information or misconfigurations on target websites."
seo:
  title: "Google Dorking Cheatsheet for OSINT and Security Testing"
  description: "A comprehensive reference for advanced Google search operators (Dorks). Learn to use 'site:', 'inurl:', 'filetype:', and more for information gathering, finding leaked files, and identifying security misconfigurations ethically."
---

[Google](https://google.com) hacking, also named Google dorking, is a hacker technique that uses Google Search and other Google applications to find security holes in the configuration and computer code that websites are using.
Dorks also works on [Startpage](https://startpage.com) or [Duckduckgo](https://duckduckgo.com).

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

Replace "{target}" with a name or other identifiers used online. Always remember
to use these queries solely for legal and ethical purposes on information you
own or have permission to check.

- **File Types:**
  - `"{target}" filetype:pdf`
  - `"{target}" filetype:doc OR filetype:docx OR filetype:xls OR filetype:ppt`
  - Config files:
    `site:{target}+filetype:xml+|+filetype:conf+|+filetype:cnf+|+filetype:reg+|+filetype:inf+|+filetype:rdp+|+filetype:cfg+|+filetype:txt+|+filetype:ora+|+filetype:ini`
  - Database files: `site:{target}+filetype:sql+|+filetype:dbf+|+filetype:mdb`
  - Data files: `site:{target} ext:csv OR ext:xls OR ext:log` or `site:{target} "@gmail.com" ext:csv`
  - Log files: `site:{target}+filetype:log+|filetype:txt` - Backup files:
    `site:{target}+filetype:bkf+|+filetype:bkp+|+filetype:bak+|+filetype:old+|+filetype:backup`
  - Setup files:
    `site:{target}+inurl:readme+|+inurl:license+|+inurl:install+|+inurl:setup+|+inurl:config`
  - Private files:
    `site:{target} "internal use only" ( you can replace with "classified", "private", "unauthorised" )`
  - Sensitive docs:
    `ext:txt | ext:pdf | ext:xml | ext:xls | ext:xlsx | ext:ppt | ext:pptx | ext:doc | ext:docx intext:“confidential” | intext:“Not for Public Release” | intext:”internal use only” | intext:“do not distribute” site:{target}`
  - Code leaks: Check for code snippets, secrets, configs
    ```txt
    site:pastebin.com "{target}"
    site:jsfiddle.net "{target}"
    site:codebeautify.org "{target}"
    site:codepen.io "{target}"`
    ```
  - Cloud File Shares: Find exposed files linked to your target
    ```txt
    site:http://drive.google.com "{target}"
    site:http://docs.google.com inurl:"/d/" "{target}"
    site:http://dropbox.com/s "{target}"
    ```
  - Other: `site:{target}+filetype:pdf+|+filetype:xlsx+|+filetype:docx`

- **Social Media & Professional Networks:**
  - `site:linkedin.com/in "{target}"`
  - `site:facebook.com "{target}"`
  - `site:twitter.com "{target}"`
  - `site:instagram.com "{target}"`

- **Profile & Resume Searches:**
  - `inurl:"profile" "{target}"`
  - `intitle:"{target}" "profile"`
  - `"{target}" intext:"resume"`
  - `intitle:"Curriculum Vitae" OR intitle:"CV" "{target}"`

- **Email and Contact Information:**
  - `"{target}" intext:"@gmail.com"`
  - `"{target}" intext:"email"`
  - `"{target}" AND "contact"`

- **Forums and Public Repositories:**
  - `site:pastebin.com "{target}"`
  - `site:github.com "{target}"`
  - `site:forums "{target}"`

- **Directory Listings and Miscellaneous:**
  - `site:{target}+intitle:index.of`,

- **Exclusion Searches:**
  - `"{target}" -site:facebook.com`
  - `"{target}" -site:twitter.com`

## Advanced Google Operators

- `related:site` finds websites similar to the specified URL
- `cache:URL` displays Google’s cached version of a page, even if the site is
  offline
- `info:URL` returns a summary of what Google knows about the domain (cache,
  similar sites, inbound links, etc.)
- `define:term` shows a word or phrase definition directly in the results
- `inanchor:word` filters pages where the anchor text includes the specified
  word
- `around(n)` restricts results to pages where two words appear within _n_ words
  of each other

## Ressources

- [TakSec's google dorks](https://github.com/TakSec/google-dorks-bug-bounty/)
- [Exploit-db Google hacking database](https://www.exploit-db.com/google-hacking-database)
