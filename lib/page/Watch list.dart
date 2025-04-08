import 'package:flutter/material.dart';
import 'package:twindle_app/page/Favorites%20Manager.dart';
import 'package:twindle_app/services/favorite_manager.dart';
import 'package:twindle_app/page/ProductDetail.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Trigger rebuild เพื่อดึงข้อมูลล่าสุด
    Future.microtask(() => (context as Element).markNeedsBuild());

    // ✅ ดึงรายการ favorite
    final favorites =
        List<Map<String, dynamic>>.from(FavoriteManager().favorites);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Watch list",
          style: TextStyle(fontFamily: 'Kanit'),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF1E4FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                "ไม่มีสินค้าในรายการโปรด",
                style: TextStyle(fontFamily: 'Kanit'),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final Product product = favorites[index]['product'];
                final Seller seller = favorites[index]['seller'];

                return ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: product.imagePath.startsWith("http")
                        ? Image.network(
                            product.imagePath,
                            width: 75,
                            height: 65,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            product.imagePath,
                            width: 75,
                            height: 65,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: Text(
                    product.productName,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '฿${product.price}  ·  ${seller.username}',
                    style: TextStyle(fontFamily: 'Kanit'),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      FavoriteManager().removeFavorite(product);
                      (context as Element).markNeedsBuild(); // รีเฟรชหน้านี้
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          product: product,
                          seller: seller,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
