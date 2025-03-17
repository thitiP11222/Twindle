import 'package:flutter/material.dart';

class EcoImpact extends StatelessWidget {
  const EcoImpact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 198, 255, 235),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 35,
                right: 25,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear_sharp,
                    size: 30,
                    color: Color.fromARGB(255, 208, 164, 255),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imgs/Look Good 1.png',
                    ),
                    const SizedBox(height: 10),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'การหมุนเวียนสินค้านี้ช่วย',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'ลดผลกระทบ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '\nในการใช้ทรัพยากรเพื่อผลิตใหม่เทียบเท่า',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    _impactCard(Icons.water_drop, 'น้ำ 7,500 ลิตร'),
                    const SizedBox(height: 10),
                    _impactCard(Icons.cloud, 'CO₂ 30 กิโลกรัม!', iconColor: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _impactCard(IconData icon, String text, {Color iconColor = Colors.blue}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
