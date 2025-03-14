import 'package:flutter/material.dart';

void main() {
  runApp(const Post());
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Stack(
            children: [
              Positioned(
                top: 30, // Adjusted for better alignment
                left: 25,
                child: Icon(Icons.arrow_back, size: 30, color: Colors.black),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'สร้างรายการสินค้าใหม่',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'ข้อมูลทั่วไป',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'ชื่อสินค้า*',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300, // Set desired width
                      height: 35, // Set desired height
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ชื่อสินค้า',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'แบรนด์สินค้า*',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300, // Set desired width
                      height: 35, // Set desired height
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'เช่น Zara, Nike, Uniqlo, ไม่ระบุ',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),

                     SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'หมวดหมู่สินค้า',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300, // Set desired width
                      height: 35, // Set desired height
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'เลือกจากหมวดหมู่ เช่น เสื้อผ้า, กระเป๋า, รองเท้า',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
