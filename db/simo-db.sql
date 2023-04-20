DROP DATABASE IF EXISTS simo;
CREATE DATABASE simo;
grant all privileges on simo.* to 'webapp'@'%';
flush privileges;
USE simo;

CREATE TABLE User (
    nuid INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    password VARCHAR(15),
    user_status INT CHECK (user_status=0 OR user_status=1) DEFAULT (1),
    INDEX `first_name` (`first_name` ASC),
    INDEX `last_name` (`last_name` ASC)
);

CREATE TABLE Buyer (
    buyer_id INT PRIMARY KEY,
    phone_number VARCHAR(12),
    buyer_email VARCHAR(100),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    buyer_first_name VARCHAR(50),
    buyer_last_name VARCHAR(50),
    FOREIGN KEY (buyer_id) REFERENCES User(nuid) ON DELETE CASCADE,
    FOREIGN KEY (buyer_first_name) REFERENCES User(first_name) ON DELETE CASCADE,
    FOREIGN KEY (buyer_last_name) REFERENCES User(last_name) ON DELETE CASCADE
);

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    phone_number VARCHAR(12),
    seller_email VARCHAR(100),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    seller_first_name VARCHAR(50),
    seller_last_name VARCHAR(50),
    FOREIGN KEY (seller_id) REFERENCES User(nuid) ON DELETE CASCADE,
    FOREIGN KEY (seller_first_name) REFERENCES User(first_name) ON DELETE CASCADE,
    FOREIGN KEY (seller_last_name) REFERENCES User(last_name) ON DELETE CASCADE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    buyer_id INT,
    seller_id INT,
    total_price VARCHAR(20),
    seller_rating INT,
    FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    description VARCHAR(5000),
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR(100),
    description VARCHAR(5000),
    price VARCHAR(10),
    category_id INT,
    condition_type VARCHAR(50),
    seller_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    product_price VARCHAR(20),
    meeting_location_name VARCHAR(100),
    order_status INT CHECK (order_status=0 OR order_status=1) DEFAULT (0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE Requests (
    request_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nuid INT,
    request_name VARCHAR(100),
    category_id INT,
    condition_type VARCHAR(50),
    description VARCHAR(5000),
    upper_price_range VARCHAR(20),
    lower_price_range VARCHAR(20),
    FOREIGN KEY (nuid) REFERENCES User(nuid) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

CREATE TABLE Moderator (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(12),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    FOREIGN KEY(employee_id) REFERENCES User(nuid) ON DELETE CASCADE
);

CREATE TABLE Moderator_Email (
    email_address VARCHAR(100),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Moderator(employee_id)
);

CREATE TABLE User_Email (
    email_address VARCHAR(100),
    nuid INT,
    FOREIGN KEY (nuid) REFERENCES User(nuid) ON DELETE CASCADE
);

CREATE TABLE Blocked_Users (
    employee_id INT PRIMARY KEY,
    student_id INT,
    reason VARCHAR(5000),
    FOREIGN KEY (employee_id) REFERENCES Moderator(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES User (nuid) ON DELETE CASCADE
);

INSERT INTO User(nuid, first_name, last_name, password, user_status)
VALUES
(1,'Gael','Heyworth','nnTsJw',0),
(2,'Henrie','Farrear','EyFaj9di9',1),
(3,'Aldis','Cashell','FlQsQi',1),
(4,'Gun','Clarridge','9gLyEJDe0mm',1),
(5,'Rozelle','Vannet','N7oHDkff',1),
(6,'Alejandro','Parris','zYgRHdAZmF9',1),
(7,'Renelle','Blackah','Y8JF01FGsAE',1),
(8,'Mead','Beazer','wZFPRKMBr6D',1),
(9,'Candi','Gillcrist','FxPXFQH',1),
(10,'Torre','Petrolli','4EPxtmcBXo7',1),
(11,'Wilek','Aggus','6UtqGG',1),
(12,'Carmencita','Ivanyutin','lOEja3muN1pC',1),
(13,'Karel','Gurge','QOexhgICgT',1),
(14,'Shoshanna','Winning','qkFFiJYZ',0),
(15,'Katrinka','Insull','Bo2nd68K2',1),
(16,'Ozzie','Grundy','Fr1CmrR0dC',1),
(17,'Janifer','Aland','cQtDPd3WDkzS',1),
(18,'Clifford','Hake','U7Fmaaj',1),
(19,'Yvon','Partridge','mkVrE9E3Thsq',1),
(20,'Toby','Winslow','wUmNSLV',1),
(21,'Orel','Gilfillan','MOFXAvQnMmu2',1),
(22,'Bernie','Nerne','RYt38lPH',1),
(23,'Angelico','Skelding','DRRsvfqswnC9',1),
(24,'Bernhard','Baughan','2NLEwo44kKRl',1),
(25,'Joyce','Grabeham','3UzeKtXh4',0),
(26,'Bernelle','Fleisch','Y4g1Yk',1),
(27,'Amandi','Draijer','GDP08eJ5',1),
(28,'Aurea','Mattocks','szNtzl1',1),
(29,'Bryant','Jeynes','BtQpucDbx',0),
(30,'Sheffield','Holworth','og6PHq6np00',1),
(31,'Anestassia','Tidman','L4pQS1k',1),
(32,'Hunfredo','Bech','yoqKaD0S',1),
(33,'Kathi','Elwyn','ffiaF2l08u',1),
(34,'Baudoin','Beincken','pHz33T',1),
(35,'Correy','Pavolillo','0Fh0DImC',1),
(36,'Ajay','Norcock','CcBwzpJ',1),
(37,'Jackie','Dymick','NzOn5UoiHcI',1),
(38,'Dniren','Diffley','Q3iEJe',1),
(39,'Goldie','Farlow','Q5OIlsX',1),
(40,'Lemmie','Fiddy','ThfUkVldJ8Fl',0),
(41,'Lanie','Burnsell','CmNUZ8cfTV4',1),
(42,'Ashlen','Scapelhorn','yax9oDdx0vX',1),
(43,'Carrissa','Kupper','mvoZZqX0K',1),
(44,'Anabelle','Petofi','NmpV2FzFp5',1),
(45,'Dix','Abade','qUJBLLj9pN',1),
(46,'Devon','Binford','hlxCGSYTK18',1),
(47,'Jason','Tremollet','aGUd5pwPQ7F',1),
(48,'Friedrich','Heskins','Qt5TY0vi',1),
(49,'Yoshiko','Spiaggia','pSduy8',1),
(50,'Alica','Storror','alp3GQFR7D',1);

INSERT INTO Buyer (buyer_id, phone_number, buyer_email, street_address, city, state, zip_code, buyer_first_name, buyer_last_name)
VALUES
(1,'312-725-3509','edibbe0@cdc.gov','86 Darwin Street','Chicago','IL',60614,'Gael','Heyworth'),
(2,'813-919 2669','ldionisetto1@stumbleupon.com','2590 Oak Valley Crossing','Tampa','FL',33615,'Henrie','Farrear'),
(3,'505-145-0662','rpowles2@tmall.com','9 Crownhardt Plaza','Albuquerque','NM',87105,'Aldis','Cashell'),
(4,'941-449-1626','gchallenor3@scribd.com','27661 8th Court','PortCharlotte','FL',33954,'Gun','Clarridge'),
(5,'215-603-5817','pderisley4@statcounter.com','290 Mallory Crossing','Philadelphia','PA',19151,'Rozelle','Vannet'),
(6,'407-317-5233','omchirrie5@wp.com','2 Scott Circle','Orlando','FL',32859,'Alejandro','Parris'),
(7,'202-413-8160','dwalder6@blog.com','90 Center Lane','Washington','DC',20205,'Renelle','Blackah'),
(8,'505-652-8422','edyhouse7@google.fr','918 Heath Terrace','Albuquerque','NM',87201,'Mead','Beazer'),
(9,'509-664-2325','kcrichmere8@woothemes.com','80 Welch Terrace','Spokane','WA',99210,'Candi','Gillcrist'),
(10,'309-243-9607','dmacandrew9@geocities.jp','3 Sunbrook Point','Peoria','IL',61640,'Torre','Petrolli'),
(11,'304-917-0240','abraddera@liveinternet.ru','92 Morningstar Hill','Huntington','WV',25726,'Wilek','Aggus'),
(12,'503-548-6010','nilyuninb@com.com','4 Forster Pass','Beaverton','OR',97075,'Carmencita','Ivanyutin'),
(13,'912-796-9469','dhannigerc@geocities.com','68 Maryland Trail','Savannah','GA',31422,'Karel','Gurge'),
(14,'419-554-6920','mcessfordd@shutterfly.com','245 Blue Bill Park Road','Toledo','OH',43666,'Shoshanna','Winning'),
(15,'831-532-8419','dfarrese@telegraph.co.uk','3637 Londonderry Park','Salinas','CA',93907,'Katrinka','Insull'),
(16,'909-596-1423','jbandef@cdbaby.com','6547 Kennedy Plaza','San Bernardino','CA',92415,'Ozzie','Grundy'),
(17,'415-148-4721','gfishlyg@example.com','81045 Porter Park','San Francisco','CA',94137,'Janifer','Aland'),
(18,'304-204-7988','zglazierh@sakura.ne.jp','6 Blue Bill Park Avenue','Charleston','WV',25331,'Clifford','Hake'),
(19,'602-149-4219','hjershi@symantec.com','3195 Anniversary Circle','Phoenix','AZ',85015,'Yvon','Partridge'),
(20,'323-633-4856','cnesterovj@apache.org','36170 Fisk Trail','Los Angeles','CA',90060,'Toby','Winslow'),
(21,'816-858-8829','cclarridgek@mit.edu','978 Commercial Trail','Kansas City','MO',64125,'Orel','Gilfillan'),
(22,'540-923-9248','mmallabarl@parallels.com','21 Dottie Plaza','Roanoke','VA',24029,'Bernie','Nerne'),
(23,'813-314-0370','kmuggm@blogspot.com','8 Montana Hill','Tampa','FL',33605,'Angelico','Skelding'),
(24,'713-521-7282','mmarshmann@sina.com.cn','87497 Larry Pass','Houston','TX',77245,'Bernhard','Baughan'),
(25,'817-787-8751','kboultwoodo@cnbc.com','0983 Raven Terrace','Fort Worth','TX',76121,'Joyce','Grabeham');

INSERT INTO Seller (seller_id,phone_number,seller_email,street_address,city,state,zip_code,seller_first_name,seller_last_name) VALUES
(26,'763-454-2568','mhubatsch0@upenn.edu','75063 Memorial Court','Monticello','MN',55565,'Bernelle','Fleisch'),
(27,'917-807-9937','tlebarr1@webmd.com','87586 Dottie Way','Flushing','NY',11388,'Amandi','Draijer'),
(28,'480-555-2862','gpoletto2@ucoz.com','9 Atwood Hill','Scottsdale','AZ',85260,'Aurea','Mattocks'),
(29,'757-704-0485','mfierro3@independent.co.uk','65 Melby Terrace','Norfolk','VA',23509,'Bryant','Jeynes'),
(30,'714-386-7414','fbees4@meetup.com','053 Eggendart Road','Garden Grove','CA',92645,'Sheffield','Holworth'),
(31,'785-836-2299','rnutman5@ucsd.edu','821 DunningP laza','Topeka','KS',66629,'Anestassia','Tidman'),
(32,'217-900-8106','lbirley6@hugedomains.com','5888 Basil Pass','Springfield','IL',62718,'Hunfredo','Bech'),
(33,'941-230-3167','cdaunter7@fema.gov','2354 Montana Parkway','North Port','FL',34290,'Kathi','Elwyn'),
(34,'702-624-6768','mapps8@npr.org','70110 Sunfield Place','Henderson','NV',89074,'Baudoin','Beincken'),
(35,'916-589-3905','nwilprecht9@answers.com','752BuellCircle','Sacramento','CA',94230,'Correy','Pavolillo'),
(36,'260-706-4955','hseevioura@macromedia.com','0 Hoepker Lane','Fort Wayne','IN',46857,'Ajay','Norcock'),
(37,'912-352-0931','jkreberb@google.co.uk','11502 Iowa Hill','Savannah','GA',31416,'Jackie','Dymick'),
(38,'352-877-0800','gwerndleyc@constantcontact.com','2618 Anthes Crossing','Ocala','FL',34474,'Dniren','Diffley'),
(39,'919-757-4174','rstebbingsd@ebay.com','16843 Waxwing Lane','Durham','NC',27710,'Goldie','Farlow'),
(40,'325-657-4442','dstoacleye@engadget.com','003 3rd Circle','Abilene','TX',79699,'Lemmie','Fiddy'),
(41,'904-165-2662','pleverettef@rambler.ru','29411 Acker Junction','Jacksonville','FL',32230,'Lanie','Burnsell'),
(42,'619-722-0453','hkidstong@uiuc.edu','7701 Shopk Point','SanD iego','CA',92186,'Ashlen','Scapelhorn'),
(43,'515-979-3863','lboldockh@cdbaby.com','9 RedCloud Center','Des Moines','IA',50981,'Carrissa','Kupper'),
(44,'414-407-3431','djanicijevici@usda.gov','05 Dahle Park','Milwaukee','WI',53277,'Anabelle','Petofi'),
(45,'561-808-5287','myolej@washington.edu','2 Goodland Street','West Palm Beach','FL',33405,'Dix','Abade'),
(46,'775-662-4211','jemlynk@yellowbook.com','0275 Reindahl Pass','Reno','NV',89519,'Devon','Binford'),
(47,'812-961-5295','dgreenanl@phpbb.com','9 Granby Road','Bloomington','IN',47405,'Jason','Tremollet'),
(48,'202-776-3234','mwhifenm@gnu.org','56 Anthes Court','Bethesda','MD',20816,'Friedrich','Heskins'),
(49,'954-515-1792','dhuettn@mayoclinic.com','282 Lighthouse Bay Center','Boca Raton','FL',33432,'Yoshiko','Spiaggia'),
(50,'765-438-1140','chambletto@nbcnews.com','69068 Basil Parkway','Anderson','IN',46015,'Alica','Storror');

INSERT INTO Orders (order_id, date, buyer_id, seller_id, total_price, seller_rating) VALUES
(1,'2023-03-15 10:30:00',24,43,'$189.73',1),
(2,'2022-07-14 14:20:00',14,34,'$186.42',1),
(3,'2022-08-11 08:45:00',24,44,'$83.84',2),
(4,'2022-05-07 15:10:00',1,44,'$23.00',6),
(5,'2022-05-29 12:30:00',6,27,'$86.95',2),
(6,'2023-03-31 16:45:00',7,37,'$144.25',2),
(7,'2022-08-13 09:55:00',15,28,'$181.47',6),
(8,'2023-03-02 13:20:00',22,39,'$43.71',4),
(9,'2022-08-05 19:15:00',4,38,'$146.52',7),
(10,'2022-07-05 21:40:00',23,50,'$160.46',9),
(11,'2022-10-04 08:00:00',6,37,'$73.63',7),
(12,'2023-02-28 11:25:00',5,38,'$108.32',2),
(13,'2022-11-12 16:50:00',20,48,'$189.35',6),
(14,'2023-02-28 19:35:00',17,50,'$61.06',7),
(15,'2022-08-09 06:20:00',2,42,'$65.72',3),
(16,'2022-07-15 22:15:00',15,27,'$38.55',6),
(17,'2022-12-26 17:30:00',6,50,'$57.01',8),
(18,'2022-11-30 14:40:00',25,41,'$57.51',4),
(19,'2022-05-30 13:55:00',18,49,'$8.29',4),
(20,'2022-06-16 18:05:00',8,48,'$133.51',10);

INSERT INTO Category (category_id, description, category_name) VALUES
(1, 'household furniture (ie bedframe)', 'furniture'),
(2, 'articles of clothing', 'clothes'),
(3, 'technological devices (ie appliances)', 'technology'),
(4, 'other', 'other');

INSERT INTO Products (product_id, product_name, description, price, category_id, condition_type, seller_id) VALUES
(1,'Kellogs Cereal In A Cup','Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.','$9.73',2,'worn out',43),
(2,'Cheese Cheddar Processed','Aliquam sit amet diam in magna bibendum imperdiet.','$1.16',1,'worn out',34),
(3,'Lemonade - Natural, 591 Ml','Maecenas tincidunt lacus at velit.','$8.43',3,'new',44),
(4,'Food Colouring - Orange','Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.','$8.26',1,'worn out',44),
(5,'Scotch - Queen Anne','Integer ac leo. Pellentesque ultrices mattis odio.','$3.59',2,'worn out',27),
(6,'Soup - Campbells, Creamy','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','$4.97',3,'new',37),
(7,'Water - Tonic','Sed ante. Vivamus tortor.','$7.97',1,'new',28),
(8,'Corn Kernels - Frozen','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','$2.93',2,'slightly used',39),
(9,'Ecolab - Hand Soap Form Antibac','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','$3.65',4,'slightly used',38),
(10,'Lentils - Red, Dry','Proin at turpis a pede posuere nonummy. Integer non velit.','$9.81',4,'worn out',50),
(11,'Orange - Blood','Pellentesque viverra pede ac diam.','$4.40',3,'new',37),
(12,'Tortillas - Flour, 12','Integer a nibh.','$3.19',1,'worn out',38),
(13,'Iced Tea Concentrate','Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','$2.48',3,'worn out',48),
(14,'Pasta - Detalini, White, Fresh','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.','$3.97',2,'new',50),
(15,'Sprouts - China Rose','In sagittis dui vel nisl. Duis ac nibh.','$6.56',2,'new',42),
(16,'Placemat - Scallop, White','Ut at dolor quis odio consequat varius. Integer ac leo.','$7.53',1,'slightly used',27),
(17,'Salt And Pepper Mix - Black','Nulla ut erat id mauris vulputate elementum.','$8.22',1,'slightly used',50),
(18,'Muskox - French Rack','Pellentesque ultrices mattis odio. Donec vitae nisi.','$3.56',2,'worn out',41),
(19,'Milk - Homo','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.','$6.05',4,'new',49),
(20,'White Baguette','Sed sagittis.','$5.54',2,'slightly used',48),
(21,'Sauce - Demi Glace','Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','$1.94',4,'worn out',34),
(22,'Cardamon Ground','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.','$5.69',2,'slightly used',43),
(23,'Soup - Knorr, Ministrone','Vivamus tortor. Duis mattis egestas metus.','$8.45',3,'worn out',28),
(24,'Tortillas - Flour, 12','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','$2.17',2,'slightly used',33),
(25,'V8 - Tropical Blend','Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.','$4.02',3,'slightly used',46),
(26,'Cornish Hen','Morbi porttitor lorem id ligula.','$2.35',4,'worn out',41),
(27,'Island Oasis - Raspberry','Quisque ut erat.','$7.51',4,'slightly used',29),
(28,'Gooseberry','Aliquam sit amet diam in magna bibendum imperdiet.','$3.09',2,'worn out',49),
(29,'Nut - Pine Nuts, Whole','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.','$8.49',4,'slightly used',50),
(30,'Lettuce - Lambs Mash','In congue.','$7.93',4,'worn out',29);


INSERT INTO Order_Details (order_id,product_id,product_price,meeting_location_name,order_status) VALUES
(1,1,'$193.43','Snell',1),
(2,2,'$195.10','Curry',0),
(3,3,'$124.09','Curry',1),
(4,4,'$5.48','Krentzman',1),
(5,5,'$147.88','Snell',0),
(6,6,'$34.47','Snell',1),
(7,7,'$183.58','West H',1),
(8,8,'$123.95','Krentzman',1),
(9,9,'$196.98','Krentzman',1),
(10,10,'$192.38','Snell',0),
(11,11,'$35.35','ISEC',0),
(12,12,'$159.56','Snell',0),
(13,13,'$91.04','Krentzman',0),
(14,14,'$161.64','ISEC',0),
(15,15,'$188.17','Curry',0),
(16,16,'$121.35','Krentzman',0),
(17,17,'$105.87','Snell',0),
(18,18,'$131.85','ISEC',0),
(19,19,'$15.01','West H',0),
(20,20,'$2.04','Krentzman',1);

INSERT INTO Requests (request_id, nuid, request_name, category_id, condition_type, description, upper_price_range, lower_price_range)
VALUES
(1,9,'Mahi Mahi',3,'new','Aenean lectus. Pellentesque eget nunc.',' $113.47',' $14.31'),
(2,10,'Chicken - Base',4,'slightly used','Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.',' $144.50',' $4.62'),
(3,5,'Squash - Acorn',3,'new','Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.',' $29.96',' $12.69'),
(4,23,'Wine - Toasted Head',1,'worn out','Aliquam erat volutpat.',' $159.97',' $22.92'),
(5,9,'Iced Tea - Lemon, 340ml',1,'worn out','Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.',' $101.64',' $7.35'),
(6,17,'Limes',1,'worn out','Curabitur at ipsum ac tellus semper interdum.',' $179.49',' $16.03'),
(7,2,'Swiss Chard',2,'slightly used','Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',' $153.11',' $8.53'),
(8,6,'Chocolate Bar - Coffee Crisp',1,'worn out','Vestibulum sed magna at nunc commodo placerat.',' $168.63',' $18.71'),
(9,9,'Seaweed Green Sheets',1,'slightly used','Suspendisse accumsan tortor quis turpis. Sed ante.',' $59.01',' $8.34'),
(10,15,'Ecolab Crystal Fusion',2,'worn out','Nulla tempus.',' $38.31',' $9.12'),
(11,14,'Chicken - Ground',3,'worn out','Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',' $60.13',' $20.62'),
(12,3,'Cheese - Wine',1,'new','Etiam vel augue. Vestibulum rutrum rutrum neque.',' $37.08',' $14.01'),
(13,23,'Pastry - Chocolate Marble Tea',4,'slightly used','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',' $166.46',' $1.54'),
(14,7,'Venison - Liver',2,'worn out','Suspendisse accumsan tortor quis turpis.',' $133.72',' $18.85'),
(15,17,'Dehydrated Kelp Kombo',4,'new','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.',' $128.52',' $21.61');

INSERT INTO Moderator (employee_id, first_name, last_name, phone_number, street_address, city, state, zip_code)
VALUES
(1,'Nikolos','Nassau','513-204-6666','415 Comanche Court','Cincinnati','OH',45233  ),
(2,'Gilly','Chopin','603-200-7148','25735 Rieder Way','Manchester','NH',3105  ),
(3,'Abdel','Copyn','775-536-5037','407 Alpine Street','Reno','NV',89550  );

INSERT INTO Moderator_Email (email_address, employee_id)
VALUES
('nassau.nik@northeastern.edu', 1),
('chopin.gil@northeastern.edu', 2),
('copyn.abd@northeastern.edu', 3);INSERT INTO User_Email (email_address, nuid)
VALUES
('edibbe0@cdc.gov',1),
('ldionisetto1@stumbleupon.com',2),
('rpowles2@tmall.com',3),
('gchallenor3@scribd.com',4),
('pderisley4@statcounter.com',5),
('omchirrie5@wp.com',6),
('dwalder6@blog.com',7),
('edyhouse7@google.fr',8),
('kcrichmere8@woothemes.com',9),
('dmacandrew9@geocities.jp',10),
('abraddera@liveinternet.ru',11),
('nilyuninb@com.com',12),
('dhannigerc@geocities.com',13),
('mcessfordd@shutterfly.com',14),
('dfarrese@telegraph.co.uk',15),
('jbandef@cdbaby.com',16),
('gfishlyg@example.com',17),
('zglazierh@sakura.ne.jp',18),
('hjershi@symantec.com',19),
('cnesterovj@apache.org',20),
('cclarridgek@mit.edu',21),
('mmallabarl@parallels.com',22),
('kmuggm@blogspot.com',23),
('mmarshmann@sina.com.cn',24),
('kboultwoodo@cnbc.com',25),
('mhubatsch0@upenn.edu',26),
('tlebarr1@webmd.com',27),
('gpoletto2@ucoz.com',28),
('mfierro3@independent.co.uk',29),
('fbees4@meetup.com',30),
('rnutman5@ucsd.edu',31),
('lbirley6@hugedomains.com',32),
('cdaunter7@fema.gov',33),
('mapps8@npr.org',34),
('nwilprecht9@answers.com',35),
('hseevioura@macromedia.com',36),
('jkreberb@google.co.uk',37),
('gwerndleyc@constantcontact.com',38),
('rstebbingsd@ebay.com',39),
('dstoacleye@engadget.com',40),
('pleverettef@rambler.ru',41),
('hkidstong@uiuc.edu',42),
('lboldockh@cdbaby.com',43),
('djanicijevici@usda.gov',44),
('myolej@washington.edu',45),
('jemlynk@yellowbook.com',46),
('dgreenanl@phpbb.com',47),
('mwhifenm@gnu.org',48),
('dhuettn@mayoclinic.com',49),
('chambletto@nbcnews.com',50);

INSERT INTO Blocked_Users (employee_id, student_id, reason)
VALUES
(3,25,'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.'),
(2,1,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.'),
(1,14,'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
