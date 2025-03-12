import 'package:flutter/material.dart';

void main() {
  runApp(const Badge());
}

class Badge extends StatelessWidget {
  const Badge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Kanit', // ตั้งค่าฟอนต์ของแอป
      ),
      home: Scaffold(
        body: SafeArea(
          // ใช้ SafeArea เพื่อเลี่ยงชนกับ Status Bar
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // จัดให้อยู่ตรงกลางข้างบน
            children: [
              ListTile(
                leading: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              Container(
                  child: Image.asset(
                'assets/imgs/editor_choice.png',
              )),
            ],
          ),
        ),
      ),
    );
  }
}
