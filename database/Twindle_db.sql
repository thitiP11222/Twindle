create database Twindle_db;
use Twindle_db;
-- drop database Twindle_db;
CREATE USER 'twindle'@'localhost' IDENTIFIED BY 'td3124';
GRANT SELECT, INSERT, UPDATE, DELETE ON twindle_db.* TO 'twindle'@'localhost';
FLUSH PRIVILEGES;

-- drop table Product;
CREATE TABLE User(
	user_id VARCHAR(255) NOT NULL,
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

CREATE TABLE Product(
	product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL ,
    description_ text null,
    brand VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    sRentprice DECIMAL(10,2), -- short term rent
    lRentprice DECIMAL(10,2), -- long term rent
    qualityStatus 	VARCHAR(255),
    category_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    category_name VARCHAR(255) NOT NULL,
	PRIMARY KEY (product_id)  ,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Reviews(
    review_id VARCHAR(255) NOT NULL UNIQUE,
	rating REAL NULL,
    review_text text NULL,
    reviewer_name VARCHAR(255) NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL ,
    PRIMARY KEY (review_id) ,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);


-- Insert Data
INSERT INTO User (user_id, username, fname, lname, rating, badges, bio, phone, email, passwd, profile_pic)
VALUES 
('U001', 'vintagevibes', 'Anya', 'Lee', 4.9, 'Trusted Treasure', 'ขายเสื้อผ้าวินเทจมือสองคัดพิเศษ ส่งเร็วทุกวัน!', '0891234567', 'anya.vintage@example.com', '2023', 'assets/imgs/profile/pf1.jpg'),

('U002', 'secondstyle', 'Napat', 'Jira', 3.5, NULL, 'เสื้อผ้าแบรนด์เนมมือสองของแท้ 100%', '0887654321', 'napat.seller@example.com', '1234', 'assets/imgs/profile/pf2.jpg'),

('U003', 'minimalpreloved', 'Bee', 'Chan', 4.6, 'Trusted Treasure', 'เสื้อผ้าแนวมินิมอล ใส่เอง ดูแลอย่างดี พร้อมส่ง!', '0861112233', 'bee.minimal@example.com', '9876', 'assets/imgs/profile/pf3.jpg'),

('U004', 'urbanthrift', 'Krit', 'Suwan', 4.8, 'Safe & Sound', 'เสื้อยืดมือสอง ลายหายาก สภาพสวยๆ ราคาดี!', '0912345678', 'krit.urban@example.com', '1111', 'assets/imgs/profile/pf4.jpg'),

('U005', 'khingcloset', 'Thitiporn', 'Panthanan', 5.0, 'Deep Clean Master', 'แชร์เสื้อผ้าสวยๆ จากตู้ของเรา มาแบ่งให้ในราคาน่ารักๆ 🛍️', '0821839725', 'khing12287@gmail.com', '5555', 'assets/imgs/profile/pf5.jpg');

INSERT INTO Reviews (user_id, review_id, rating, review_text, reviewer_name)
VALUES 
('U001', 'R1', 4.8, 'ชุดสะอาดมากขึ้นได้กลิ่นน้ำยาปรับผ้านุ่ม','Fairy'),
('U002', 'R14', 3.0, 'ของส่งเร็วแต่มีรอยเปื้อนค่ะ','Tommy'),
('U003', 'R5', 4.4, 'รอสินค้านานแต่เสื้อผ้าสะอาดดีค่ะ','Bamboo'),
('U004', 'R20', 4.8, 'สินค้าถูกใจมากค่ะคราวน่าจะมาอีก','Bay'),
('U005', 'R8', 5.0, 'ตรงปกมากค่ะประทับใจสุดๆ','Robot');

-- drop table Product;
INSERT INTO Product (
  product_name, description_, brand, price, sRentprice, lRentprice,
  qualityStatus, category_id, image_url, user_id, category_name
)
VALUES
-- 📦 เสื้อ
('เสื้อยืด Oversized', 'เสื้อยืดผ้าคอตตอนใส่สบาย เหมาะสำหรับทุกวัน', 'Uniqlo', 350.00, 70.00, 120.00, 'ใหม่', 1, 'assets/imgs/product/pd1.jpg', 'U001', 'เสื้อผ้า'),

-- 👗 เดรส
('เดรสสายเดี่ยวลายดอก', 'ชุดเดรสลายดอกน่ารัก ใส่เที่ยวทะเลหรือเดตได้', 'Polemo', 950.00, 150.00, 280.00, 'ดีมาก', 2, 'assets/imgs/product/pd2.jpg', 'U002', 'แฟชั่น'),

-- 👠 รองเท้า
('รองเท้าส้นสูง', 'รองเท้าส้นสูงสีดำ สำหรับใส่ออกงานหรือสัมภาษณ์', 'H&M', 790.00, 120.00, 220.00, 'ดีมาก', 3, 'assets/imgs/product/pd3.jpg', 'U003', 'รองเท้า'),

-- 👜 กระเป๋า
('กระเป๋าสะพายข้าง', 'กระเป๋าสะพายหนังเทียม ช่องใส่ของเยอะ', 'Charles & Keith', 1290.00, 180.00, 350.00, 'ใหม่มาก', 4, 'assets/imgs/product/pd4.jpg', 'U004', 'กระเป๋า'),

-- 👓 แว่นกันแดด
('แว่นกันแดดแฟชั่น', 'แว่นกันแดดทรง Oversized สีดำ สไตล์เกาหลี', 'Gentle Monster', 1600.00, 200.00, 400.00, 'ใหม่', 5, 'assets/imgs/product/pd5.jpg', 'U005', 'แอคเซสซอรี่'),

-- 👗 กระโปรง
('กระโปรงพลีทสั้น', 'กระโปรงสั้นทรงเอพลีท ใส่แล้วดูน่ารัก สดใส', 'Zara', 850.00, 140.00, 270.00, 'ใหม่', 1, 'assets/imgs/product/pd6.jpg', 'U001', 'เสื้อผ้า');
