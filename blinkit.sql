
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);
INSERT INTO authors (author_name) VALUES
('J.K. Rowling'),
('Stephen King'),
('Harper Lee'),
('J.R.R. Tolkien');


CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO books (title, author_id, price, quantity) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 10.99, 100),
('The Shining', 2, 9.99, 50),
('To Kill a Mockingbird', 3, 8.50, 75),
('The Lord of the Rings', 4, 12.99, 120);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL
);
INSERT INTO customers (customer_name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('David Johnson', 'david@example.com');

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (customer_id, total_amount) VALUES
(1, 50.97),
(2, 29.97),
(3, 65.48);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO order_details (order_id, book_id, quantity, price) VALUES
(1, 1, 3, 32.97),
(1, 2, 2, 19.98),
(2, 3, 1, 8.50),
(3, 4, 5, 64.95);
-- Retrieve the top 10 best-selling books and their authors
SELECT 
    b.title, 
    a.author_name, 
    SUM(od.quantity) AS total_quantity_sold
FROM 
    books b
INNER JOIN 
    order_details od ON b.book_id = od.book_id
INNER JOIN 
    orders o ON od.order_id = o.order_id
INNER JOIN 
    authors a ON b.author_id = a.author_id
GROUP BY 
    b.title, a.author_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 
    10; 
SELECT 
    SUM(od.quantity * od.price) AS total_revenue
FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.order_id

