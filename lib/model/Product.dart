import 'package:twindle_app/model/Seller.dart';

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
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     productId: json["productId"] ?? "P000",
  //     imagePath: json["imagePath"] ?? "assets/imgs/default_product.png",
  //     productName: json["productName"] ?? "No Name",
  //     price: json["price"] ?? "N/A",
  //     Rentprice: json["Rentprice"] ?? "N/A",
  //     sellerId: json["sellerId"] ?? "Unknown", // 🔗 Connect via sellerId
  //     description: json["description"] ?? "No description available",
  //     category: json["category"] ?? "Uncategorized",
  //     brand: json["brand"] ?? "Unknown Brand",
  //   );
  // }
}


class ProductData {
  static final List<Seller> sellers = [
    Seller(
      sellerId: "S001",
      sellerName: "Trendy Store",
      sellerImage: "assets/imgs/seller.jpg",
      rating: "4.5",
      contactInfo: "Contact via Line: @trendystore",
    ),
    Seller(
      sellerId: "S002",
      sellerName: "Boho Chic",
      sellerImage: "assets/imgs/seller.jpg",
      rating: "4.7",
      contactInfo: "Contact via Instagram: @bohochic",
    ),
  ];

  static final List<Product> products = [
    Product(
      productId: "P001",
      imagePath: "assets/imgs/brand/price-home/3.png",
      productName: "Floral Dress",
      price: "\450",
      sRentprice: "\100",
      lRentprice: "\200",
      sellerId: "S001", // 🔗 Connect to Seller
      description: "A beautiful floral dress perfect for summer.",
      category: "Dresses",
      qualityStatus: 'Good',
      brand: "Fashion Co.",
    ),
    Product(
      productId: "P002",
      imagePath: "assets/imgs/brand/price-home/3.png",
      productName: "Boho Top",
      price: "\300",
      sellerId: "S002", // 🔗 Connect to Seller
      description: "A stylish boho top made from organic cotton.",
      category: "Tops",
      qualityStatus: 'มีตำหนิ',
      brand: "Bohemian Trends",
    ),
  ];
}
