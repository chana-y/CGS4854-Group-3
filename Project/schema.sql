CREATE DATABASE IF NOT EXISTS minimalist_cart;
USE minimalist_cart;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    user_id INT,
    tracking_number VARCHAR(100),
    encrypted_cc_data VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Processing',
    total_amount DECIMAL(10, 2),
    -- This enforces the relational link to the users table
    FOREIGN KEY (user_id) REFERENCES users(id) 
);

-- NEW: This table stores the actual items inside the shopping cart for each order
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

ALTER TABLE products ADD COLUMN description VARCHAR(255);

-- Update your existing data
UPDATE products SET description = 'A timeless minimalist watch for daily wear.' WHERE name = 'Minimalist Watch';
UPDATE products SET description = 'Durable canvas backpack with modern aesthetics.' WHERE name = 'Canvas Backpack';
UPDATE products SET description = 'Hand-crafted ceramic mug for your morning coffee.' WHERE name = 'Ceramic Mug';


INSERT INTO products (name, price, image_url) VALUES 
('Minimalist Watch', 120.00, 'https://m.media-amazon.com/images/I/61GfkokcyPL._AC_UY1000_.jpg'),
('Canvas Backpack', 85.50, 'https://m.media-amazon.com/images/I/71o9llAj8WL._AC_UY1000_.jpg'),
('Ceramic Mug', 24.00, 'https://m.media-amazon.com/images/I/61vzWcqLM+S._AC_UF894,1000_QL80_.jpg');