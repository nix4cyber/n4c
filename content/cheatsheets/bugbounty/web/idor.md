---
title: "IDOR"
description: "Complete IDOR (Insecure Direct Object Reference) testing checklist for penetration testing. Learn how to identify and exploit access control vulnerabilities by manipulating object identifiers in URLs, parameters, and API requests."
seo:
  title: "IDOR Vulnerability Testing Checklist - Insecure Direct Object Reference"
  description: "Comprehensive IDOR exploitation guide covering ID enumeration, parameter pollution, GUID manipulation, API versioning bypass, and blind IDOR detection. Essential checklist for bug bounty hunters and security testers."
---

## IDOR (Insecure Direct Object Reference)

**IDOR** is an access control vulnerability where an application uses a **direct identifier** (like an account number or user ID) without properly verifying if the requesting user is authorized to access it.

- **What is it?** It allows an attacker to simply change the identifier in a URL or request (e.g., `user_id=101` -> `user_id=102`) to view or modify another user's data.
- **Where to find it?** Anywhere identifiers (numeric, UUIDs, filenames) are sent by the user in URL paths, query parameters, or the request body.

### Checklist

- [ ] **Find and Replace IDs in urls, headers and body:** `/users/01` -> `/users/02`
- [ ] **Try Parameter Pollution:** `users=01` -> `users=01&users=02`
- [ ] **Special Characters:** `/users/01*` or `/users/*` -> Disclosure of every single user
- [ ] **Try Older versions of api endpoints:** `/api/v3/users/01` -> `/api/v1/users/02`
- [ ] **Add extension:** `/users/01` -> `/users/02.json`
- [ ] **Change Request Methods:** `POST /users/01` -> `GET, PUT, PATCH, DELETE` etc.
- [ ] **Check if Referer or some other Headers are used to validate the IDs:**

  | Request         | Referer Header         | Response      |
  | :-------------- | :--------------------- | :------------ |
  | `GET /users/02` | `example.com/users/01` | 403 Forbidden |
  | `GET /users/02` | `example.com/users/02` | 200 OK        |

- [ ] **Encrypted IDs:** If application is using encrypted IDs, try to decrypt using [online hash cracker](/cheatsheets/cracking/hash/#online-hash-cracker) or other tools.
- [ ] **Swap GUID with Numeric ID or email:**
      `/users/1b04c196-89f4-426a-b18b-ed85924ce283` -> `/users/02` or `/users/a@b.com`
- [ ] **Try GUIDs such as:**
      `00000000-0000-0000-0000-000000000000` and `11111111-1111-1111-1111-111111111111`
- [ ] **GUID Enumeration:** Try to disclose GUIDs using [Google Dorks](/cheatsheets/osint/google-dorks/), Github, [Wayback](/cheatsheets/osint/tips/#archive-search), Burp history
- [ ] **If none of the GUID Enumeration methods work then try:** `Signup, Reset Password, Other endpoints` within application and analyze response. These endpoints mostly disclose user's GUID.
- [ ] **403/401 Bypass:** If server responds back with a 403/401 then try to use burp intruder and send 50-100 requests having different IDs: Example: from `/users/01` to `/users/100`
- [ ] **If server responds with a 403/401, double check the function within the application.** Sometime 403/401 is thrown but the action is performed.
- [ ] **Blind IDOR:** Sometimes information is not directly disclosed. Lookout for endpoints and features that may disclose information such as **export files, emails or message alerts.**
