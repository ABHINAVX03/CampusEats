# HTTP Request Log

**Course:** CS 543 – Web Services · Assignment 1
**Tool:** `curl -i`
**API tested:** GitHub REST API — `https://api.github.com` (public, read-only, no authentication required)
**Date:** August 12, 2026

`curl -i` prints the complete response: status line, headers, and body. Each command below is also an exact record of the request sent: `GET` is curl's default method, followed by the URL and any explicit `-H` request header. (Outgoing wire headers are not printed by `-i`; that would require `-v`.)

---

## Summary

| # | Request | Status | Content-Type |
|---|---------|--------|---------------|
| 1 | `GET /users/ABHINAVX03/this-page-does-not-exist` | 404 Not Found | `application/json` |
| 2 | `GET /users/ABHINAVX03` | 200 OK | `application/json` |
| 3 | `GET /zen` | 200 OK | `text/plain` |
| 4 | `GET /users/ABHINAVX03/repos?per_page=1` | 200 OK | `application/json` |
| 5 | `GET /users/ABHINAVX03` (+ `X-GitHub-Api-Version` header) | 200 OK | `application/json` |

---

## Request 1 — GET a resource that doesn't exist (deliberate failure)

**Request:**
```bash
curl -i https://api.github.com/users/ABHINAVX03/this-page-does-not-exist
```

**Response:**
```
HTTP/2 404
content-type: application/json; charset=utf-8
x-github-media-type: github.v3; format=json
access-control-expose-headers: ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, X-GitHub-Edge-Region, Deprecation, Sunset
access-control-allow-origin: *
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
x-xss-protection: 0
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
content-security-policy: default-src 'none'
vary: Accept-Encoding, Accept, X-Requested-With
server: github.com
date: Wed, 12 Aug 2026 09:26:29 GMT
x-ratelimit-limit: 60
x-ratelimit-remaining: 53
x-ratelimit-used: 7
x-ratelimit-resource: core
x-ratelimit-reset: 1786529715
content-length: 106
x-github-request-id: 2068:3A28AE:C8837C:D23F23:6A7C3C45
x-github-edge-region: centralindia

{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest",
  "status": "404"
}
```

**Note:** `404` means the server understood the request but found no resource at that path — the URL was made up on purpose to trigger this. `Content-Type: application/json` shows that even error responses are returned as structured JSON, not plain text, so client code can parse a failure the same way it parses a success.

---

## Request 2 — GET a single resource

**Request:**
```bash
curl -i https://api.github.com/users/ABHINAVX03
```

**Response:**
```
HTTP/2 200
date: Wed, 12 Aug 2026 09:27:29 GMT
content-type: application/json; charset=utf-8
cache-control: public, max-age=60, s-maxage=60
vary: Accept,Accept-Encoding, Accept, X-Requested-With
etag: W/"07ca4f06d72c0908db1b2c783701852fe98140837d2d64f09cff514d9ce09078"
last-modified: Tue, 11 Aug 2026 04:16:21 GMT
x-github-media-type: github.v3; format=json
x-github-api-version-selected: 2022-11-28
access-control-expose-headers: ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset, Warning
access-control-allow-origin: *
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
x-xss-protection: 0
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
content-security-policy: default-src 'none'
server: github.com
accept-ranges: bytes
x-ratelimit-limit: 60
x-ratelimit-remaining: 52
x-ratelimit-used: 8
x-ratelimit-resource: core
x-ratelimit-reset: 1786529715
content-length: 1555
x-github-request-id: 0995:15FCD:C8441B:D20442:6A7C3C81
x-github-edge-region: centralindia

{
  "login": "ABHINAVX03",
  "id": 98380157,
  "node_id": "U_kgDOBd0pfQ",
  "avatar_url": "https://avatars.githubusercontent.com/u/98380157?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/ABHINAVX03",
  "html_url": "https://github.com/ABHINAVX03",
  "followers_url": "https://api.github.com/users/ABHINAVX03/followers",
  "following_url": "https://api.github.com/users/ABHINAVX03/following{/other_user}",
  "gists_url": "https://api.github.com/users/ABHINAVX03/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/ABHINAVX03/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/ABHINAVX03/subscriptions",
  "organizations_url": "https://api.github.com/users/ABHINAVX03/orgs",
  "repos_url": "https://api.github.com/users/ABHINAVX03/repos",
  "events_url": "https://api.github.com/users/ABHINAVX03/events{/privacy}",
  "received_events_url": "https://api.github.com/users/ABHINAVX03/received_events",
  "type": "User",
  "user_view_type": "public",
  "site_admin": false,
  "name": "Abhinav Gupta",
  "company": null,
  "blog": "https://portfolio-beta-smoky-46.vercel.app/",
  "location": "delhi,india",
  "email": null,
  "hireable": true,
  "bio": "Software Development Engineer | Java · Spring Boot · React · Next.js | MCA @ IIIT Vadodara | Codeforces Pupil (1383) | Open to SDE-1 roles 🚀",
  "twitter_username": "abhinav64941356",
  "public_repos": 40,
  "public_gists": 0,
  "followers": 0,
  "following": 1,
  "created_at": "2022-01-25T06:50:03Z",
  "updated_at": "2026-08-11T04:16:21Z"
}
```

**Note:** `200 OK` means the request succeeded and the server returned the resource. `Content-Type: application/json` tells the client to parse the body as a single JSON object — here, the public user profile for `ABHINAVX03`.

---

## Request 3 — GET a non-JSON endpoint

**Request:**
```bash
curl -i https://api.github.com/zen
```

**Response:**
```
HTTP/2 200
date: Wed, 12 Aug 2026 09:29:57 GMT
content-type: text/plain;charset=utf-8
x-github-api-version-selected: 2022-11-28
access-control-expose-headers: ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset, Warning
access-control-allow-origin: *
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
x-xss-protection: 0
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
content-security-policy: default-src 'none'
vary: Accept-Encoding, Accept, X-Requested-With
server: github.com
accept-ranges: bytes
x-ratelimit-limit: 60
x-ratelimit-remaining: 51
x-ratelimit-used: 9
x-ratelimit-resource: core
x-ratelimit-reset: 1786529715
content-length: 26
x-github-request-id: 79A3:1F6622:C9F0B7:D3A708:6A7C3D15
x-github-edge-region: centralindia

Favor focus over features.
```

**Note:** `200 OK` again means success, but `Content-Type: text/plain` shows the body is plain text, not JSON — `/zen` is a small easter-egg endpoint on GitHub's API that returns a random design-philosophy line. A good reminder to check `Content-Type` per response rather than assuming every endpoint on a "JSON API" returns JSON.

---

## Request 4 — GET a collection, with a query parameter

**Request:**
```bash
curl -i "https://api.github.com/users/ABHINAVX03/repos?per_page=1"
```

**Response headers:**
```
HTTP/2 200
date: Wed, 12 Aug 2026 09:31:02 GMT
content-type: application/json; charset=utf-8
cache-control: public, max-age=60, s-maxage=60
vary: Accept,Accept-Encoding, Accept, X-Requested-With
etag: W/"f8d2ad4727bc73ed683307cc93892607e518f9367be0fed72c500671688ca9cb"
x-github-media-type: github.v3; format=json
link: <https://api.github.com/user/98380157/repos?per_page=1&page=2>; rel="next", <https://api.github.com/user/98380157/repos?per_page=1&page=40>; rel="last"
x-github-api-version-selected: 2022-11-28
access-control-expose-headers: ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset, Warning
access-control-allow-origin: *
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
x-xss-protection: 0
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
content-security-policy: default-src 'none'
server: github.com
accept-ranges: bytes
x-ratelimit-limit: 60
x-ratelimit-remaining: 50
x-ratelimit-used: 10
x-ratelimit-resource: core
x-ratelimit-reset: 1786529715
content-length: 5833
x-github-request-id: 46D5:3FC8A5:C96398:D32E4C:6A7C3D55
x-github-edge-region: centralindia
```

<details>
<summary>Full response body (JSON array, 1 repo — click to expand)</summary>

```json
[
  {
    "id": 1265022719,
    "node_id": "R_kgDOS2a2_w",
    "name": "Aapka-Couch",
    "full_name": "ABHINAVX03/Aapka-Couch",
    "private": false,
    "owner": {
      "login": "ABHINAVX03",
      "id": 98380157,
      "node_id": "U_kgDOBd0pfQ",
      "avatar_url": "https://avatars.githubusercontent.com/u/98380157?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/ABHINAVX03",
      "html_url": "https://github.com/ABHINAVX03",
      "followers_url": "https://api.github.com/users/ABHINAVX03/followers",
      "following_url": "https://api.github.com/users/ABHINAVX03/following{/other_user}",
      "gists_url": "https://api.github.com/users/ABHINAVX03/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/ABHINAVX03/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/ABHINAVX03/subscriptions",
      "organizations_url": "https://api.github.com/users/ABHINAVX03/orgs",
      "repos_url": "https://api.github.com/users/ABHINAVX03/repos",
      "events_url": "https://api.github.com/users/ABHINAVX03/events{/privacy}",
      "received_events_url": "https://api.github.com/users/ABHINAVX03/received_events",
      "type": "User",
      "user_view_type": "public",
      "site_admin": false
    },
    "html_url": "https://github.com/ABHINAVX03/Aapka-Couch",
    "description": null,
    "fork": false,
    "url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch",
    "forks_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/forks",
    "keys_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/teams",
    "hooks_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/hooks",
    "issue_events_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/issues/events{/number}",
    "events_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/events",
    "assignees_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/assignees{/user}",
    "branches_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/branches{/branch}",
    "tags_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/tags",
    "blobs_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/languages",
    "stargazers_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/stargazers",
    "contributors_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/contributors",
    "subscribers_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/subscribers",
    "subscription_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/subscription",
    "commits_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/contents/{+path}",
    "compare_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/merges",
    "archive_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/downloads",
    "issues_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/issues{/number}",
    "pulls_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/labels{/name}",
    "releases_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/releases{/id}",
    "deployments_url": "https://api.github.com/repos/ABHINAVX03/Aapka-Couch/deployments",
    "created_at": "2026-06-10T11:50:00Z",
    "updated_at": "2026-06-14T16:07:39Z",
    "pushed_at": "2026-06-14T16:07:35Z",
    "git_url": "git://github.com/ABHINAVX03/Aapka-Couch.git",
    "ssh_url": "git@github.com:ABHINAVX03/Aapka-Couch.git",
    "clone_url": "https://github.com/ABHINAVX03/Aapka-Couch.git",
    "svn_url": "https://github.com/ABHINAVX03/Aapka-Couch",
    "homepage": "https://aapka-couch.vercel.app",
    "size": 987,
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "TypeScript",
    "has_issues": true,
    "has_projects": true,
    "has_downloads": false,
    "has_wiki": true,
    "has_pages": false,
    "has_discussions": false,
    "forks_count": 0,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 0,
    "license": null,
    "allow_forking": true,
    "is_template": false,
    "web_commit_signoff_required": false,
    "has_pull_requests": true,
    "pull_request_creation_policy": "all",
    "topics": [],
    "visibility": "public",
    "forks": 0,
    "open_issues": 0,
    "watchers": 0,
    "default_branch": "main"
  }
]
```

</details>

**Note:** `200 OK` means success; `Content-Type: application/json` again, but this time the body is a JSON **array**, not a single object — `/repos` is a collection endpoint. `per_page=1` limited it to one item, and the `Link` header in the response shows how to page through the rest (`rel="next"`, `rel="last"`).

---

## Request 5 — GET the same resource, with a custom request header

**Request:**
```bash
curl -i -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/users/ABHINAVX03
```

**Response:**
```
HTTP/2 200
date: Wed, 12 Aug 2026 09:32:12 GMT
content-type: application/json; charset=utf-8
cache-control: public, max-age=60, s-maxage=60
vary: Accept,Accept-Encoding, Accept, X-Requested-With
etag: W/"07ca4f06d72c0908db1b2c783701852fe98140837d2d64f09cff514d9ce09078"
last-modified: Tue, 11 Aug 2026 04:16:21 GMT
x-github-media-type: github.v3; format=json
x-github-api-version-selected: 2022-11-28
access-control-expose-headers: ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset, Warning
access-control-allow-origin: *
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
x-xss-protection: 0
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
content-security-policy: default-src 'none'
server: github.com
accept-ranges: bytes
x-ratelimit-limit: 60
x-ratelimit-remaining: 49
x-ratelimit-used: 11
x-ratelimit-resource: core
x-ratelimit-reset: 1786529715
content-length: 1555
x-github-request-id: 454F:15915D:CD6A70:D7315F:6A7C3D9C
x-github-edge-region: centralindia
```

**Response body:**
```json
{
  "login": "ABHINAVX03",
  "id": 98380157,
  "node_id": "U_kgDOBd0pfQ",
  "avatar_url": "https://avatars.githubusercontent.com/u/98380157?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/ABHINAVX03",
  "html_url": "https://github.com/ABHINAVX03",
  "followers_url": "https://api.github.com/users/ABHINAVX03/followers",
  "following_url": "https://api.github.com/users/ABHINAVX03/following{/other_user}",
  "gists_url": "https://api.github.com/users/ABHINAVX03/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/ABHINAVX03/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/ABHINAVX03/subscriptions",
  "organizations_url": "https://api.github.com/users/ABHINAVX03/orgs",
  "repos_url": "https://api.github.com/users/ABHINAVX03/repos",
  "events_url": "https://api.github.com/users/ABHINAVX03/events{/privacy}",
  "received_events_url": "https://api.github.com/users/ABHINAVX03/received_events",
  "type": "User",
  "user_view_type": "public",
  "site_admin": false,
  "name": "Abhinav Gupta",
  "company": null,
  "blog": "https://portfolio-beta-smoky-46.vercel.app/",
  "location": "delhi,india",
  "email": null,
  "hireable": true,
  "bio": "Software Development Engineer | Java · Spring Boot · React · Next.js | MCA @ IIIT Vadodara | Codeforces Pupil (1383) | Open to SDE-1 roles 🚀",
  "twitter_username": "abhinav64941356",
  "public_repos": 40,
  "public_gists": 0,
  "followers": 0,
  "following": 1,
  "created_at": "2022-01-25T06:50:03Z",
  "updated_at": "2026-08-11T04:16:21Z"
}
```

**Note:** `200 OK`, `Content-Type: application/json` — same as Request 2. Sending an explicit `X-GitHub-Api-Version` header doesn't change the resource returned, it just pins the request to a specific version of GitHub's API contract, which is good practice for stability once an app depends on a specific response shape.

---
