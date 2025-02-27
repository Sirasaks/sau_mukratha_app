import 'package:flutter/material.dart';

class ShowBillUI extends StatelessWidget {
  // ตัวแปรรับค่า totalAmount จากหน้า CalBillUI
  final double totalAmount;

  // Constructor รับค่า totalAmount
  const ShowBillUI({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บิลค่าใช้จ่าย'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ยอดรวมค่าใช้จ่ายทั้งหมด',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '฿${totalAmount.toStringAsFixed(2)}',  // แสดงผลยอดรวมในรูปแบบที่มี 2 ตำแหน่งทศนิยม
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  // ปิดหน้าจอนี้เมื่อกดปุ่ม
                  Navigator.pop(context);
                },
                child: Text('กลับ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
