import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back Button-

                SizedBox(height: 22),

                Icon(Icons.arrow_back, size: 30, color: Colors.black),

                SizedBox(height: 20),

                // 🏆 Profile Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/imgs/brand/b4.png'), // ใส่รูปจริง
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Punyawee",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("@Fari_yy",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(height: 4),
                        Row(
                          children: List.generate(
                              5,
                              (index) => Icon(Icons.star,
                                  color: index < 4 ? Colors.amber : Colors.grey,
                                  size: 18)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Icon(Icons.chat, color: Colors.green, size: 26),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 8, 0, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          child: Text("Follow",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // 🏷 Badges (อยู่ใต้รูปโปรไฟล์)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 242, 231, 255), // พื้นหลังสีอ่อน
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // ให้ขนาดพอดีกับเนื้อหา
                        children: [
                          Image.asset(
                            'assets/imgs/award_star.png', // ไอคอนจาก Asset
                            width: 15, // ปรับขนาดไอคอนให้พอดี
                          ),
                          SizedBox(width: 6), // ระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            "Trusted Treasure",
                            style: TextStyle(
                              color: Color(0xFF7B00FF), // สีตัวหนังสือม่วง
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 215, 255, 241), // พื้นหลังสีอ่อน
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // ให้ขนาดพอดีกับเนื้อหา
                        children: [
                          Image.asset(
                            'assets/imgs/sanitizer (3).png', // ไอคอนจาก Asset
                            width: 15, // ปรับขนาดไอคอนให้พอดี
                          ),
                          SizedBox(width: 6), // ระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            "Deep Clean Master",
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 4, 153, 101), // สีตัวหนังสือม่วง
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // 📩 Description
                Text(
                  "เสื้อผ้ามือสอง ราคาน่ารัก งานจริงตรงปก\nสนใจทักส่งได้เลยค่ะ ฝากกดติดตามให้แม่ค้าด้วยนะคะ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),

                SizedBox(height: 18),

                // 📌 Contact Information
                Text("ข้อมูลติดต่อร้านค้า",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.phone, size: 18, color: Colors.grey),
                    SizedBox(width: 5),
                    Text("0952464449"),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.email, size: 18, color: Colors.grey),
                    SizedBox(width: 5),
                    Text("fay09689@gmail.com"),
                  ],
                ),

                SizedBox(height: 20),
                // 🌟 รีวิวร้านค้า
                Text("รีวิวร้านค้า",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Divider(thickness: 1, color: Colors.grey.shade300),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10), // ขยับรูปลง 8px
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // ทำให้เนื้อหาชิดซ้าย
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gummy",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize:
                              MainAxisSize.min, // ให้ขนาดแค่พอดีกับเนื้อหา
                          children: List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: index < 4 ? Colors.amber : Colors.grey,
                                size: 16),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "คุณภาพดี สะดวก แต่นี่รอนานไปนิดหน่อย",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Divider(thickness: 1, color: Colors.grey.shade300),

                // 🛍 Post Section
                Text("Post",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                SizedBox(height: 10),

                // 📷 GridView for Products
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 4, // Placeholder จำนวนสินค้า
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300, // Placeholder image
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("Product Name",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Price", style: TextStyle(color: Colors.blue)),
                        Text("Seller Name",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Kanit'),
    home: ProfilePage(),
  ));
}
