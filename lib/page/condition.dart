import 'package:flutter/material.dart';
void main() {
  runApp(const Condition());
}
class Condition extends StatelessWidget {
  const Condition({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Condition',
      home: Scaffold(
        body: Column(
          children: [
            Container( child: Row(
              children: [ Text('เงื่อนไขและนโยบายการเช่า',style: TextStyle(fontFamily: 'Kanit',),)],
            ),)
          ],
        ),
      )
    );
  }
}