# CampusEats — Project Brief

**Course:** CS 543 – Web Services · Assignment 1
**Date:** August 12, 2026

---

## What

CampusEats is a food-ordering platform for a campus community. A student logs in, browses restaurants and menus, builds a cart, places an order, and pays online. Once placed, a rider is assigned to deliver it, and the student can track the order in real time. At every stage — placed, paid, on the way, delivered — the student gets a notification.

The system isn't one monolithic app. It's split into six independent services, each responsible for one job and owning its own data exclusively — no two services ever share a database table.

## Who

- **Students** — the primary users. They register, manage delivery addresses, browse menus, order, pay, and track delivery.
- **Restaurants** — the campus food vendors whose menus and prices are listed on the platform.
- **Riders** — assigned to pick up and deliver an order once it's placed.

## Nouns — the services, and what each owns

The domain nouns are **student, restaurant, menu, menu item, price, cart, order, delivery address, payment transaction, refund, rider, delivery assignment, status, notification**, and the six services below. They are explicit because each service is the single source of truth for the nouns it owns.

| Service | Owns |
|---|---|
| Accounts | users, addresses, login |
| Catalogue | restaurants, menus, prices |
| Orders | carts, orders, status |
| Payments | transactions, refunds |
| Delivery | riders, assignments |
| Notifications | message log |

## Verbs — the operations each service exposes

**Accounts**
- `register` / `login` — create or authenticate a student
- `addAddress(studentId, address)` — save a delivery address

**Catalogue**
- `listRestaurants(area)` → restaurants[]
- `getMenu(restaurantId)` → menu items + prices
- `checkItem(itemId)` → available?, price

**Orders**
- `addToCart(studentId, itemId, qty)` → cart
- `placeOrder(studentId, cart, addressId)` → orderId, status, total
- `getOrder(orderId)` → order + status
- `cancelOrder(orderId)` → status: cancelled

**Payments**
- `charge(amount, method)` → receipt
- `refund(txnId)`

**Delivery**
- `assignRider(orderId)` → rider, eta
- `trackDelivery(orderId)` → current status/location

**Notifications**
- `send(studentId, event)` — e.g. "order placed", "on the way", "delivered"

## How it fits together — placing an order

1. Student → **Orders**.placeOrder
2. Orders → **Catalogue**.checkItem — still available? what's the price?
3. Orders → **Payments**.charge — take the money
4. Orders → **Delivery**.assignRider — schedule the drop
5. Orders → **Notifications**.send('order placed') → confirmation goes back to the student

Orders orchestrates the whole flow but owns nothing beyond the order itself. Every other fact it needs — price, payment status, rider — comes from calling another service's published contract, never by reading that service's data directly.
