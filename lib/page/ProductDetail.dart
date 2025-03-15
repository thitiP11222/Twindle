import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit'
      ),
      home: Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Product Detail",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.imagePath, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "ราคา: ${product.price} บาท",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "รายละเอียดสินค้า",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  // Text(product.description, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart or contact shop
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 232, 211, 255),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text("ติดต่อร้านค้า", style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
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
