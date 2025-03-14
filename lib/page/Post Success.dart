import 'package:flutter/material.dart';

void main() {
  runApp(const Postsuccess());
}

class Postsuccess extends StatelessWidget {
  const Postsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'), // Set the global font
      home: Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 198, 255, 235), // Light green background
        body: SafeArea(
          child: Stack(
            children: [
              // Back Button (Fixed at the Top-Left)
              Positioned(
                top: 30, // Adjusted for better alignment
                left: 25,
                child: Icon(Icons.arrow_back, size: 30, color: Colors.black),
              ),

              // Centered Column for Content
              Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    // Image
                    Image.asset(
                      'assets/imgs/Chracter with price tag head going shopping.png',
                    ),

                    const SizedBox(height: 10), // Space between image and text

                    // Success Text
                    const Text(
                      'Way to go!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 29,
                      ),
                    ),

                    const Text(
                      'อัปโหลดสินค้าสำเร็จแล้ว!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color.fromARGB(255, 120, 120, 120),
                      ),
                    ),

                    const SizedBox(height: 80), // Space before button

                    // Centered Finish Button
                    ElevatedButton(
                      onPressed: () {
                        // Add action here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 224, 195, 255), // Light purple button
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // Adjust height
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: const SizedBox(
                        width: 250, // Ensure button width is centered
                        child: Text(
                          'เสร็จแล้ว !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
