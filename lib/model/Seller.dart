import 'package:flutter/material.dart';
import 'dart:convert'; // ✅ สำหรับใช้ json.decode()

class Seller {
  final String user_id;
  final String username;
  final String profile_pic;
  final String rating;
  final String bio;
  final List<String> badges; // ✅ เพิ่ม badges

  Seller({
    required this.user_id,
    required this.username,
    required this.profile_pic,
    required this.rating,
    required this.bio,
    required this.badges,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      user_id: json["user_id"] ?? "Unknown",
      username: json["username"] ?? "Unknown Seller",
      profile_pic: json["profile_pic"] ?? "assets/imgs/default_seller.png",
      rating: json["rating"] ?? "No Rating",
      bio: json["bio"] ?? "No Info",
      badges: List<String>.from(json["badges"] ?? []), // ✅ เพิ่มตรงนี้
    );
  }
}
