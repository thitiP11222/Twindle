import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/widget/ProductCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  final String keyword;

  SearchResult({super.key, required this.keyword});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Product> products = [];
  List<Seller> sellers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      print("🔍 เริ่มดึงข้อมูลจาก API");

      final productRes =
          await http.get(Uri.parse('http://10.0.2.2:5000/products'));
      print("📦 ผลลัพธ์ products: ${productRes.statusCode}");

      final sellerRes =
          await http.get(Uri.parse('http://10.0.2.2:5000/sellers'));
      print("👤 ผลลัพธ์ sellers: ${sellerRes.statusCode}");

      if (productRes.statusCode == 200) {
        final List<dynamic> productJson = json.decode(productRes.body);
        final List<Product> fetchedProducts =
            productJson.map((p) => Product.fromJson(p)).toList();
        print("✅ โหลดสินค้า ${fetchedProducts.length} ชิ้น");

        final List<Seller> fetchedSellers = sellerRes.statusCode == 200
            ? (json.decode(sellerRes.body) as List)
                .map((s) => Seller.fromJson(s))
                .toList()
            : [
                Seller(
                  user_id: "default",
                  username: "Unknown Seller",
                  profile_pic: "assets/imgs/default_seller.png",
                  rating: "0",
                  bio: "-",
                  badges: [],
                )
              ];

        setState(() {
          products = fetchedProducts;
          sellers = fetchedSellers;
          isLoading = false;
        });
      } else {
        print("❌ โหลดไม่สำเร็จ: ${productRes.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("❌ Exception: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = products
        .where((p) =>
            p.productName.toLowerCase().contains(widget.keyword.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // ✅ Header เหมือนเดิม
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Search Result',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    trailing: Icon(Icons.search),
                  ),
                ),
                // ✅ แสดงผล
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: filtered.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) => ProductCard(
                            product: filtered[index],
                            sellers: sellers,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              'ไม่พบสินค้าที่ตรงกับ "${widget.keyword}"',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
