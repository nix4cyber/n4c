---
title: "403 Forbidden Bypass"
description: "Complete checklist for bypassing 403 Forbidden errors. Test various HTTP header manipulation techniques, path normalization methods, and web cache poisoning vectors to identify access control misconfigurations."
seo:
  title: "403 Forbidden Bypass Checklist - HTTP Access Control Testing"
  description: "Comprehensive 403 bypass techniques including X-Original-URL headers, path traversal, URL encoding tricks, and cache poisoning. Essential pentesting checklist for web application security."
---

A 403 Forbidden bypass refers to techniques used to circumvent HTTP access control restrictions and gain unauthorized access to protected web resources.
These methods exploit server misconfigurations through header manipulation, path obfuscation, URL encoding, and cache poisoning to access restricted endpoints that normally return a 403 status code.

## Checklist

- [ ] **Use `X-Original-URL` Header:**
  - Attempt to access the protected endpoint (e.g., `/admin`) by sending the request to a different, accessible path (e.g., `/anything`) and setting the `X-Original-URL` header to the target path.
  - Example:

  ```http
  GET /anything HTTP/1.1
  Host: target.com
  X-Original-URL: /admin
  ```

- [ ] **Append URL Encoded Dot:**
  - Try appending the URL encoded dot character (`%2e`) after the first slash of the blocked path.
  - Example: `http://target.com/%2e/admin`

- [ ] **Try Path Normalization Sequences:**
  - Attempt to confuse the path parser by adding various combinations of dots, slashes, and semicolons.
  - Examples:
    - `http://target.com/secret;/.`
    - `http://target.com/.secret/.`
    - `http://target.com//secret`
    - `http://target.com//;/secret`

- [ ] **Add Directory Traversal:**
  - Use directory traversal patterns that might be normalized out by the server after the access check.
  - Example: `http://target.com/admin..;/`

- [ ] **Uppercase Letters in URL:**
  - Try changing the case of letters in the blocked path, as some file systems or access control lists might be case-sensitive while the resource itself is not.
  - Example: `http://target.com/admiN`

- [ ] **Via Web Cache Poisoning:**
  - Attempt to use headers like `X-Original-URL` to trick a caching server into serving unauthorized content from the protected path.
  - Example:
    ```http
    GET /anything HTTP/1.1
    Host: victim.com
    X-Original-URL: /admin
    ```
