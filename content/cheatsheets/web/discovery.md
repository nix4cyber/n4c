---
title: "Discovery"
description: ""
seo:
  title: ""
  description: ""
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
katana -c 15 -p 15 -u $url > output
```

## Subdomain discovery

### Dmarc

DMARC can reveal more domains associated with a target.

Go to `dmarc.live/info/domain.com`, it allows you to find domains using the
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
ffuf -w wordlist.txt -u $url/FUZZ # Basic directory/file fuzzing using a wordlist
ffuf -w subdomains.txt -u https://FUZZ.$url # Subdomain fuzzing
ffuf -w vhosts.txt -u $url -H "Host: https://FUZZ.$url" # Virtual host fuzzing by modifying the Host header
ffuf -w wordlist.txt -u $url/page.php?FUZZ=value # GET parameter fuzzing in the query string
ffuf -w wordlist.txt -u $url/api -X POST -d 'FUZZ=value' # POST body parameter fuzzing
ffuf -w wordlist.txt -u $url/FUZZ -b 'session=abcdef' # Use a session cookie during fuzzing
ffuf -w headers.txt -u $url -H "X-Custom-Header: FUZZ" # HTTP header fuzzing
ffuf -w passwords.txt -X POST -d "username=admin&password=FUZZ" -u $url/login # Password brute-forcing for user "admin"
ffuf -w users.txt:USER -w passwords.txt:PASS -u "$url/login?username=USER&password=PASS" -mode pitchfork # Pitchfork mode: matches each line from both wordlists (USER[i], PASS[i])
ffuf -w users.txt:USER -w passwords.txt:PASS -u "$url/login?username=USER&password=PASS" -mode clusterbomb # Clusterbomb mode: tests every user with every password combination
```

## File upload

Here's some [google dorks](../osint/google-dorks.md) to find file upload
vulnerabilities:

```txt
site:https://domain.com "Select File"
site:https://domain.com "Browse"
site:https://domain.com "Drag and drop your file"
site:https://domain.com "Attach File"
site:https://domain.com "Select files"
site:https://domain.com "File upload"
site:https://domain.com "Upload your file"
site:https://domain.com "Submit File"
site:https://domain.com "Upload Documents"
site:https://domain.com "Upload Image"
site:https://domain.com "Drop files here to upload"
site:https://domain.com "Choose files to upload"
site:https://domain.com "Add File"
site:https://domain.com "Upload PDF"
site:https://domain.com "Upload Video"
site:https://domain.com "Upload Photo"
site:https://domain.com "Import File"
site:https://domain.com "Upload Resume"
site:https://domain.com "Upload files"
site:https://domain.com "Upload and Submit"
site:https://domain.com "Choose a file"
site:https://domain.com "Click to upload"
site:https://domain.com "Choose an image to upload"
```

## Leaked credentials

### With a browser

1. Open DevTools: In Chrome, navigate to the site you're inspecting, then open
   Developer Tools with Ctrl+Shift+I (Windows/Linux) or Cmd+Option+I (macOS).
2. Go to Network Tab: Click on the "Network" tab.
3. Enable Regex Search: Click the regex icon in the filter bar to enable regex
   mode.
4. Refresh Page: Refresh the page to load all network requests.
5. Apply Regex: Paste the given regex into the filter bar to search for patterns
   indicating leaked credentials.

{{< details "Show the regex" >}}

```txt
(
  (access(_key|_token)?|accessid|accessid_secret|account(_key|_sid)?|
  admin(_pass(word)?|_user)?|
  (algolia|aws|gcp|azure|heroku|firebase|github|gitlab|slack|datadog|stripe|twilio|vercel|supabase|sendgrid|cloudinary|cloudflare|bitbucket|npm|netlify|auth0|okta|sentry)_?(api|secret|access)?_?(key|token|id|sid|secret)?|
  ansible_vault_password|aos_key|
  api(_key|_secret|_token|Key|Secret|KeySid)?|
  app_(debug|id|key|secret|log_level)|application(_key|_id|_secret)?|
  auth(_token|_secret|orization)?|authkey|authsecret|bearer[_ ]?token|
  bucket(_password|_key)?|
  cert(_pass(word)?)?|certificate_password|
  client(_id|_secret)?|
  codecov_token|consumer_(key|secret)|
  conn(_string|\.login)?|connection(string)?|
  credentials?|crypt(_key|_secret)?|
  db(_password|_passwd|_user(name)?|server)?|
  deploy(_key|_password|_token)?|
  docker(_pass(word)?|_key)?|dockerhub(_password)?|
  encryption_(key|password)|
  env\.(heroku|sonatype)_(api_key|password)|
  firebase(_secret|_api_key)?|
  github(_token|_key|_client_secret)?|gitlab_token|
  jwt|jwt_secret|json_web_token|
  keycloak_secret|kubernetes_token|
  ldap_(password|bindpw)|login(_password|_token)?|
  mail(_password|_smtp_pass)?|
  mysql(_password|_user)?|mongo(_password|_user)?|
  netlify_token|npm(_token|_auth_token)?|
  oauth(_token|_secret)?|
  openai_(api_key|secret)?|
  pass(word)?|passwd|
  private(_key|_token)?|
  rds_password|
  s3(_key|_secret|_access_key_id)?|
  secret(_key|_token|_id)?|
  security_token|
  sendgrid_api_key|
  ses(_smtp|_access|_secret)?|
  service(_account|_key|_token)?|
  slack(_token|_secret|_hook)?|
  smtp_(pass(word)?|secret)?|
  sonar_token|
  ssh(_key|_private_key|_rsa)?|
  stripe_(secret|token|key)?|
  supabase(_anon|_service)?_key|
  symfony_secret|
  telegram_bot_token|
  token|
  travis_token|
  twilio(_account_sid|_auth_token)?|
  vault(_token|_secret)?|
  webhook(_secret|_token)?|
  zapier_webhook_token
  )
  [a-z0-9_\-\.]{0,25}
)
```

{{< /details >}}

6. Review Matches: Manually inspect the filtered requests to identify potential
   leaks.

### Using Burpsuite

1. Launch Burp Suite: Start Burp Suite and configure your browser to route
   traffic through it.
2. Browse Your Target: Navigate through your target site and its subdomains to
   capture traffic in Burp Suite.
3. Use the Regex in Search:
   - Go to the "Burp" > "Search" tab.
   - In the search type, choose "Regular expression".
   - Paste the following regex:

{{< details "Show the regex" >}}

```txt
(?ix)
\b
(
  (access(_key|_token)?|accessid|accessid_secret|account(_key|_sid)?|
  admin(_pass(word)?|_user)?|
  (algolia|aws|gcp|azure|heroku|firebase|github|gitlab|slack|datadog|stripe|twilio|vercel|supabase|sendgrid|cloudinary|cloudflare|bitbucket|npm|netlify|auth0|okta|sentry)_?(api|secret|access)?_?(key|token|id|sid|secret)?|
  ansible_vault_password|aos_key|
  api(_key|_secret|_token|Key|Secret|KeySid)?|
  app_(debug|id|key|secret|log_level)|application(_key|_id|_secret)?|
  auth(_token|_secret|orization)?|authkey|authsecret|bearer[_ ]?token|
  bucket(_password|_key)?|
  cert(_pass(word)?)?|certificate_password|
  client(_id|_secret)?|
  codecov_token|consumer_(key|secret)|
  conn(_string|\.login)?|connection(string)?|
  credentials?|crypt(_key|_secret)?|
  db(_password|_passwd|_user(name)?|server)?|
  deploy(_key|_password|_token)?|
  docker(_pass(word)?|_key)?|dockerhub(_password)?|
  encryption_(key|password)|
  env\.(heroku|sonatype)_(api_key|password)|
  firebase(_secret|_api_key)?|
  github(_token|_key|_client_secret)?|gitlab_token|
  jwt|jwt_secret|json_web_token|
  keycloak_secret|kubernetes_token|
  ldap_(password|bindpw)|login(_password|_token)?|
  mail(_password|_smtp_pass)?|
  mysql(_password|_user)?|mongo(_password|_user)?|
  netlify_token|npm(_token|_auth_token)?|
  oauth(_token|_secret)?|
  openai_(api_key|secret)?|
  pass(word)?|passwd|
  private(_key|_token)?|
  rds_password|
  s3(_key|_secret|_access_key_id)?|
  secret(_key|_token|_id)?|
  security_token|
  sendgrid_api_key|
  ses(_smtp|_access|_secret)?|
  service(_account|_key|_token)?|
  slack(_token|_secret|_hook)?|
  smtp_(pass(word)?|secret)?|
  sonar_token|
  ssh(_key|_private_key|_rsa)?|
  stripe_(secret|token|key)?|
  supabase(_anon|_service)?_key|
  symfony_secret|
  telegram_bot_token|
  token|
  travis_token|
  twilio(_account_sid|_auth_token)?|
  vault(_token|_secret)?|
  webhook(_secret|_token)?|
  zapier_webhook_token
  )
  [a-z0-9_\-\.]{0,25}
)
\s*
(?:=|:|=>)\s*
(?:['"`])
([a-zA-Z0-9_\-=\+/\.]{10,128})
(?:['"`])
```

{{< /details >}}

4. Inspect Results: Review the search results for potential leaks.
