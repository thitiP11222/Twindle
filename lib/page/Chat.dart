import 'package:flutter/material.dart';
import 'package:twindle_app/model/Product.dart';
import 'package:twindle_app/model/Seller.dart';

class Chat extends StatefulWidget {
  final Product? product;
  final Seller seller;

  const Chat({Key? key,this.product, required this.seller})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();

}

class _ChatState extends State<Chat> {
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add(text.trim());
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 242, 231, 255),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(widget.seller.sellerName, style: TextStyle(color: Colors.black)),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  // ข้อความจากร้านค้า
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.seller.sellerName, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Hello, I am ${widget.seller.sellerName}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // ข้อความที่ผู้ใช้กดส่ง
                  for (String msg in messages)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 198, 255, 235),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(msg),
                      ),
                    ),
                ],
              ),
            ),
            if (widget.product != null)
            _offerBox(),
            _chatInputField(),
          ],
        ),
      ),
    );
  }

  Container _offerBox() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.product!.imagePath,
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product!.productName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("ราคาขาย: 950 ฿", style: TextStyle(fontSize: 16)),
                    Text("ราคาเช่า: 3 วัน / 370 ฿", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => _sendMessage("ฉันต้องการเช่า/จองค่ะ"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("เช่า/จอง",
                                style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _sendMessage("ฉันต้องการซื้อสินค้านี้ค่ะ"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("ซื้อสินค้า",
                                style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chatInputField() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Color.fromARGB(255, 242, 231, 255),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "เริ่มต้นบทสนทนา . . .",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}