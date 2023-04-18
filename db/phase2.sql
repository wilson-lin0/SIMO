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