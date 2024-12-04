-- Create Customers table
CREATE TABLE Customers IF NOT EXISTS (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Create Products table
CREATE TABLE Products IF NOT EXISTS (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Create Orders table
CREATE TABLE Orders IF NOT EXISTS (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES Customers(id),
    order_date DATE NOT NULL
);

-- Create OrderItems table
CREATE TABLE OrderItems IF NOT EXISTS (
    order_id INT NOT NULL REFERENCES Orders(id),
    product_id INT NOT NULL REFERENCES Products(id),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);