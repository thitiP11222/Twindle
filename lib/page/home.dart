import 'package:flutter/material.dart';
import 'package:twindle_app/page/login.dart';
import 'package:twindle_app/page/searchResult.dart';
import 'package:twindle_app/widget/ProductCard.dart';
import 'package:twindle_app/widget/ProductList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twindle_app/service/api_service.dart';

class HomePage extends StatelessWidget {
  final String email;
  HomePage({required this.email});

  final TextEditingController _searchController =
      TextEditingController(); // 👈 เพิ่ม controller

  @override
  Widget build(BuildContext context) {
    
    // ดึง arguments ที่ส่งมาจาก login()
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final fname = args['fname'];

    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 211, 255),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: ListTile(
                leading: Image.asset('assets/imgs/td_logo.png'),
                trailing: IconButton(onPressed: () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ลบ session
    Navigator.pushReplacementNamed(context, '/'); // กลับหน้า login
  }, icon: Icon(Icons.exit_to_app))

              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 5),
              child: Text(
                'Hello, $fname 👋',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 280, // Set desired width
                    height: 40, // Set desired height
                    child: TextField(
                      controller: _searchController, // 👈 ผูก controller
                      decoration: InputDecoration(
                        hintText: 'Searching...',
                        hintStyle: TextStyle(fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 40.0,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 123, 0, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: IconButton(
                        onPressed: () {
                          String keyword = _searchController.text.trim();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                    keyword: keyword)), // 👈 ส่ง keyword ไป
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Image.asset(
                'assets/imgs/banner-1.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Brand('assets/imgs/brand/b1.png', 'H&M'),
                  Brand('assets/imgs/brand/b2.png', 'POEM'),
                  Brand('assets/imgs/brand/b3.png', 'Gentel\nWomen'),
                  Brand('assets/imgs/brand/b4.png', 'Uniqlo'),
                  Brand('assets/imgs/brand/b5.png', 'Zara'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            shopByPrice_banner(context),
          ],
        ),
      ),
    );
  }

  Container shopByPrice_banner(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Ensures left alignment
        children: [
          Text(
            'Shop By Price',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10), // Adds spacing between text and images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/imgs/brand/price-home/1.png'),
              Image.asset('assets/imgs/brand/price-home/2.png'),
              Image.asset('assets/imgs/brand/price-home/3.png'),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Arrival',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchResult(
                                  keyword:"",
                                )), // Replace with your page
                      );
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(color: Color.fromARGB(255, 123, 0, 255)),
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductList(), // ใส่ไว้ใน Column แทน Row
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Brand(String imgPath, String brandName) {
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 54,
          width: 54,
          child: CircleAvatar(
              backgroundImage: AssetImage(
            imgPath,
          )),
        ),
        Text(brandName)
      ],
    ),
  );
}
