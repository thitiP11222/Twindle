# 👗 Twindle - Sustainable Fashion Marketplace

Twindle คือแอปพลิเคชัน Marketplace สำหรับการ **ซื้อ ขาย และเช่าเสื้อผ้ามือสอง** ที่ออกแบบมาเพื่อส่งเสริมแนวคิด Circular Fashion และการใช้ทรัพยากรอย่างยั่งยืน 🌏
---

## 📲 ตัวอย่างหน้าจอแอป

<img src="https://drive.google.com/uc?export=view&id=14-qRFzg5xcx6EXyfYsqwyomE4tY6kKIp"/>

---

## ✨ ฟีเจอร์หลัก

- 📦 โพสต์สินค้าเพื่อขายหรือให้เช่า
- 🔍 ค้นหาและกรองสินค้า
- ❤️ ระบบ Watchlist บันทึกรายการโปรด
- 🧑 โปรไฟล์ผู้ขาย พร้อม badge และเรตติ้ง
- 💬 ระบบแชทสอบถามผู้ขาย
- 🌱 Eco Impact track แสดงผลกระทบสิ่งแวดล้อมที่คุณช่วยลดได้
- 🔐 ระบบ Login/Session และ Logout ที่ปลอดภัย

---

## 📁 โครงสร้างโปรเจกต์ที่สำคัญ

```plaintext
├── database/
│   └── Twindle_db.sql        # SQL สำหรับสร้างฐานข้อมูล
├── lib/
│   ├── model/                # โมเดลข้อมูล
│   ├── page/                 # หน้า UI
│   ├── services/             # เรียก API
│   ├── widget/               # UI component
│   ├── config.dart           # ตั้งค่า URL
│   └── main.dart             # Entry point
├── static/uploads/           # รูปสินค้าที่อัปโหลด
│   ├── default.jpg
│   └── ...
├── app.py                    # Flask backend
```

## 🧰 Tech Stack

| Layer        | Technology              |
|--------------|--------------------------|
| Frontend     | Flutter (Dart)           |
| Backend      | Flask (Python) + MySQL   |
| API          | RESTful API (Self-host)  |
| Hosting      | Localhost / Self-deploy  |

---

## 🚀 เริ่มต้นใช้งาน (Getting Started)

ทำตามขั้นตอนต่อไปนี้เพื่อเริ่มต้นใช้งานระบบ Twindle ทั้ง Backend และ Frontend



### 1. Clone Repo

```bash
git clone https://github.com/yourusername/twindle.git
cd twindle
```


### **2. Setup Backend**

```bash
python app.py
```

🔗 Flask Server จะรันที่: `http://127.0.0.1:5000`



### **3. Setup Database (MySQL)**

1. เปิด MySQL และสร้าง database ชื่อ `Twindle_db`
2. ใช้ไฟล์ `Twindle_db.sql` เพื่อสร้างตารางและข้อมูลเริ่มต้น:

📌 ตรวจสอบให้แน่ใจว่า `user` และ `password` ใน `app.py` ตรงกับการตั้งค่า
```sql
CREATE USER 'twindle'@'localhost' IDENTIFIED BY 'td3124';
GRANT SELECT, INSERT, UPDATE, DELETE ON twindle_db.* TO 'twindle'@'localhost';
```


### **4. Setup Frontend (Flutter)**

```bash
cd ../twindle_app
flutter pub add api_service_helper http shared_preferences image_picker flutter_launcher_icons
flutter pub get
flutter run
```
📌 ขั้นตอนสำคัญ: ตั้งค่า IP Address ของเครื่องที่รัน Flask
แก้ไขให้ตรงกับ IP ของเครื่องที่รัน Backend ที่ `config.dart`

```bash
// ตัวอย่างการตั้งค่า baseURL
const String baseUrl = "http://<your-local-ip>:5000"; // เช่น http://192.168.1.10:5000

```
## Dependencies
This project utilizes the following packages:
- http: ^0.13.6
- cupertino_icons: ^1.0.8
- image_picker: ^1.1.2
- flutter_launcher_icons: ^0.14.3
- shared_preferences: ^2.2.2


---
