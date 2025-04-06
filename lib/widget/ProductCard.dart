import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/page/ProductDetail.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<Seller> sellers;

  const ProductCard({Key? key, required this.product, required this.sellers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Seller? seller = sellers.firstWhere(
      (s) => s.user_id == product.sellerId,
      orElse: () => Seller(
        user_id: "default",
        username: "Unknown Seller",
        profile_pic: "static/uploads/default.jpg",
        rating: "0",
        phone: 'no info',
        email: 'no info',
        fname: '-',
        lname: '-',
        bio: "-",
        badges: [],
      ),
    );

    return GestureDetector(
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
        width: 180,
        margin: EdgeInsets.only(right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: product.imagePath.startsWith("http")
                    ? Image.network(product.imagePath,
                        height: 160, width: double.infinity, fit: BoxFit.cover)
                    : Image.asset(product.imagePath,
                        height: 160, width: double.infinity, fit: BoxFit.cover),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.productName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                    Text(
                      seller.username,
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
