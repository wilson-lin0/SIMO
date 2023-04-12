CREATE DATABASE online_marketplace;

USE online_marketplace;

CREATE TABLE User (
    nuid INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number INT,
    password VARCHAR(15),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT
);

CREATE TABLE Buyer_Info (
    buyer_id INT PRIMARY KEY,
    phone_number INT,
    email VARCHAR(100),
    total_buyer_rating INT,
    FOREIGN KEY (buyer_id) REFERENCES User(nuid)
);

CREATE TABLE Seller_Info (
    seller_id INT PRIMARY KEY,
    phone_number INT,
    email_address VARCHAR(100),
    total_seller_rating INT,
    FOREIGN KEY (seller_id) REFERENCES User(nuid)
);

CREATE TABLE Order (
    order_id INTEGER PRIMARY KEY,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    buyer_id INT,
    seller_id INT,
    total_price DOUBLE,
    seller_rating INT,
    FOREIGN KEY (buyer_id) REFERENCES Buyer_Info(buyer_id),
    FOREIGN KEY (seller_id) REFERENCES Seller_Info(seller_id)
);

CREATE TABLE Meeting_Location (
    name VARCHAR(100) PRIMARY KEY,
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    description TEXT,
    name VARCHAR(100)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DOUBLE,
    category_id INT,
    condition VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    product_price DOUBLE,
    meeting_location_name VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES Order(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (meeting_location_name) REFERENCES Meeting_Location(name)
);

CREATE TABLE Requests (
    request_id INT PRIMARY KEY,
    nuid INT,
    name VARCHAR(100),
    category_id INT,
    condition VARCHAR(50),
    description TEXT,
    upper_price_range DOUBLE,
    lower_price_range DOUBLE,
    FOREIGN KEY (nuid) REFERENCES User(nuid),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Moderator (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number INT,
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT
);

CREATE TABLE Moderator_Email (
    email_address VARCHAR(100),
    nuid INT,
    FOREIGN KEY (nuid) REFERENCES Moderator(employee_id)
);

CREATE TABLE User_Email (
    email_address VARCHAR(100),
    nuid INT,
    FOREIGN KEY (nuid) REFERENCES User(nuid)
);

CREATE TABLE Blacklisted_Users (
    employee_id INT PRIMARY KEY,
    student_id INT,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES Moderator(employee_id)
);


INSERT INTO Meeting_Location VALUES
('Starbucks', '11 Speare Pl', 'Boston', 'MA', 02115);

-- Insert sample data into User table
INSERT INTO User (first_name, last_name, phone_number, password, street_address, city, state, zip_code, nuid)
VALUES
('John', 'Doe', 1234567890, 'password123', '123 Main St', 'Anytown', 'CA', 12345, 1),
('Jane', 'Doe', 0987654321, 'password456', '456 Elm St', 'Anytown', 'CA', 12345, 2),
('Bob', 'Smith', 1112223333, 'password789', '789 Oak St', 'Anytown', 'CA', 12345, 3);

-- Insert sample data into Buyer Info table
INSERT INTO Buyer_Info (buyer_id, phone_number, email, total_buyer_rating)
VALUES
(1, 1234567890, 'johndoe@example.com', 4),
(2, 0987654321, 'janedoe@example.com', 3),
(3, 1112223333, 'bobsmith@example.com', 5);

-- Insert sample data into Seller Info table
INSERT INTO Seller_Info (seller_id, phone_number, email_address, total_seller_rating)
VALUES
(1, 1234567890, 'johndoe@example.com', 3),
(2, 0987654321, 'janedoe@example.com', 4),
(3, 1112223333, 'bobsmith@example.com', 2);

-- Insert sample data into Meeting Location table
INSERT INTO Meeting_Location (name, street_address, city, state, zip_code)
VALUES
('Starbucks', '123 Main St', 'Anytown', 'CA', 12345),
('Library', '456 Elm St', 'Anytown', 'CA', 12345),
('Park', '789 Oak St', 'Anytown', 'CA', 12345);

-- Insert sample data into Category table
INSERT INTO Category (category_id, description, name)
VALUES
(1, 'Electronics', 'Electronics'),
(2, 'Clothing', 'Clothing'),
(3, 'Books', 'Books');

-- Insert sample data into Product table
INSERT INTO Product (name, description, price, category_id, product_id, condition)
VALUES
('iPhone', 'Apple iPhone 12 Pro Max 512GB', 1299.99, 1, 1, 'New'),
('Shirt', 'Men\'s casual shirt, size L', 19.99, 2, 2, 'Used'),
('Book', 'The Catcher in the Rye by J.D. Salinger', 9.99, 3, 3, 'New');

INSERT INTO Order (order_id, buyer_id, seller_id, total_price, seller_rating)
VALUES
(001, 246810121416, 13579111315, 20.00, 5),
(002, 346810121416, 43579111315, 40.00, 3),
(003, 446810121416, 53579111315, 50.50, 1);

INSERT INTO User_Email(email_address, nuid)
VALUES
('johndoe@example.com', 1),
('janedoe@example.com', 2),
('bobsmith@example.com', 3);

INSERT INTO Moderator(employee_id, first_name, last_name, phone_number, street_address, city, state, zip_code)
VALUES
(1, 'John', 'Snow', 6267778888, '1234 ABC St', 'Boston', 'MA', 91837),
(2, 'Jelly', 'Sandwich', 6267778889, '123 ABC St', 'Boston', 'MA', 91839),
(3, 'Peanut', 'Butter', 6267888888, '1200 ABC St', 'Boston', 'MA', 91833);

INSERT INTO Moderator_Email(email_address, nuid)
VALUES
('johndoe@example.com', 1),
('janedoe@example.com', 2),
('bobsmith@example.com', 3);

INSERT INTO Requests(request_id, nuid, name, category_id, `condition`, description, upper_price_range, lower_price_range)
VALUES
(100, 1234567890, 'Shoes', 2, 'New', 'sneakers for gym', 50.00, 0.00),
(101, 1234567890, 'USBC Charger', 1, 'Used', 'charger for iphone', 20.00, 0.00),
(102, 1234567890, 'ORGB Textbook', 3, 'Used', 'textbook for ORGB class', 15.00, 0.00);

INSERT INTO Blacklisted_Users(employee_id, student_id, reason) VALUES
(1, 12345678123, 'posted inappropriate product'),
(1, 12345677723, 'has not shown up to complete orders'),
(1, 12356678123, 'posted inappropriate product');

INSERT INTO Order_Details(order_id, product_id, product_price, meeting_location_name) VALUES
(101, 001, 29.99, 'Speare Hall'),
(102, 002, 3.00, 'Curry'),
(105, 003, 0.00, 'Shillman Hall');
