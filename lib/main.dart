import 'package:flutter/material.dart';
import 'package:twindle_app/page/Account.dart';
import 'package:twindle_app/page/Home.dart';
import 'package:twindle_app/page/Profile.dart';
import 'package:twindle_app/page/login.dart';
import 'package:twindle_app/page/searchResult.dart';
import 'package:twindle_app/page/Post.dart';

void main() {
  runApp(MyApp());
}
String? loggedInUserId;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/home': (context) => MainScreen(),
        '/account': (context) => Account(),
      },
      
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Kanit', // Set the global font
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(email: '',), Post(),HomePage(email: '',),Account()];

  void _onItemTapped(int index) async {
    if (index == 1) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Post()),
      );

      if (result == 0) {
        setState(() {
          _selectedIndex = 0; // กลับไปหน้า Home
        });
      }
    } 
    
    else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

