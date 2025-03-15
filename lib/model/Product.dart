class Product {
  final String imagePath;
  final String productName;
  final String price;
  final String sellerName;
  final String description;
  final String category;
  String? brand; // Optional field

  Product({
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.sellerName,
    required this.description,
    required this.category,
    this.brand,
  });

  // ✅ Fix: Ensure `description`, `category`, and `brand` are included
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json["imagePath"] ?? "assets/imgs/default.png",
      productName: json["productName"] ?? "No Name",
      price: json["price"] ?? "N/A",
      sellerName: json["sellerName"] ?? "Unknown",
      description: json["description"] ?? "No description available",
      category: json["category"] ?? "Uncategorized",
      brand: json["brand"] ?? "Unknown Brand",
    );
  }
}

class ProductData {
  static final List<Product> products = [
    Product(
      imagePath: "assets/imgs/brand/price-home/3.png",
      productName: "Floral Dress",
      price: "\$45",
      sellerName: "Trendy Store",
      description: "A beautiful floral dress perfect for summer.",
      category: "Dresses",
      brand: "Fashion Co.",
    ),
    Product(
      imagePath: "assets/imgs/brand/price-home/3.png",
      productName: "Boho Top",
      price: "\$30",
      sellerName: "Boho Chic",
      description: "A stylish boho top made from organic cotton.",
      category: "Tops",
      brand: "Bohemian Trends",
    ),
    Product(
      imagePath: "assets/imgs/brand/price-home/3.png",
      productName: "Checkered Blazer",
      price: "\$600",
      sellerName: "Formal Wear",
      description: "A premium checkered blazer for professional events.",
      category: "Blazers",
      brand: "Elite Suits",
    ),
  ];
}
