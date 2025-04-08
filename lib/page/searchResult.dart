import 'package:flutter/material.dart';
import 'package:twindle_app/config.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/services/api_service.dart';
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
  List<Seller> _sellers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
  final result = await fetchProductAndSellerData();
  print("✅ Products: ${result['products'].length}, Sellers: ${result['sellers'].length}");
  setState(() {
    products = result['products'];
    _sellers = result['sellers'];
    isLoading = false;
  });

}


  @override
  Widget build(BuildContext context) {
    // 🔥 Trigger rebuild เพื่อดึงข้อมูลล่าสุด
    Future.microtask(() => (context as Element).markNeedsBuild());

        
final filtered = isLoading
    ? []  // ยังไม่โหลดข้อมูล
    : widget.keyword.trim().isEmpty
        ? products  // <<< ควรแสดงสินค้าทั้งหมด
        : products.where((p) => p.productName
            .toLowerCase()
            .contains(widget.keyword.toLowerCase()))
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
                  ),
                ),
                // ✅ แสดงผล
                Container(
                  margin: EdgeInsets.only(bottom: 20),
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
                            sellers: _sellers,
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
