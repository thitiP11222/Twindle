import 'package:flutter/material.dart';

void main() {
  runApp(Badge());
}

class Badge extends StatelessWidget {
  const Badge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Kanit', // Set the global font
        ),
        home: Scaffold(
          body: Container(
           child: Image.asset('assets/imgs/editor_choice.png')
          ),
        ),
    );
  }
}
