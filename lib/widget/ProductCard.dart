import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/page/ProductDetail.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<Seller> sellers;
  const ProductCard({Key? key, required this.product,required this.sellers}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Seller? seller = sellers.firstWhere(
      (s) => s.sellerId == product.sellerId,
      orElse: () => Seller(
        sellerId: "Unknown",
        sellerName: "No Seller Found",
        sellerImage: "assets/imgs/default_seller.png",
        rating: "N/A",
        contactInfo: "No Contact Info",
        badges: []
      ),
    );
    return GestureDetector(
      onTap: () {
        // เมื่อกดที่การ์ด จะนำไปยังหน้ารายละเอียดสินค้า
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product, seller: seller),
          ),
        );
      },
      child: Container(
        width: 180, // กำหนดความกว้างของ Card
        margin: EdgeInsets.only(right: 10), // เว้นระยะห่างระหว่าง Card
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // รูปภาพของสินค้า
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  product.imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // รายละเอียดสินค้า
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // แสดงชื่อสินค้าและราคาแบบ Responsive
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.productName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis, // แสดง ... ถ้ายาวเกิน
                            maxLines: 1, // จำกัดให้แสดงแค่ 1 บรรทัด
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          product.price,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    // ชื่อผู้ขาย
                    Text(
                      seller.sellerName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
