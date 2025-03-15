import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart'; // Import Product Model
import 'package:twindle_app/widget/ProductCard.dart'; // Import ProductCard

class ProductList extends StatelessWidget {
  final List<Product> products = ProductData.products;
  

  ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225, // Adjust to fit the card size
      child: products.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]); // Pass Product Object
              },
            )
          : Center(child: Text("No Products Available")),
    );
  }
}
