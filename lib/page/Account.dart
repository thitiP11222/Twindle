import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twindle_app/services/api_service.dart';

class Account extends StatelessWidget {
  
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    // ดึง arguments ที่ส่งมาจาก login()
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
print("🟢 ARGS RECEIVED: $args");
    final fname = args['fname'];
    final email = args['email'];

    


    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kanit'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('บัญชีของฉัน'),
          backgroundColor: Colors.white,
          actions: [
            Icon(Icons.settings, color: Colors.black),
            SizedBox(width: 16),
          ],
        ),
        backgroundColor: Color(0xFFF2F2F2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Info Card
              Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
  radius: 40,backgroundImage: AssetImage('assets/imgs/profile/setting.jpg'),),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          
                          Text(" $fname",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          Text("$email",style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ],
                  )),
              // Top 3 Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopButton(Icons.inventory, "My orders"),
                    _buildTopButton(Icons.sell, "My sale"),
                    _buildTopButton(Icons.card_giftcard, "My rewards"),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Menu Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  spacing: 1,
                  children: [
                    _buildMenuItem(Icons.person, 'ข้อมูลส่วนตัว'),
                    _buildMenuItem(Icons.inventory, 'ประวัติการสั่งซื้อ'),
                    _buildMenuItem(Icons.location_on, 'ที่อยู่ของฉัน'),
                    _buildMenuItem(Icons.build, 'ฟีดแบค / แนะนำฟีเจอร์ใหม่'),
                    _buildMenuItem(Icons.help_outline, 'ศูนย์ช่วยเหลือ'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  onPressed: () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ลบ session
    Navigator.pushReplacementNamed(context, '/'); // กลับหน้า login
  },
                  child: Center(child: Text("ออกจากระบบ",style: TextStyle(fontSize: 18),)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton(IconData icon, String label) {
    return Container(
      width: 120,
      height: 100,
      padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.purple),
            SizedBox(height: 4),
            Text(label,style: TextStyle(fontSize: 18),),
          ],
        ));
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(label,style: TextStyle(fontSize: 18),),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {}, // Add navigation or logic here
    );
  }
}
