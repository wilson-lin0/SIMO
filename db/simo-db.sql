DROP DATABASE IF EXISTS simo;
CREATE DATABASE simo;
grant all privileges on simo.* to 'webapp'@'%';
flush privileges;
USE simo;

CREATE TABLE User (
    nuid INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    pass VARCHAR(15),
    user_status INT CHECK (user_status=0 OR user_status=1) DEFAULT (1),
    INDEX `first_name` (`first_name` ASC),
    INDEX `last_name` (`last_name` ASC)
);

CREATE TABLE Buyer (
    buyer_id INT PRIMARY KEY,
    phone_number INT,
    buyer_email VARCHAR(100),
    total_buyer_rating INT,
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    buyer_first_name VARCHAR(50),
    buyer_last_name VARCHAR(50),
    FOREIGN KEY (buyer_id) REFERENCES User(nuid),
    FOREIGN KEY (buyer_first_name) REFERENCES User(first_name),
    FOREIGN KEY (buyer_last_name) REFERENCES User(last_name)
);

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    phone_number INT,
    seller_email VARCHAR(100),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    total_seller_rating INT,
    seller_first_name VARCHAR(50),
    seller_last_name VARCHAR(50),
    FOREIGN KEY (seller_id) REFERENCES User(nuid),
    FOREIGN KEY (seller_first_name) REFERENCES User(first_name),
    FOREIGN KEY (seller_last_name) REFERENCES User(last_name)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    buyer_id INT,
    seller_id INT,
    total_price DOUBLE,
    seller_rating INT,
    FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
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
    product_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DOUBLE,
    category_id INT,
    condition_type VARCHAR(50),
    seller_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    product_price DOUBLE,
    meeting_location_name VARCHAR(100),
    order_status INT CHECK (order_status=0 OR order_status=1) DEFAULT (0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (meeting_location_name) REFERENCES Meeting_Location(name)
);

CREATE TABLE Requests (
    request_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nuid INT,
    name VARCHAR(100),
    category_id INT,
    condition_type VARCHAR(50),
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
    zip_code INT,
    FOREIGN KEY(employee_id) REFERENCES User(nuid)
);

CREATE TABLE Moderator_Email (
    email_address VARCHAR(100),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Moderator(employee_id)
);

CREATE TABLE User_Email (
    email_address VARCHAR(100),
    nuid INT,
    FOREIGN KEY (nuid) REFERENCES User(nuid)
);

CREATE TABLE Blocked_Users (
    employee_id INT PRIMARY KEY,
    student_id INT,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES Moderator(employee_id),
    FOREIGN KEY (student_id) REFERENCES User (nuid)
);