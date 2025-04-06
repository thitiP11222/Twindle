import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twindle_app/main.dart';
import 'package:twindle_app/page/Post%20Success.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:twindle_app/page/home.dart';

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
  String? userId;

@override
void initState() {
  super.initState();
  loadUserId();
}

Future<void> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final loadedId = prefs.getString('user_id');
  setState(() {
    userId = loadedId;
  });
  print("✅ Loaded user_id: $userId");
}

  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final conditionController = TextEditingController();
  final priceController = TextEditingController();
  final rent3Controller = TextEditingController();
  final rent5Controller = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
  source: ImageSource.gallery,
  preferredCameraDevice: CameraDevice.rear,
  imageQuality: 85, // บีบอัดภาพ
);

if (pickedFile != null) {
  final ext = pickedFile.path.split('.').last.toLowerCase();
  if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("กรุณาเลือกไฟล์ .jpg หรือ .png เท่านั้น"),
    ));
    return;
  }

  setState(() {
    _image = File(pickedFile.path);
  });
}
  }

  Future<void> submitProduct() async {
  final uri = Uri.parse('http://10.0.2.2:5000/add-product');
  final request = http.MultipartRequest('POST', uri);

  // ✅ Fields ที่ backend ต้องการ
  request.fields['product_name'] = nameController.text;
  request.fields['description'] = descriptionController.text;
  request.fields['price'] = priceController.text;
  request.fields['qualityStatus'] = conditionController.text ?? 'ไม่ระบุ' ;
  request.fields['category_id'] = '1';
  request.fields['brand'] = brandController.text ?? 'ไม่ระบุ';
  request.fields['category_name'] = categoryController.text;
  request.fields['user_id'] = userId ?? '';
print("✅ Submitting with user_id: $userId");
  final prefs = await SharedPreferences.getInstance();
print("📦 Shared user_id: ${prefs.getString('user_id')}");





  // ✅ Image file
  if (_image != null) {
    final imageFile = await http.MultipartFile.fromPath('image', _image!.path);
    request.files.add(imageFile);
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("✅ Upload Success: ${response.body}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Postsuccess()),
      );
    } else {
      print("❌ Upload Failed: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("❌ Upload error: $e");
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
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(0),
                    ),
                    const Spacer(),
                    const Text('สร้างรายการสินค้าใหม่', style: TextStyle(fontSize: 22)),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildSectionTitle('ข้อมูลทั่วไป'),
              buildTextInputField('ชื่อสินค้า*', 'ชื่อสินค้า', nameController),
              buildTextInputField('แบรนด์สินค้า*', 'เช่น Zara, Nike, Uniqlo', brandController),
              buildTextInputField('หมวดหมู่สินค้า', 'เสื้อผ้า, กระเป๋า, รองเท้า', categoryController),
              buildSectionTitle('รูปภาพสินค้า*'),
              buildImagePicker(),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('*อัปโหลดรูปภาพจำนวน 1-3 รูป', style: TextStyle(fontSize: 10, color: Color(0x7B00FF))),
              ),
              const SizedBox(height: 20),
              buildSectionTitle('รายละเอียดสินค้า'),
              buildTextInputField('คำอธิบายสินค้า*', 'ใส่คำอธิบาย', descriptionController),
              buildTextInputField('สภาพสินค้า*', 'ใหม่ / ปานกลาง / มีตำหนิ', conditionController),
              buildTextInputField('ราคาขาย', 'ราคาสินค้า เช่น 200 ฿', priceController),
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 2),
                child: Text('*เว้นว่างหากไม่ขายขาด', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ),
              const SizedBox(height: 30),
              buildSectionTitle('ราคาค่าเช่า'),
              buildRentalTextField('ราคาค่าเช่า 3 วัน*', 'กรอกราคา เช่น 370 ฿', '3 วัน', rent3Controller),
              const SizedBox(height: 10),
              buildRentalTextField('ราคาค่าเช่า 5 วัน*', 'กรอกราคา เช่น 570 ฿', '5 วัน', rent5Controller),
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 2),
                child: Text('*เว้นว่างหากไม่อยากปล่อยเช่า', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 198, 255, 235),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: submitProduct,
                  child: const Text('โพสต์สินค้า', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(left: 50, bottom: 15),
    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  );

  Widget buildTextInputField(String label, String placeholder, TextEditingController controller) => Padding(
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
            controller: controller,
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

  Widget buildRentalTextField(String label, String placeholder, String duration, TextEditingController controller) => Padding(
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
                  controller: controller,
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

  Widget buildImagePicker() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 45),
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
