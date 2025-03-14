import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/widget/ProductCard.dart';

class SearchResult extends StatelessWidget {
  final List<Product> products = ProductData.products;
  SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Kanit', // Set the global font
        ),
        title: 'Search Result',
        home: Scaffold(
          backgroundColor: Colors.white, // ✅ Set white background

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
                  leading: IconButton(onPressed:  (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
                  trailing: Icon(Icons.search),
                ),
              ),
              Container(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: products.isNotEmpty
      ? GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Parent scrolls
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,//ความยาวพทของcard
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        )
      : Center(child: Text("No Products Available")),
),

            ],
          ),
        ));
  }
}
