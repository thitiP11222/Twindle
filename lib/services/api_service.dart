import 'package:http/http.dart' as http;
import 'package:twindle_app/config.dart';
import 'dart:convert';
import 'package:twindle_app/page/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twindle_app/config.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
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
  final url = Uri.parse('$baseUrl/login'); // สำหรับ Emulator
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
  final fname = responseData["fname"]; 
  final lname = responseData["lname"]; 
  final userId = responseData["user_id"]; 
  final profile_pic = responseData['profile_pic'];

  // ✅ บันทึก session
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", email);
  await prefs.setString("fname", fname);
  await prefs.setString("lname", lname);
  await prefs.setString("profile_pic", profile_pic);
  await prefs.setString("user_id", userId);

  print("✅ Login success | user_id: $userId");
  

  // ✅ Go to /account page
      Navigator.pushReplacementNamed(context, '/account', arguments: {
        'email': email,
        'fname': fname,
        'lname': lname,
        'profile_pic': profile_pic,
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
      await http.get(Uri.parse('$baseUrl/products'));

  if (response.statusCode == 200) {
    return json.decode(response.body); // แปลงเป็น List<Map>
  } else {
    throw Exception('Failed to load products');
  }
}



Future<Map<String, dynamic>> fetchProductAndSellerData() async {
  try {
    final productRes = await http.get(Uri.parse('$baseUrl/products'));
    final sellerRes = await http.get(Uri.parse('$baseUrl/sellers'));

    if (productRes.statusCode == 200 && sellerRes.statusCode == 200) {
      final List<Product> products = (json.decode(productRes.body) as List)
          .map((p) => Product.fromJson(p))
          .toList();

      final List<Seller> sellers = (json.decode(sellerRes.body) as List)
          .map((s) => Seller.fromJson(s))
          .toList();

      return {
        'products': products,
        'sellers': sellers,
      };
    } else {
      throw Exception("Failed to load product or seller data");
    }
  } catch (e) {
    print("❌ fetchProductAndSellerData error: $e");
    return {
      'products': [],
      'sellers': [],
    };
  }
}