---
title: Twitter Advanced Search Techniques
layout: page
parent: osint
---

# Twitter Advanced Search Techniques

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Banner last update time

The banner URL includes a Unix timestamp indicating when the banner was last
updated.

For example:
`https://pbs.twimg.com/profile_banners/1564326938851921921/1750897704/600x200`

In this case, `1750897704` is the timestamp. You can convert it using
[https://www.unixtimestamp.com/](https://www.unixtimestamp.com/) or any other
Unix time converter.

## Basic Search Operators

Twitter's advanced search functionality provides powerful filtering capabilities
for OSINT investigations:

- **Keywords**: `word1 word2` (tweets containing both words)
- **Exact phrases**: `"exact phrase"` (tweets with this exact sequence)
- **Exclusion**: `-word` (excludes tweets containing this word)
- **Either/or**: `word1 OR word2` (tweets containing either term)
- **Hashtags**: `#hashtag` (tweets with specific hashtag)
- **Accounts**: `from:username` (tweets sent by specific account)
- **Mentions**: `to:username` (tweets in reply to an account)
- **Mentions in any context**: `@username` (tweets mentioning an account)

## Advanced Filters

### Engagement Filters

- **Minimum retweets**: `min_retweets:number`
- **Minimum likes**: `min_faves:number`
- **Minimum replies**: `min_replies:number`
- **Filter for links**: `filter:links`
- **Filter for media**: `filter:media`
- **Filter for images**: `filter:images`
- **Filter for videos**: `filter:videos`

### Temporal and Geographic Filters

- **Date range**: `since:YYYY-MM-DD until:YYYY-MM-DD`
- **Geolocation**: `geocode:latitude,longitude,radius` (e.g.,
  `geocode:40.7128,-74.0060,5km`)
- **Near location**: `near:"Location Name"`
- **Within radius**: `near:"City" within:15km`
- **Language**: `lang:code` (e.g., `lang:en` for English)

### Tweet Characteristics

- **Positive attitude**: `🙂 OR :) OR filter:positive`
- **Negative attitude**: `🙁 OR :( OR filter:negative`
- **Questions**: `?` or `filter:questions`
- **Retweets only**: `filter:retweets`
- **Native retweets only**: `filter:nativeretweets`
- **Verified users**: `filter:verified`
- **Safe content**: `filter:safe`

## Practical Search Combinations

- **Content from a user within a date range**:
  `from:username since:2023-01-01 until:2023-12-31`

- **Geolocated tweets about a topic**:
  `near:"London, UK" within:25km "protest" since:2023-06-01`

- **High-engagement tweets about a topic**:
  `"artificial intelligence" min_retweets:100 lang:en -filter:retweets`

- **Media shared by a specific user**:
  `from:username filter:media -filter:retweets`

- **Conversations between specific users**:
  `from:username1 to:username2 OR from:username2 to:username1`

- **Link sharing on a topic by verified users**:
  `"climate change" filter:links filter:verified since:2023-01-01`

## Access Methods

- **Graphical interface**: Access via `https://twitter.com/search-advanced`

Remember that all Twitter searches should comply with Twitter's Terms of Service
and appropriate legal frameworks for your jurisdiction.
