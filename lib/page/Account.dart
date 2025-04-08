import 'package:flutter/material.dart';


class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kanit'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings),
          title: Text('บัญชีของฉัน'),
          backgroundColor: Colors.white,
        ),
        body: Scaffold(
          backgroundColor: Color.fromARGB(255, 242, 242, 242),
        ),
      ),
    );
  }
}
