-- ==================== ACCOUNTS SERVICE ====================
CREATE TABLE users (
    user_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    address_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       UUID NOT NULL,
    street        VARCHAR(255) NOT NULL,
    city          VARCHAR(100) NOT NULL,
    zip           VARCHAR(20) NOT NULL,
    label         VARCHAR(50),
    is_default    BOOLEAN DEFAULT FALSE,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    -- user_id is intra-service (Accounts owns both tables) — safe to enforce
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==================== CATALOGUE SERVICE ====================
CREATE TABLE restaurants (
    restaurant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(100) NOT NULL,
    location      VARCHAR(255),
    phone         VARCHAR(20),
    opening_hours TEXT
);

CREATE TABLE menu_items (
    item_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    restaurant_id UUID NOT NULL,
    name          VARCHAR(100) NOT NULL,
    description   TEXT,
    price         DECIMAL(10,2) NOT NULL,
    available     BOOLEAN DEFAULT TRUE,
    category      VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- ==================== ORDERS SERVICE ====================
CREATE TABLE carts (
    cart_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       UUID NOT NULL,  -- logical reference to Accounts.users
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_updated  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart_items (
    cart_item_id  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cart_id       UUID NOT NULL,
    item_id       UUID NOT NULL,  -- logical reference to Catalogue.menu_items
    quantity      INT NOT NULL CHECK (quantity > 0),
    added_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(cart_id)
);

CREATE TABLE orders (
    order_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       UUID NOT NULL,  -- logical reference to Accounts.users
    address_id    UUID NOT NULL,  -- logical reference to Accounts.addresses
    status        VARCHAR(50) NOT NULL DEFAULT 'PLACED',
    total         DECIMAL(10,2) NOT NULL,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id      UUID NOT NULL,
    item_id       UUID NOT NULL,  
    quantity      INT NOT NULL CHECK (quantity > 0),
    price_at_time DECIMAL(10,2) NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ==================== PAYMENTS SERVICE ====================
CREATE TABLE transactions (
    transaction_id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id                  UUID NOT NULL,  -- logical reference to Orders.orders
    student_id                UUID NOT NULL,  -- logical reference to Accounts.users
    amount                    DECIMAL(10,2) NOT NULL,
    method                    VARCHAR(50) NOT NULL,
    status                    VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    timestamp                 TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    gateway_reference         VARCHAR(255),
    -- self-reference: a refund row points back at the original charge.
    -- Keeps "Refunds" inside the Transactions table instead of a second
    -- table, while still making the link explicit and queryable.
    refund_of_transaction_id  UUID REFERENCES transactions(transaction_id)
);

-- ==================== DELIVERY SERVICE ====================
CREATE TABLE riders (
    rider_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(20),
    vehicle     VARCHAR(50),
    available   BOOLEAN DEFAULT TRUE
);

CREATE TABLE assignments (
    assignment_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id          UUID NOT NULL, 
    rider_id          UUID NOT NULL,
    status            VARCHAR(50) NOT NULL DEFAULT 'ASSIGNED',
    assigned_at       TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    delivered_at      TIMESTAMP WITH TIME ZONE,
    estimated_arrival TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id)
);

-- ==================== NOTIFICATIONS SERVICE ====================
CREATE TABLE notifications (
    notification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL, 
    order_id        UUID NOT NULL,  
    message         TEXT NOT NULL,
    type            VARCHAR(50) NOT NULL,
    sent_at         TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(50) DEFAULT 'SENT'
);
