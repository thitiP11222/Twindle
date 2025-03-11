import 'package:flutter/material.dart';

void main() {
  runApp(const Condition());
}

class Condition extends StatelessWidget {
  const Condition({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Kanit', // Set the global font
        ),
        debugShowCheckedModeBanner: false,
        title: 'Condition',
        home: Scaffold(
          body: ListView(
            children: [
              Container(
                color: Color.fromARGB(255, 198, 255, 235),
                padding: EdgeInsets.only(top: 40, bottom: 30),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'เงื่อนไขและนโยบายการเช่า',
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  trailing: Icon(Icons.clear),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. การจองและการติดต่อ'),
                    bulletedText(
                        "ผู้เช่าต้องส่งรายละเอียดการจองให้ผู้ปล่อยเช่าผ่านทางแชทของแอป"),
                    bulletedText(
                        "ผู้ปล่อยเช่าจะทำการติดต่อกลับผ่านระบบแชทของแอปภายใน 1 วัน หลังจากได้รับคำขอจอง"),
                    bulletedText(
                        "หากผู้ปล่อยเช่าไม่ตอบกลับภายในเวลาที่กำหนด คำขอจองถูกยกเลิกโดยอัตโนมัติ"),
                        SizedBox(height: 10,),
                    Text('2. ระยะเวลาการเช่า'),
                    bulletedText('ระยะเวลาการเช่าจะเริ่มนับตั้งแต่วันที่พัสดุถึงปลายทางของผู้เช่า (อ้างอิงจากข้อมูลการจัดส่งของบริษัทขนส่ง)'),
                    bulletedText('ผู้เช่าต้องคืนชุดภายในเวลาที่ตกลงกัน มิฉะนั้น อาจมีค่าปรับตามอัตราที่กำหนด'),
                    SizedBox(height: 10,),
                    Text('3. การรับและคืนชุด'),
                    bulletedText('ผู้เช่าต้องตรวจสอบชุดทันทีหลังได้รับ หากพบปัญหา เช่น เสียหายหรือไม่ตรงกับที่จอง ต้องแจ้งผู้ปล่อยเช่าผ่านแอปภายใน 24 ชั่วโมง'),
                    bulletedText('ชุดต้องถูกส่งคืนใน สภาพที่สะอาดและอยู่ในสภาพดี หากมีความเสียหาย ผู้เช่าอาจต้องรับผิดชอบค่าใช้จ่ายในการซ่อมแซม'),
                    SizedBox(height: 10,),
                    Text('3. การรับและคืนชุด'),
                    bulletedText('ผู้เช่าต้องตรวจสอบชุดทันทีหลังได้รับ หากพบปัญหา เช่น เสียหายหรือไม่ตรงกับที่จอง ต้องแจ้งผู้ปล่อยเช่าผ่านแอปภายใน 24 ชั่วโมง'),
                    bulletedText('ชุดต้องถูกส่งคืนใน สภาพที่สะอาดและอยู่ในสภาพดี หากมีความเสียหาย ผู้เช่าอาจต้องรับผิดชอบค่าใช้จ่ายในการซ่อมแซม'),
                    SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget bulletedText(String text) {
  return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 12)),
          ),
        ],
      ));
}
