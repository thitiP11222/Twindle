import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twindle_app/page/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://localhost:5000/users'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load users');
  }
}

// Call API Login
// ฟังก์ชัน login สำหรับส่งอีเมลและรหัสผ่านไปยังเซิร์ฟเวอร์
// ถ้า login สำเร็จ จะพาไปหน้า home พร้อมส่งอีเมลไปด้วย
// ถ้าไม่สำเร็จ จะแสดง popup แจ้งข้อผิดพลาด

Future<void> login({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  final url = Uri.parse('http://10.0.2.2:5000/login'); // สำหรับ Emulator
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "passwd": password,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final fname = responseData["fname"]; // ดึงชื่อผู้ใช้จาก response
      final userId = responseData["user_id"]; // ✅ ได้มาจาก backend

      // ✅ บันทึก session ด้วย SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setString("fname", fname);

      await prefs.setString("user_id", userId); // ✅ ต้องมีบรรทัดนี้

      print("✅ Login success | user_id: $userId"); // 🔍 เพิ่ม log ช่วย debug

      // ✅ ไปหน้า MainScreen พร้อมส่ง email, fname, user_id
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'email': email,
        'fname': fname,
        'user_id': userId,
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text(responseData["message"]),
        ),
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text("Could not connect to server"),
      ),
    );
  }
}


Future<List<dynamic>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('http://10.62.69.253:5000/products'));

  if (response.statusCode == 200) {
    return json.decode(response.body); // แปลงเป็น List<Map>
  } else {
    throw Exception('Failed to load products');
  }
}


