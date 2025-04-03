import 'package:twindle_app/model/Seller.dart';
import 'dart:convert'; // ✅ สำหรับใช้ json.decode()

class Product {
  final String productId;
  final String imagePath;
  final String productName;
  final String price;
  String? sRentprice;
  String? lRentprice;
  final String sellerId; // 🔗 Connects to Seller
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
    required this.sellerId, // 🔗 Now connected to Seller
    required this.description,
    required this.category,
    required this.qualityStatus,
    this.brand,
  });
  // Getter เพื่อให้แน่ใจว่าไม่มีค่า null
  String get safeSRentPrice => sRentprice ?? "N/A";
  String get safeLRentPrice => lRentprice ?? "N/A";

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["productId"].toString(),
      imagePath: json["imagePath"] ?? "assets/imgs/default_product.png",
      productName: json["productName"] ?? "No Name",
      price: json["price"]?.toString() ?? "0",
      sRentprice: json["sRentprice"]?.toString(),
      lRentprice: json["lRentprice"]?.toString(),
      sellerId: json["sellerId"] ?? "Unknown",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      qualityStatus: json["qualityStatus"] ?? "",
      brand: json["brand"],
    );
  }
}

// class ProductData {
//   static final List<Seller> sellers = [
//     Seller(
//       sellerId: "S001",
//       sellerName: "Trendy Store",
//       sellerImage: "assets/imgs/seller.jpg",
//       rating: "4.5",
//       contactInfo: "Contact via Line: @trendystore",
//       badges: ["trusted", "clean"], // ✅ ใส่ badge
//     ),
//     Seller(
//       sellerId: "S002",
//       sellerName: "Boho Chic",
//       sellerImage: "assets/imgs/seller.jpg",
//       rating: "4.7",
//       contactInfo: "Contact via Instagram: @bohochic",
//       badges: ["trusted"],
//     ),
//   ];

//   static final List<Product> products = [
//     Product(
//       productId: "P001",
//       imagePath: "assets/imgs/product/p2.png",
//       productName: "Floral Dress",
//       price: "\450",
//       sRentprice: "\100",
//       lRentprice: "\200",
//       sellerId: "S001", // 🔗 Connect to Seller
//       description: "A beautiful floral dress perfect for summer.",
//       category: "Dresses",
//       qualityStatus: 'Good',
//       brand: "Fashion Co.",
//     ),
//     Product(
//       productId: "P002",
//       imagePath: "assets/imgs/product/p1.png",
//       productName: "Boho Top",
//       price: "\300",
//       sellerId: "S002", // 🔗 Connect to Seller
//       description: "A stylish boho top made from organic cotton.",
//       category: "Tops",
//       qualityStatus: 'มีตำหนิ',
//       brand: "Bohemian Trends",
//     ),
//   ];
// }
