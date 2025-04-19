import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twindle_app/services/api_service.dart'; // <--- import login function
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  // Controll Login
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    checkSession(); //  ตรวจสอบ session ตอนเปิดแอป
    // ควบคุม animation เด้งขึ้นลง
    _controller = AnimationController(
      vsync: this, // ต้องการ TickerProvider
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: const Offset(0, -0.02),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  @override
  void dispose() {
    _controller.dispose(); // ปล่อย controller เมื่อเลิกใช้
    super.dispose();
  }

  Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("email");
    final fname = prefs.getString("fname");
    final lname = prefs.getString("lname");
    final user_id = prefs.getString("user_id");
    final profile_pic = prefs.getString("profile_pic");

    if (email != null && fname != null && user_id != null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'email': email,
        'fname': fname,
        'user_id': user_id,
        'lname': lname,
        'profile_pic': profile_pic
      });
      print(
          '>>> fname: $fname, lname: $lname, email: $email, profile_pic: $profile_pic');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 208, 164, 255),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80),
              color: Color.fromARGB(255, 208, 164, 255),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/imgs/td_logo.png',
                      height: 100,
                    ),
                  ),
                  Center(
                    child: SlideTransition(
                      position: _animation,
                      child: Container(
                        child: Image.asset(
                          'assets/imgs/login-1.png',
                          height: 280,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 50),
                    child: Text(
                      'Join Us!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300, // Set desired width
                    height: 35, // Set desired height
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 300,
                    height: 35,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 130, vertical: 12),
                    ),
                    //to Future<void> login()
                    onPressed: () {
                      login(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member ? ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
