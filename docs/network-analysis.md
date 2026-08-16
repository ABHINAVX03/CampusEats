# Network Analysis

**Course:** CS 543 – Web Services · Assignment 1
**Tool:** Chrome DevTools → Network panel (`Disable cache` checked, hard reload)
**Page tested:** `portfolio-beta-smoky-46.vercel.app` — a Next.js site deployed on Vercel
**Date:** August 12, 2026

## Method

I opened the page in Chrome, opened **DevTools → Network**, checked **Disable cache**, then performed a hard reload while DevTools remained open. The figures below are the totals displayed by that reload's Network panel. Supporting DevTools screenshots are retained in `docs/http-analysis-evidence/`.

---

## Summary

| Metric | Value |
|---|---|
| Requests | 42 |
| Transferred | 561 kB (compressed, over the wire) |
| Resources | 1.2 MB (uncompressed size) |
| Finish | 15.98 s |
| DOMContentLoaded | 391 ms |
| Load | 572 ms |

---

## Request breakdown

| Type | Count | What's in it |
|---|---|---|
| Document | 1 | The HTML page |
| Script | 11 | Webpack runtime + page/chunk bundles |
| Stylesheet | 2 | App CSS (loaded successfully) |
| Fetch | 3 | 1 React Server Component prefetch, 2 `profile` calls |
| Image | 23 | 13 tech-stack logos, 8 project screenshots, 1 profile photo, 1 site logo — served through `/_next/image`, mostly as AVIF |
| Blocked (CSP) | 2 | 1 Google Fonts stylesheet, 1 custom font file |
| **Total** | **42** | |

---

## The waterfall

The 42 requests arrive in four broad phases:

1. **Document** — the HTML page loads first (18.5 kB, 138 ms).
2. **Scripts** — the webpack runtime and page bundles load next; nothing else can run until these arrive.
3. **Data calls** — once the JS is executing, the page fires a Server Component prefetch (`uber-ride-platform`) and two `profile` fetches.
4. **Images** — all 23 image requests fire last, once React has hydrated and knows what to render.

Two requests never make it past the browser at all — see below.

---

## Slowest resource

The single slowest resource is a **`profile` fetch — 592 ms**, initiated from `page-281fb1bc1bfe41c7.js`. A second, near-identical `profile` call finishes right behind it at 585 ms. Both responses are tiny (0.4–0.7 kB), so the delay isn't a transfer-size problem — it's latency on whatever backend this hits. Every other request on the page finishes in under 400 ms, and most in under 100 ms, so these two stand out clearly.

---

## 3xx / 4xx

None. All 40 non-blocked requests returned **200 OK** — no redirects, no client or server errors.

The closest thing to an error status is two **(blocked:csp)** entries: a Google Fonts stylesheet (`css2?family=Inter...`) and a custom font file (`Prototype.7188a326.ttf`). That isn't an HTTP status at all — the browser refuses to even send these requests because the page's Content-Security-Policy doesn't allow that origin for fonts/styles. Net effect: the `Inter` font and a custom display font silently fail to load, and the page falls back to a default font.

---

## Other observations

- **Finish (15.98 s) vs. Load (572 ms):** the page is fully rendered in well under a second, but the network tab stays active for roughly sixteen more seconds afterward. No single logged request takes anywhere near that long, so this is most likely a lingering background connection rather than a slow page resource.
- **A rougher, earlier reload of the same page** showed a cascade of `(canceled)` image requests for the same project screenshots at three different widths (1920px, 1200px, 1080px) — consistent with the browser viewport being resized mid-load, which makes Next.js's responsive `<Image>` component request a new width and cancel whichever one was still in flight.
