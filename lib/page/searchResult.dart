import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/widget/ProductCard.dart';

class SearchResult extends StatelessWidget {
  final List<Product> products = ProductData.products;
  final List<Seller> sellers = ProductData.sellers;
  final String keyword;

  SearchResult({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    // ✅ กรองสินค้าจาก keyword
    final List<Product> filtered = products
        .where((p) =>
            p.productName.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
      title: 'Search Result',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Result',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                trailing: Icon(Icons.search),
              ),
            ),

            // ✅ แสดงสินค้าที่กรองแล้ว
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: filtered.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          'ไม่พบสินค้าที่ตรงกับ "$keyword"',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
