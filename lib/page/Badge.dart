import 'package:flutter/material.dart';

void main() {
  runApp(const BadgeApp());
}

class BadgeApp extends StatelessWidget {
  const BadgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
      ),
      home: const BadgeScreen(),
    );
  }
}

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ListView ที่สามารถเลื่อนได้
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 50), // เพิ่มพื้นที่ให้ปุ่ม Back

                  // รูปภาพหลัก
                  Center(
                    child: Image.asset(
                      'assets/imgs/editor_choice.png',
                      height: 50,
                    ),
                  ),

                  // หัวข้อหลัก
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'แต้มบุญนักขาย & \nตราสะอาดสุด Cute!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                  ),

                  // คำอธิบาย
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'มั่นใจทุกการช้อป! ที่นี่เรามี ระบบ Badge สุดพิเศษ\n'
                      'ที่ช่วยให้คุณรู้ว่าแต่ละร้านมีมาตรฐานขนาดไหน',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),

                  // หัวข้อ Trust Badges
                  const SectionTitle(
                      title: 'Trust Badges – การันตีร้านค้าสุดปัง'),

                  // Badge Cards
                  BadgeCard(
                    iconPath: 'assets/imgs/Group 46.png',
                    title: 'Trusted Treasure – “ขุมทรัพย์นักช้อป”',
                    description:
                        'มีออเดอร์สำเร็จ มากกว่า 100 ออเดอร์\nความพึงพอใจของลูกค้า 4.5 ดาวขึ้นไป',
                    borderColor: Color.fromARGB(255, 123, 0, 255),
                  ),
                  BadgeCard(
                    iconPath: 'assets/imgs/Group 46.png',
                    title: 'Safe & Sound – “ปลอดภัยหายห่วง”',
                    description: 'ไม่เคยได้รับรีวิวเกี่ยวกับ ของปลอม/ไม่ตรงปก\n'
                        'ร้านต้องมีรีวิว 5 ดาวจากลูกค้าอย่างน้อย 50 คน',
                    borderColor: Color.fromARGB(255, 123, 0, 255),
                  ),

                  // หัวข้อ Hygiene Badges
                  const SectionTitle(
                      title: 'Hygiene Badges – การันตีความสะอาดเสื้อผ้า'),

                  BadgeCard(
                    iconPath: 'assets/imgs/Group 56.png',
                    title: 'Fresh & Clean – “หอมฟุ้ง พร้อมใส่”',
                    description: 'เสื้อผ้าทุกชิ้นต้อง ผ่านการซักก่อนส่ง\n'
                        'ผู้ขายต้อง อัปโหลดหลักฐานการซัก (รูป / วิดีโอ)อย่างน้อย 5 ครั้ง',
                    borderColor: Color.fromARGB(255, 4, 153, 101),
                  ),
                  BadgeCard(
                    iconPath: 'assets/imgs/Group 56.png',
                    title: 'Hygiene Hero – “สะอาดไร้กังวล”',
                    description:
                        'มีรีวิว 5 ดาวเกี่ยวกับความสะอาดมากกว่า 30 รีวิว\n'
                        'เสื้อผ้าผ่าน การอบฆ่าเชื้อ UV / ซักน้ำร้อน 60°C',
                    borderColor: Color.fromARGB(255, 4, 153, 101),
                  ),
                  BadgeCard(
                    iconPath: 'assets/imgs/Group 56.png',
                    title: 'Deep Clean Master – “ซักแล้ว รีดแล้ว!”',
                    description: 'เสื้อผ้าทุกตัว ซัก + รีด พร้อมใส\n'
                        'มีแพ็คเกจป้องกันฝุ่นก่อนจัดส่ง',
                    borderColor: Color.fromARGB(255, 4, 153, 101),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            //ปุ่ม Back ตรึงอยู่ด้านบนซ้าย
            Positioned(
              top: 10,
              left: 10,
              child:
                  const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Widget แสดงหัวข้อหลัก (Section Title)
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
    );
  }
}

// 🔹 Widget แสดงแต่ละ Badge Card
class BadgeCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final Color borderColor;

  const BadgeCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // ไอคอน Badge
            Column(
              children: [
                Image.asset(
                  iconPath,
                  height: 50,
                ),
                const SizedBox(height: 5),
              ],
            ),

            const SizedBox(width: 12), // ระยะห่าง

            // ข้อความ
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
