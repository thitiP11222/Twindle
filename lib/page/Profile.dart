import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';
import 'package:twindle_app/page/Badge.dart';
import 'package:twindle_app/page/Chat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twindle_app/config.dart';
import 'package:twindle_app/page/ProductDetail.dart';

class ProfilePage extends StatefulWidget {
  final Product? product;
  final Seller seller;
  const ProfilePage({super.key, this.product, required this.seller});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Product>> futureProducts;
  List<Map<String, dynamic>> reviews = [];
  @override
  void initState() {
    super.initState();
    futureProducts = fetchSellerProducts(widget.seller.user_id);
    fetchReviews();
  }

  Future<List<Product>> fetchSellerProducts(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/seller_products/$userId'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<void> fetchReviews() async {
    final response =
        await http.get(Uri.parse('$baseUrl/reviews/${widget.seller.user_id}'));
    if (response.statusCode == 200) {
      setState(() {
        reviews = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print("Failed to load reviews");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Kanit'),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back Button-

                    SizedBox(height: 22),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    ),
                    SizedBox(height: 20),

                    // 🏆 Profile Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                              widget.seller.profile_pic), // ใส่รูปจริง
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.seller.username,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(
                                '${widget.seller.fname} ${widget.seller.lname}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            SizedBox(height: 4),
                            Row(children: [
                              Text('Rate: '),
                              Text('${widget.seller.rating}'),
                              Icon(Icons.star, color: Colors.amber, size: 18),
                            ]),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Chat(seller: widget.seller),
                                  ),
                                );
                              },
                              child: Icon(Icons.chat,
                                  color: Colors.green, size: 26),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 8, 0, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                              child: Text("Follow",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    // 🏷 Badges (อยู่ใต้รูปโปรไฟล์)
                    buildBadges(widget.seller, context),

                    SizedBox(height: 18),

                    // 📩 Description
                    Text(
                      widget.seller.bio,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),

                    SizedBox(height: 18),

                    // 📌 Contact Information
                    Text("ข้อมูลติดต่อร้านค้า",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(widget.seller.phone),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.email, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(widget.seller.email),
                      ],
                    ),

                    SizedBox(height: 20),
                    // 🌟 รีวิวร้านค้า
                    Text("รีวิวร้านค้า",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Divider(thickness: 1, color: Colors.grey.shade300),

                    Column(
                    children: reviews.map((review) {
                      final rating = review['rating'] ?? 0.0;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(radius: 20, backgroundColor: Colors.grey.shade300),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review['reviewer_name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Row(
                                    children: List.generate(5, (index) {
                                      if (index < rating.floor()) {
                                        return Icon(Icons.star, color: Colors.amber, size: 16);
                                      } else if (index < rating && rating - index >= 0.5) {
                                        return Icon(Icons.star_half, color: Colors.amber, size: 16);
                                      } else {
                                        return Icon(Icons.star_border, color: Colors.grey, size: 16);
                                      }
                                    }),
                                  ),
                                  SizedBox(height: 4),
                                  Text(review['review_text'] ?? '', style: TextStyle(fontSize: 12, color: Colors.black87)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                    SizedBox(height: 15),
                    Divider(thickness: 1, color: Colors.grey.shade300),

                    // 🛍 Post Section
                    Text("Post",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),

                    SizedBox(height: 10),

                    FutureBuilder<List<Product>>(
                      future: futureProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("เกิดข้อผิดพลาด: ${snapshot.error}"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text("ยังไม่มีสินค้าจากผู้ขายนี้"));
                        } else {
                          final sellerProducts = snapshot.data!;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: sellerProducts.length,
                            itemBuilder: (context, index) {
                              final product = sellerProducts[index];
                              return GestureDetector(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          seller: widget.seller,
                        ),
                      ),
                    );
                  },child: PostCard(product),);
                              
                            },
                          );
                        }
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Column PostCard(Product product) {
    return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: product.imagePath
                                              .startsWith("http")
                                          ? NetworkImage(product.imagePath)
                                          : AssetImage(product.imagePath)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  product.productName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "฿${product.price}",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(
                                  widget.seller.username,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            );
  }

  Widget buildBadges(Seller seller, BuildContext context) {
    List<Widget> badges = [];
    final badgeRaw = seller.badges.join(", ").toLowerCase();

    if (badgeRaw.contains("trusted") || badgeRaw.contains("safe")) {
      badges.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BadgeScreen()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 231, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/imgs/award_star.png', width: 15),
                SizedBox(width: 6),
                Text("Trusted Treasure",
                    style: TextStyle(
                      color: Color(0xFF7B00FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
      );
    }

    if (badgeRaw.contains("clean") ||
        badgeRaw.contains("fresh") ||
        badgeRaw.contains("hygiene")) {
      badges.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BadgeScreen()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 255, 241),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/imgs/sanitizer (3).png', width: 15),
                SizedBox(width: 6),
                Text("Deep Clean Master",
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 153, 101),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
      );
    }

    List<Widget> badgeWidgets =
        badges.expand((widget) => [widget, SizedBox(width: 12)]).toList();

    if (badgeWidgets.isNotEmpty) {
      badgeWidgets.removeLast();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: badgeWidgets,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Kanit'),
  ));
}
