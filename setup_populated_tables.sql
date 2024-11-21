-- Create the Database
CREATE DATABASE adt_ecommerce_db;
USE adt_ecommerce_db;

-- Create the Users Table

-- this table will hold username and email, with primary key user_id
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Sample Users
INSERT INTO users (username, email) VALUES
('alice', 'alice@example.com'),
('bob', 'bob@example.com'),
('charlie', 'charlie@example.com');

-- Create the Products Table

-- product name, price, stock and creation time. product_id is primary key
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Sample Products
INSERT INTO products (product_name, price, stock) VALUES
('Security Camera', 19.99, 100),
('Smart Home System', 49.99, 50),
('Window Break Sensor', 79.99, 30),
('Motion Detector', 15.99, 200);

-- Create the Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert Sample Orders
INSERT INTO orders (user_id, total_price) VALUES
(1, 89.97), -- Alice
(2, 49.99), -- Bob
(3, 79.99); -- Charlie

-- Create the Order Items Table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Sample Order Items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 3, 19.99), -- 3 Cameras in Alice's order
(1, 2, 1, 49.99), -- 1 Smart Home in Alice's order
(2, 2, 1, 49.99), -- 1 Smart Home in Bob's order
(3, 3, 1, 79.99); -- 1 Window break sensor in Charlie's order

-- Add Indexes
CREATE INDEX idx_users_email ON users (email); -- Quick lookup by email
CREATE INDEX idx_products_price ON products (price); -- Optimize price-related queries
CREATE INDEX idx_orders_user_date ON orders (user_id, order_date); -- Optimize user order history queries

