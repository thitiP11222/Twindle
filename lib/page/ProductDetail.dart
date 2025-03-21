import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/page/condition.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Seller seller;
  const ProductDetailPage(
      {Key? key, required this.product, required this.seller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
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
              Image.asset(product.imagePath,
                  width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ราคาขาย: ${product.price} บาท",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                        Text(
                          "ราคาเช่า: ${product.sRentprice ?? "N/A"} บาท",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                    Text(
                      "*ค่าจัดส่งไปรษณีย์ 50 ฿ ( 1-3 วัน)",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    // ✅ Show Seller Details
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Top border
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8), // Optional padding
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: AssetImage(seller.sellerImage),
                            radius: 20,
                          ),

                        title: Text(
                                seller.sellerName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        subtitle: Text(
                                "Rating: ${seller.rating}",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            trailing: TextButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios,color: Colors.purple,),),
                        // children: [
                        //   CircleAvatar(
                        //     backgroundImage: AssetImage(seller.sellerImage),
                        //     radius: 20,
                        //   ),
                        //   SizedBox(width: 10),
                        //   Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         seller.sellerName,
                        //         style: TextStyle(
                        //             fontSize: 16, fontWeight: FontWeight.bold),
                        //       ),
                        //       Text(
                        //         "Rating: ${seller.rating}",
                        //         style:
                        //             TextStyle(fontSize: 14, color: Colors.grey),
                        //       ),
                        //     ],
                        //   ),
                        // ],
                      ),
                    ),

                    // Text(product.description, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for the button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFE7D7FB), // Light purple color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              "ติดต่อร้านค้า",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0FBF3), // Light greenish color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.favorite_border, // Heart icon
                            color: Colors.green,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      "รายละเอียดสินค้า",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(product.description),
                    SizedBox(height: 25),
                    //Rent
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5), // เพิ่มพื้นที่รอบเนื้อหา
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: const Color.fromARGB(138, 158, 158, 158),
                            width: 0.4,
                          ), // Top border
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'เช่า',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${product.sRentprice ?? "N/A"} /3 วัน",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${product.lRentprice ?? "N/A"} /5 วัน",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //Categorie
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5), // เพิ่มพื้นที่รอบเนื้อหา
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'หมวดหมู่',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${product.category}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //Brand
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5), // เพิ่มพื้นที่รอบเนื้อหา
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'แบรนด์',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${product.brand}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //qualityStatus
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5), // เพิ่มพื้นที่รอบเนื้อหา
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สภาพสินค้า',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${product.qualityStatus}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //Condition
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5), // เพิ่มพื้นที่รอบเนื้อหา
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(138, 158, 158, 158),
                              width: 0.4), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'เงื่อนไข',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Condition()), // ไปยังหน้าถัดไป
                                  );
                                },
                                child: Text(
                                  "อ่านเงื่อนไข/นโยบายการเช่า",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
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
