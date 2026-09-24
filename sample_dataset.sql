-- Sample SQL Dataset
-- Database: SampleDB
-- Contains: Users, Products, Orders, Payments tables with sample data

-- Create Database
CREATE DATABASE IF NOT EXISTS SampleDB;
USE SampleDB;

-- =====================================================
-- TABLE 1: Users/Customers
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active'
);

-- Insert sample user data
INSERT INTO users (name, email, phone, city, state, country) VALUES
('Aman Sharma', 'aman.sharma@email.com', '9876543210', 'Greater Noida', 'Uttar Pradesh', 'India'),
('Priya Patel', 'priya.patel@email.com', '9123456789', 'Mumbai', 'Maharashtra', 'India'),
('Rajesh Kumar', 'rajesh.kumar@email.com', '9654321098', 'Delhi', 'Delhi', 'India'),
('Sneha Verma', 'sneha.verma@email.com', '9234567890', 'Bangalore', 'Karnataka', 'India'),
('Vikram Singh', 'vikram.singh@email.com', '9345678901', 'Pune', 'Maharashtra', 'India'),
('Anjali Gupta', 'anjali.gupta@email.com', '9456789012', 'Hyderabad', 'Telangana', 'India'),
('Kunal Desai', 'kunal.desai@email.com', '9567890123', 'Ahmedabad', 'Gujarat', 'India'),
('Divya Nair', 'divya.nair@email.com', '9678901234', 'Kochi', 'Kerala', 'India');

-- =====================================================
-- TABLE 2: Products
-- =====================================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    supplier_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);

-- Insert sample product data
INSERT INTO products (product_name, category, price, stock_quantity, supplier_id, description) VALUES
('Tomato - Fresh', 'Vegetables', 40.00, 500, 1, 'Fresh red tomatoes from local farms'),
('Onion - Bulk', 'Vegetables', 35.00, 800, 1, 'White onions - wholesale pricing'),
('Potato - Premium', 'Vegetables', 30.00, 1200, 2, 'High quality potatoes'),
('Spinach - Organic', 'Vegetables', 60.00, 300, 3, 'Organic fresh spinach'),
('Carrot - Orange', 'Vegetables', 45.00, 600, 2, 'Sweet orange carrots'),
('Capsicum - Green', 'Vegetables', 70.00, 250, 1, 'Fresh green capsicum'),
('Cucumber - Fresh', 'Vegetables', 50.00, 400, 3, 'Crisp fresh cucumbers'),
('Broccoli - Green', 'Vegetables', 85.00, 150, 2, 'Fresh green broccoli'),
('Apple - Red', 'Fruits', 120.00, 350, 4, 'Red apples - premium quality'),
('Banana - Bunch', 'Fruits', 45.00, 600, 4, 'Fresh banana bunches'),
('Orange - Citrus', 'Fruits', 80.00, 450, 5, 'Fresh oranges - sweet'),
('Mango - Alphonso', 'Fruits', 150.00, 200, 5, 'Premium Alphonso mangoes'),
('Milk - 1L', 'Dairy', 55.00, 1000, 6, 'Fresh pasteurized milk'),
('Yogurt - 500ml', 'Dairy', 65.00, 800, 6, 'Fresh yogurt');

-- =====================================================
-- TABLE 3: Orders
-- =====================================================
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    delivery_date DATE,
    delivery_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert sample order data
INSERT INTO orders (user_id, total_amount, status, delivery_date, delivery_address) VALUES
(1, 450.00, 'delivered', '2026-09-20', '123 Main Street, Greater Noida'),
(2, 890.50, 'shipped', '2026-09-25', '456 Park Avenue, Mumbai'),
(3, 320.00, 'confirmed', '2026-09-26', '789 Ring Road, Delhi'),
(4, 1200.00, 'pending', '2026-09-27', '321 Tech Park, Bangalore'),
(5, 650.75, 'delivered', '2026-09-18', '654 Business Hub, Pune'),
(1, 525.00, 'delivered', '2026-09-21', '123 Main Street, Greater Noida'),
(6, 380.00, 'confirmed', '2026-09-26', '987 Corporate Square, Hyderabad'),
(7, 720.50, 'pending', '2026-09-28', '159 Market Street, Ahmedabad'),
(8, 445.00, 'shipped', '2026-09-24', '357 Beach Road, Kochi'),
(2, 1050.00, 'delivered', '2026-09-19', '456 Park Avenue, Mumbai');

-- =====================================================
-- TABLE 4: Order Items (Line Items)
-- =====================================================
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    item_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample order items data
INSERT INTO order_items (order_id, product_id, quantity, unit_price, item_total) VALUES
(1, 1, 5, 40.00, 200.00),
(1, 2, 3, 35.00, 105.00),
(1, 5, 2, 45.00, 90.00),
(1, 9, 1, 120.00, 120.00),
(2, 4, 2, 60.00, 120.00),
(2, 7, 3, 50.00, 150.00),
(2, 10, 5, 45.00, 225.00),
(2, 11, 2, 80.00, 160.00),
(2, 13, 1, 55.00, 55.00),
(3, 1, 4, 40.00, 160.00),
(3, 3, 2, 30.00, 60.00),
(3, 6, 1, 70.00, 70.00),
(4, 8, 2, 85.00, 170.00),
(4, 12, 1, 150.00, 150.00),
(4, 14, 4, 65.00, 260.00),
(4, 4, 3, 60.00, 180.00),
(4, 9, 2, 120.00, 240.00),
(5, 2, 5, 35.00, 175.00),
(5, 7, 2, 50.00, 100.00),
(5, 11, 1, 80.00, 80.00),
(5, 13, 2, 55.00, 110.00),
(6, 1, 3, 40.00, 120.00),
(6, 5, 4, 45.00, 180.00),
(6, 10, 2, 45.00, 90.00),
(6, 9, 1, 120.00, 120.00),
(7, 3, 6, 30.00, 180.00),
(7, 6, 1, 70.00, 70.00),
(7, 12, 1, 150.00, 150.00),
(8, 4, 4, 60.00, 240.00),
(8, 8, 1, 85.00, 85.00),
(8, 11, 2, 80.00, 160.00),
(8, 14, 1, 65.00, 65.00),
(9, 1, 6, 40.00, 240.00),
(9, 7, 3, 50.00, 150.00),
(9, 10, 1, 45.00, 45.00),
(9, 14, 1, 65.00, 65.00),
(10, 2, 8, 35.00, 280.00),
(10, 5, 3, 45.00, 135.00),
(10, 11, 2, 80.00, 160.00),
(10, 9, 2, 120.00, 240.00),
(10, 4, 3, 60.00, 180.00),
(10, 13, 1, 55.00, 55.00);

-- =====================================================
-- TABLE 5: Payments
-- =====================================================
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('credit_card', 'debit_card', 'upi', 'net_banking', 'cash') DEFAULT 'upi',
    transaction_id VARCHAR(100) UNIQUE,
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert sample payment data
INSERT INTO payments (order_id, amount, payment_method, transaction_id, status) VALUES
(1, 450.00, 'upi', 'TXN20260920001', 'completed'),
(2, 890.50, 'credit_card', 'TXN20260921001', 'completed'),
(3, 320.00, 'upi', 'TXN20260921002', 'completed'),
(4, 1200.00, 'net_banking', 'TXN20260922001', 'pending'),
(5, 650.75, 'debit_card', 'TXN20260920002', 'completed'),
(6, 525.00, 'upi', 'TXN20260921003', 'completed'),
(7, 380.00, 'credit_card', 'TXN20260922002', 'completed'),
(8, 720.50, 'net_banking', 'TXN20260923001', 'pending'),
(9, 445.00, 'upi', 'TXN20260924001', 'completed'),
(10, 1050.00, 'credit_card', 'TXN20260920003', 'completed');

-- =====================================================
-- USEFUL QUERIES (Examples)
-- =====================================================

-- Query 1: Get total sales per user
-- SELECT 
--     u.user_id,
--     u.name,
--     COUNT(o.order_id) as total_orders,
--     SUM(o.total_amount) as total_spent
-- FROM users u
-- LEFT JOIN orders o ON u.user_id = o.user_id
-- GROUP BY u.user_id, u.name
-- ORDER BY total_spent DESC;

-- Query 2: Get top selling products
-- SELECT 
--     p.product_id,
--     p.product_name,
--     p.category,
--     SUM(oi.quantity) as total_quantity_sold,
--     SUM(oi.item_total) as total_revenue
-- FROM products p
-- JOIN order_items oi ON p.product_id = oi.product_id
-- GROUP BY p.product_id, p.product_name, p.category
-- ORDER BY total_revenue DESC;

-- Query 3: Get pending orders
-- SELECT 
--     o.order_id,
--     u.name,
--     o.order_date,
--     o.total_amount,
--     o.status
-- FROM orders o
-- JOIN users u ON o.user_id = u.user_id
-- WHERE o.status = 'pending'
-- ORDER BY o.order_date DESC;

-- Query 4: Get payment summary
-- SELECT 
--     status,
--     COUNT(*) as count,
--     SUM(amount) as total_amount
-- FROM payments
-- GROUP BY status;
