import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const Post());
}

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    Spacer(),
                    Text(
                      'สร้างรายการสินค้าใหม่',
                      style: TextStyle(fontSize: 22),
                    ),
                    Spacer(),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ข้อมูลทั่วไป
              buildSectionTitle('ข้อมูลทั่วไป'),
              buildTextInputField('ชื่อสินค้า*', 'ชื่อสินค้า'),
              buildTextInputField('แบรนด์สินค้า*', 'เช่น Zara, Nike, Uniqlo, ไม่ระบุ'),
              buildTextInputField('หมวดหมู่สินค้า', 'เลือกจากหมวดหมู่ เช่น เสื้อผ้า, กระเป๋า, รองเท้า'),

              // 🔹 อัปโหลดรูปสินค้า
              buildSectionTitle('รูปภาพสินค้า*'),
              buildImagePicker(),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  '*อัปโหลดรูปภาพจำนวน 1-3 รูป',
                  style: TextStyle(fontSize: 10, color: Color(0x7B00FF)),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 รายละเอียดสินค้า
              buildSectionTitle('รายละเอียดสินค้า'),
              buildTextInputField('คำอธิบายสินค้า*', 'ใส่คำอธิบายสินค้าแบบกระชับ เช่น คุณสมบัติเด่น, การใช้งาน'),
              buildTextInputField('สภาพสินค้า*', 'ตัวเลือก: ใหม่ / ดีมาก / ปานกลาง / มีตำหนิ'),
              buildTextInputField('ราคาขาย', 'ราคาสินค้า เช่น 200 ฿'),

              // **ปรับข้อความให้ชิดข้างบนมากขึ้น**
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 2),
                child: Text(
                  '*เว้นว่างหากไม่ขายขาด',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ราคาค่าเช่า
              buildSectionTitle('ราคาค่าเช่า'),

              buildRentalTextField('ราคาค่าเช่า 3 วัน*', 'กรอกราคา 3 วัน / 370 ฿', 'ระยะเวลาการเช่า 3 วัน'),
              const SizedBox(height: 10),
              buildRentalTextField('ราคาค่าเช่า 5 วัน*', 'กรอกราคา เช่น 5 วัน / 570 ฿', 'ระยะเวลาการเช่า 5 วัน'),

              Padding(
                padding: const EdgeInsets.only(left: 50, top: 2),
                child: Text(
                  '*เว้นว่างหากไม่อยากปล่อยเช่า',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ปุ่มโพสต์สินค้า
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 198, 255, 235),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    // ทำงานเมื่อกดปุ่มโพสต์สินค้า
                  },
                  child: const Text(
                    'โพสต์สินค้า',
                    style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w700,),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 ฟังก์ชันสร้างหัวข้อส่วนต่างๆ
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, bottom: 15),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  // 🔹 ฟังก์ชันสร้างช่องกรอกข้อมูล
  Widget buildTextInputField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: placeholder,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 ฟังก์ชันสร้างช่องกรอกราคาค่าเช่า
  Widget buildRentalTextField(String label, String placeholder, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 5),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: placeholder,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(duration, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // 🔹 ฟังก์ชันสร้างช่องอัปโหลดรูปภาพ
  Widget buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle_outline, size: 40, color: Colors.purple),
                    SizedBox(height: 5),
                    Text('อัปโหลดรูปภาพสินค้า', style: TextStyle(fontSize: 14)),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_image!, width: 300, height: 150, fit: BoxFit.cover),
                ),
        ),
      ),
    );
  }
}
