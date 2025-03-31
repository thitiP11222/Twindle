create database Twindle_db;
use Twindle_db;

CREATE USER 'twindle'@'localhost' IDENTIFIED BY 'td3124';
GRANT SELECT, INSERT, UPDATE ON twindle_db.* TO 'twindle'@'localhost';
FLUSH PRIVILEGES;

CREATE TABLE Product(
	product_id INT NOT NULL UNIQUE,
    product_name VARCHAR(255) NOT NULL ,
    description_ text null,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity 	INT NOT NULL,
    category_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    category_name VARCHAR(255) NOT NULL,
	PRIMARY KEY (product_id)  
);
-- drop table Product;
CREATE TABLE User(
	user_id VARCHAR(255) NOT NULL UNIQUE,
    username text NOT NULL,
    fname text NOT NULL,
    lname text NOT NULL,
    rating REAL NULL,
    badges text NULL,
    bio text NOT NULL,
    phone	text NOT NULL,
    email text NOT NULL,
    passwd varchar(8) NOT NULL,
    profile_pic   text  NULL,
    PRIMARY KEY (user_id)  
);

CREATE TABLE Reviews(
    review_id VARCHAR(255) NOT NULL UNIQUE,
	rating REAL NULL,
    review_text text NULL,
    reviewer_name VARCHAR(255) NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (review_id) ,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
-- drop database Twindle_db;

-- Insert Data
INSERT INTO User (user_id, username, fname, lname, rating, badges, bio, phone, email, passwd, profile_pic)
VALUES 
('U001', 'vintagevibes', 'Anya', 'Lee', 4.9, 'Trusted Treasure', 'ขายเสื้อผ้าวินเทจมือสองคัดพิเศษ ส่งเร็วทุกวัน!', '0891234567', 'anya.vintage@example.com', '2023', 'https://example.com/images/anya.jpg'),

('U002', 'secondstyle', 'Napat', 'Jira', 3.5, NULL, 'เสื้อผ้าแบรนด์เนมมือสองของแท้ 100%', '0887654321', 'napat.seller@example.com', '1234', 'https://example.com/images/napat.jpg'),

('U003', 'minimalpreloved', 'Bee', 'Chan', 4.6, 'Trusted Treasure', 'เสื้อผ้าแนวมินิมอล ใส่เอง ดูแลอย่างดี พร้อมส่ง!', '0861112233', 'bee.minimal@example.com', '9876', NULL),

('U004', 'urbanthrift', 'Krit', 'Suwan', 4.8, 'Safe & Sound', 'เสื้อยืดมือสอง ลายหายาก สภาพสวยๆ ราคาดี!', '0912345678', 'krit.urban@example.com', '1111', 'https://example.com/images/krit.jpg'),

('U005', 'khingcloset', 'Thitiporn', 'Panthanan', 5.0, 'Deep Clean Master', 'แชร์เสื้อผ้าสวยๆ จากตู้ของเรา มาแบ่งให้ในราคาน่ารักๆ 🛍️', '0821839725', 'khing12287@gmail.com', '5555', 'https://example.com/images/khing.jpg');

INSERT INTO Reviews (user_id, review_id, rating, review_text, reviewer_name)
VALUES 
('U001', 'R1', 4.8, 'ชุดสะอาดมากขึ้นได้กลิ่นน้ำยาปรับผ้านุ่ม','Fairy'),
('U002', 'R14', 3.0, 'ของส่งเร็วแต่มีรอยเปื้อนค่ะ','Tommy'),
('U003', 'R5', 4.4, 'รอสินค้านานแต่เสื้อผ้าสะอาดดีค่ะ','Bamboo'),
('U004', 'R20', 4.8, 'สินค้าถูกใจมากค่ะคราวน่าจะมาอีก','Bay'),
('U005', 'R8', 5.0, 'ตรงปกมากค่ะประทับใจสุดๆ','Robot');

INSERT INTO Product (product_id, product_name, description_, price, stock_quantity, category_id, image_url, user_id, category_name)
VALUES
(1, 'Vintage Floral Dress', 'เดรสวินเทจลายดอกไม้ หวานๆ สภาพดี', 390.00, 2, 1, 'assets/imgs/product/p2.png',  'U001', 'Vintage'),

(2, 'Minimal Beige Blazer', 'เสื้อเบลเซอร์สีเบจ สไตล์มินิมอล ใส่ทำงานได้', 450.00, 5, 2, 'assets/imgs/product/p1.png', 'U003', 'Minimal'),

(3, 'Brandname Tote Bag', 'กระเป๋าโท้ทแบรนด์เนมแท้ สีดำ สภาพดีมาก', 1200.00, 1, 3, 'assets/imgs/product/p1.png', 'U002', 'Brandname'),

(4, 'Graphic Vintage Tee', 'เสื้อยืดลายวินเทจหายาก ผ้านิ่มมาก', 250.00, 4, 1, 'assets/imgs/product/p2.png', 'U004', 'Vintage'),

(5, 'Soft Pink Cardigan', 'คาร์ดิแกนไหมพรม สีชมพูอ่อน ใส่แล้วน่ารักมาก', 320.00, 3, 2, 'assets/imgs/product/p1.png', 'U005', 'Minimal');
