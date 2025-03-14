class Product {
  final String imagePath;
  final String productName;
  final String price;
  final String sellerName;

  Product({
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.sellerName,
  });

  // ฟังก์ชันแปลง JSON เป็น Product Model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json["imagePath"] ?? "assets/imgs/default.png",
      productName: json["productName"] ?? "No Name",
      price: json["price"] ?? "N/A",
      sellerName: json["sellerName"] ?? "Unknown",
    );
  }
}
