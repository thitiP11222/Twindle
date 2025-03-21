import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';

class Chat extends StatelessWidget {
  final Product product;
  final Seller seller;

  const Chat({Key? key, required this.product, required this.seller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 242, 231, 255),
          leading: TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  // ไปยังหน้าถัดไป
                );
              },
              child: Icon(Icons.arrow_back)),
          title: Text(seller.sellerName),
        ),
        body: Column(
        
        children: [
          Expanded(
            
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Punyawee", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Hello, I am Punyawee"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                
              ],
            ),
          ),
          _productCard(),
          _chatInputField(),
        ],
      ),
      )
    );
  }
}

Widget _productCard() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://via.placeholder.com/100", // แทนที่ด้วย URL ของภาพสินค้า
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zara เสื้อโค้ท",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("ราคาขาย: 950 ฿", style: TextStyle(fontSize: 16)),
                        Text("ราคาเช่า: 3 วัน / 370 ฿", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text("เช่า/จอง", style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text("ซื้อสินค้า", style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
            ],

          ),
        ),
        
      ],
    );
  }


  Widget _chatInputField() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.purple[50],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "เริ่มต้นบทสนทนา . . .",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

