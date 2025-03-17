class Seller {
  final String sellerId;
  final String sellerName;
  final String sellerImage;
  final String rating;
  final String contactInfo;

  Seller({
    required this.sellerId,
    required this.sellerName,
    required this.sellerImage,
    required this.rating,
    required this.contactInfo,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      sellerId: json["sellerId"] ?? "Unknown",
      sellerName: json["sellerName"] ?? "Unknown Seller",
      sellerImage: json["sellerImage"] ?? "assets/imgs/default_seller.png",
      rating: json["rating"] ?? "No Rating",
      contactInfo: json["contactInfo"] ?? "No Contact Info",
    );
  }
}
