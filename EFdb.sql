Create a Database
Connect to the newly created database
Create Tables
Table for users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,       -- Auto-incrementing primary key
    name VARCHAR(100) NOT NULL,       -- User's full name
    email VARCHAR(100) UNIQUE NOT NULL, -- User's email, must be unique
    password VARCHAR(255) NOT NULL,   -- User's hashed password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the user was created
);

-- Table for products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,     -- Auto-incrementing primary key
    name VARCHAR(100) NOT NULL,        -- Product name
    description TEXT,                  -- Product description
    price DECIMAL(10, 2) NOT NULL,     -- Price of the product
    stock_quantity INT NOT NULL,       -- Number of items in stock
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the product was created
);

-- Table for orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,       -- Auto-incrementing primary key
    user_id INT NOT NULL,              -- Foreign key referencing the users table
    total_price DECIMAL(10, 2) NOT NULL, -- Total price of the order
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for the order
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table for order items (to handle many-to-many relationship between orders and products)
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    order_id INT NOT NULL,             -- Foreign key referencing the orders table
    product_id INT NOT NULL,           -- Foreign key referencing the products table
    quantity INT NOT NULL,             -- Quantity of the product in the order
    price DECIMAL(10, 2) NOT NULL,     -- Price of the product at the time of order
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Tests

-- Insert sample users
INSERT INTO users (name, email, password) VALUES 
('John Doe', 'john.doe@example.com', 'hashed_password_123'),
('Jane Smith', 'jane.smith@example.com', 'hashed_password_456');

-- Insert sample products
INSERT INTO products (name, description, price, stock_quantity) VALUES
('Starter Kit', 'A bundle with basic supplies.', 49.99, 100),
('Cleaning Kit', 'Cleaning essentials for dorms.', 29.99, 50);

-- Insert a sample order
INSERT INTO orders (user_id, total_price) VALUES
(1, 79.98);

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 49.99),
(1, 2, 1, 29.99);
