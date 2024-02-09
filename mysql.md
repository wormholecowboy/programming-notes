# TABLES
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    customer_id INT
);

## foreign keys
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

# ROWS

## insert a new row
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);

## update a value
UPDATE users
SET email = 'new_email@example.com'
WHERE user_id = 123;

## delete a row
delete from customers
WHERE customer_id = 123;


# COLUMNS

## rename a column
ALTER TABLE table_name
RENAME COLUMN old_column_name TO new_column_name;

## add a column
ALTER TABLE users
ADD COLUMN email VARCHAR(255) NOT NULL;





