# 🍔 CampusEats

A campus food-ordering platform built as a set of independent microservices, developed incrementally across the **CS 543 – Web Services** course at IIIT Vadodara.

**Team:** Abhinav Gupta (Lead), Nandan Kabra, Neeraj Sharma, Priya
**Instructor:** Dr. Pramit Mazumdar
**Repository:** [github.com/ABHINAVX03/CampusEats](https://github.com/ABHINAVX03/CampusEats)

---

## 📌 Project Overview

CampusEats lets students:
- Browse local campus restaurants and their menus
- Place and pay for orders
- Track an order in real-time from "placed" to "delivered"
- Receive automatic notifications at each step

Behind the scenes, riders are assigned automatically and every action is recorded – but no two services share a database. The system is designed from the ground up as a **microservices architecture**.

---

## 🧱 Planned Architecture

| Service | Owns |
| :--- | :--- |
| **Accounts** | Users, addresses, authentication |
| **Catalogue** | Restaurants, menus, prices |
| **Orders** | Carts, orders, order status |
| **Payments** | Transactions, refunds |
| **Delivery** | Riders, assignments |
| **Notifications** | Message log (email/push/SMS) |

Services communicate only through well-defined APIs. For example, the `Orders` service never reads `Catalogue`'s database directly – it calls `Catalogue.checkItem()` instead.

---

## 📁 Repository Structure

```text
campuseats/
├── README.md                 ← you are here
└── docs/
    ├── http-log.md           ← Assignment 1: 5 curl request/response pairs (includes a 404)
    ├── network-analysis.md   ← Assignment 1: DevTools waterfall analysis
    ├── brief.md              ← Assignment 1: System brief (what, who, nouns, verbs)
    └── assignment-1/         ← Supporting curl and DevTools screenshots
```

All future assignments will add their own subdirectories or files under `docs/` (e.g., `docs/assignment2/`, `docs/assignment3/` …).

---

## 🔖 Assignment 1 – HTTP & Project Setup

This repository was created as part of **Assignment 1**. The deliverables are in the `docs/` folder:

- [`http-log.md`](docs/http-log.md) – Five annotated `curl` requests/responses (including a deliberate 404).
- [`network-analysis.md`](docs/network-analysis.md) – Analysis of a real website's network waterfall.
- [`brief.md`](docs/brief.md) – One-page brief: what CampusEats does, who uses it, and its core nouns & verbs.

---

## 🚀 Getting Started (later)

Once implementation begins, this section will include:
- How to clone the repo
- Prerequisites (Node.js, Python, etc.)
- How to run each service locally
- How to run the whole system with Docker Compose

For now, this repo contains only design documents and the HTTP fundamentals from Assignment 1.

---

## 🧪 Status

- [x] Repository created, structure in place
- [x] Assignment 1 completed (HTTP basics, system brief)
- [ ] Assignment 2 – API design & first service (coming soon)
- [ ] Full implementation – planned across 14 assignments

---

## 👥 Team

| Name | Role / Focus | GitHub |
| :--- | :--- | :--- |
| Abhinav Gupta | Lead, architecture | [@ABHINAVX03](https://github.com/ABHINAVX03) |
| Nandan Kabra | Backend services | @... |
| Neeraj Sharma | Frontend / testing | @... |
| Priya | Documentation, APIs | @... |

---

*Built with ☕ and curiosity — IIIT Vadodara, 2026*
