import 'package:flutter/material.dart';
import 'package:twindle_app/services/api_service.dart';
import 'package:twindle_app/model/Product.dart'; // ✅ เพิ่ม
import 'package:twindle_app/model/Seller.dart';  // ✅ เพิ่ม
import 'package:twindle_app/page/ProductDetail.dart'; // ✅ เพิ่ม

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<dynamic>> _products;
  List<Seller> sellers = []; // ✅ เพิ่ม: mock seller list (ในอนาคตอาจดึงจาก API)

  @override
  void initState() {
    super.initState();
    _products = fetchProducts(); // ✅ ใช้ API โหลดสินค้า
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Products Available"));
        } else {
          final rawProducts = snapshot.data!; // ✅ แก้ชื่อจาก products → rawProducts

          return SizedBox(
            height: 225,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 16),
              itemCount: rawProducts.length,
              itemBuilder: (context, index) {
                final raw = rawProducts[index];
                final product = Product.fromJson(raw); // ✅ แปลง JSON → Product object

                // ✅ เพิ่ม: mock Seller (จริง ๆ ควรดึงจาก API แล้ว map ให้ตรงกับ sellerId)
                final seller = Seller(
                  user_id: product.sellerId,
                  username: "Unknown Seller",
                  profile_pic: "assets/imgs/default_seller.png",
                  rating: "0",
                  bio: "-",
                  badges: [],
                );

                return GestureDetector( // ✅ ย้าย GestureDetector มาอยู่ใน itemBuilder
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          seller: seller,
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
