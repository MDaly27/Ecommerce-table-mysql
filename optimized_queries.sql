-- Find All Orders Placed by a User
-- This query uses idx_users_email to quickly find a user by email
SELECT o.order_id, o.order_date, o.total_price
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE u.email = 'alice@example.com';

-- Get All Orders Sorted by User and Date
-- This query uses idx_orders_user_date to efficiently sort orders by user_id and order_date
SELECT u.username, o.order_id, o.order_date, o.total_price
FROM orders o
JOIN users u ON o.user_id = u.user_id
ORDER BY u.username, o.order_date;

-- Top Selling Products by Quantity
-- This query uses the primary key index on products.product_id for efficient joins
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

-- Most Recent Order for Each User
-- This query uses idx_orders_user_date to find the latest order for each user
SELECT u.username, MAX(o.order_date) AS last_order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username
ORDER BY last_order_date DESC;

