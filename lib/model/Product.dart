import 'package:twindle_app/model/Seller.dart';
import 'dart:convert'; //สำหรับใช้ json.decode()

class Product {
  final String productId;
  final String imagePath;
  final String productName;
  final String price;
  String? sRentprice;
  String? lRentprice;
  final String sellerId; //Connects to Seller
  final String description;
  final String category;
  final String qualityStatus;
  String? brand;

  Product({
    required this.productId,
    required this.imagePath,
    required this.productName,
    required this.price,
    this.sRentprice,
    this.lRentprice,
    required this.sellerId, //  connected to Seller
    required this.description,
    required this.category,
    required this.qualityStatus,
    this.brand,
  });


factory Product.fromJson(Map<String, dynamic> json) {
  final rawPath = json["image_url"] ?? "static/uploads/default.jpg";

  // ตรวจว่าเป็น asset หรือไม่ ถ้าไม่ใช่ → ต่อ URL
  final isAsset = rawPath.startsWith("assets/");
  final fullImagePath = isAsset
      ? rawPath
      : "http://10.0.2.2:5000/$rawPath"; //  ใช้สำหรับ Emulator

  return Product(
    productId: json["product_id"].toString(),
    imagePath: fullImagePath, // ใช้ path ที่พร้อมแสดง
    productName: json["product_name"] ?? "No Name",
    price: json["price"]?.toString() ?? "0",
    sRentprice: json["sRentprice"]?.toString(),
    lRentprice: json["lRentprice"]?.toString(),
    sellerId: json["user_id"] ?? "Unknown",
    description: json["description_"] ?? "",
    category: json["category_name"] ?? "",
    qualityStatus: json["qualityStatus"] ?? "",
    brand: json["brand"],
  );
}


}
