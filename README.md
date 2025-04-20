# twindle_app

A new Flutter project.
# 👗 Twindle - Sustainable Fashion Marketplace

Twindle คือแอปพลิเคชัน Marketplace สำหรับการ **ซื้อ ขาย และเช่าเสื้อผ้ามือสอง** ที่ออกแบบมาเพื่อส่งเสริมแนวคิด Circular Fashion และการใช้ทรัพยากรอย่างยั่งยืน 🌏♻️

---

## 📲 ตัวอย่างหน้าจอแอป

<img src="screenshots/home.png" width="200"/> <img src="screenshots/product_detail.png" width="200"/> <img src="screenshots/account.png" width="200"/>

---

## ✨ ฟีเจอร์หลัก

- 📦 โพสต์สินค้าเพื่อขายหรือให้เช่า
- 🔍 ค้นหาและกรองสินค้า
- ❤️ ระบบ Watchlist บันทึกรายการโปรด
- 🧑 โปรไฟล์ผู้ขาย พร้อม badge และเรตติ้ง
- 💬 ระบบแชทสอบถามผู้ขาย
- 🌱 Eco Impact Dashboard แสดงผลกระทบสิ่งแวดล้อมที่คุณช่วยลดได้
- 🔐 ระบบ Login/Session และ Logout ที่ปลอดภัย

---

## 🧰 Tech Stack

| Layer        | Technology              |
|--------------|--------------------------|
| Frontend     | Flutter (Dart)           |
| Backend      | Flask (Python) + MySQL   |
| API          | RESTful API (Self-host)  |
| State Mgmt   | setState, SharedPreferences |
| Hosting      | Localhost / Self-deploy  |

---

## 🚀 เริ่มต้นใช้งาน (Getting Started)

ทำตามขั้นตอนต่อไปนี้เพื่อเริ่มต้นใช้งานระบบ Twindle ทั้ง Backend และ Frontend

---

### 1. Clone Repo

```bash
git clone https://github.com/yourusername/twindle.git
cd twindle
```


### **2. Setup Backend**

```bash
cd backend
python3 -m venv venv
source venv/bin/activate  # บน Windows ใช้: venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

🔗 Flask Server จะรันที่: `http://127.0.0.1:5000`



### **3. Setup Database (MySQL)**

1. เปิด MySQL และสร้าง database ชื่อ `Twindle_db`
2. ใช้ไฟล์ `Twindle_db.sql` เพื่อสร้างตารางและข้อมูลเริ่มต้น:

```sql
source path/to/Twindle_db.sql;
```

📌 ตรวจสอบให้แน่ใจว่า `user` และ `password` ใน `app.py` ตรงกับการตั้งค่าในเครื่องคุณ



### **4. Setup Frontend (Flutter)**

```bash
cd ../twindle_app
flutter pub get
flutter run
```

📱 แนะนำให้ทดสอบบน Emulator หรืออุปกรณ์จริงที่เชื่อมต่ออินเทอร์เน็ต

---

## 📚 Flutter Resources (เพิ่มเติมสำหรับผู้เริ่มต้น)

หากคุณยังใหม่กับ Flutter สามารถศึกษาได้จากแหล่งข้อมูลเหล่านี้:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
