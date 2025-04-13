import 'package:flutter/material.dart';
import 'package:twindle_app/services/api_service.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/page/ProductDetail.dart';
import 'package:twindle_app/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> _products = Future.value([]);
  List<Seller> _sellers = [];

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
  final result = await fetchProductAndSellerData();
  // แปลง dynamic → Seller
  _sellers = List<Seller>.from(result['sellers']);

  return result['products']; // ✅ products เป็น List<Product> แล้ว
}

  Seller? getSellerById(String sellerId) {
    return _sellers.firstWhere(
      (seller) => seller.user_id == sellerId,
      orElse: () => Seller(
        user_id: sellerId,
        username: "Unknown",
        profile_pic: "assets/imgs/default_seller.png",
        rating: "0",
        bio: "-",
        phone: 'no info',
        email: 'no info',
        fname: '-',
        lname: '-',
        badges: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Products Available"));
        } else {
          final products = snapshot.data!;

          return SizedBox(
            height: 225,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final seller = getSellerById(product.sellerId);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          seller: seller!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: product.imagePath.startsWith('assets')
                                ? Image.asset(
                                    product.imagePath,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                                  )
                                : Image.network(
                                    product.imagePath,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontFamily: 'Kanit'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "฿${product.price}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontFamily: 'Kanit'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
