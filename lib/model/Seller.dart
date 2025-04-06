import 'package:flutter/material.dart';
import 'dart:convert'; // ✅ สำหรับใช้ json.decode()

class Seller {
  final String user_id;
  final String username;
  final String profile_pic;
  final String rating;
  final String phone;
  final String email;
  final String fname;
  final String lname;
  final String bio;
  final List<String> badges; // ✅ เพิ่ม badges

  Seller({
    required this.user_id,
    required this.username,
    required this.profile_pic,
    required this.rating,
    required this.phone,
    required this.email,
    required this.bio,
    required this.fname,
    required this.lname,

    required this.badges,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
  return Seller(
    user_id: json["user_id"] ?? "Unknown",
    username: json["username"] ?? "Unknown Seller",
    profile_pic: json["profile_pic"] ?? "assets/imgs/default_seller.png",
    rating: (json["rating"]?.toString() ?? "0"),
    phone: (json["phone"]?? "-"),
    email: (json["email"]?? "-"),
    fname: (json["fname"]?? "-"),
    lname: (json["lname"]?? "-"),
    bio: json["bio"] ?? "No Info",

    // 🛠 ถ้า badges เก็บแบบเป็น String เช่น "Top Rated,Verified"
    badges: (json["badges"] != null && json["badges"] is String)
        ? (json["badges"] as String).split(',').map((e) => e.trim()).toList()
        : [],
  );
}
}
