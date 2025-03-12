import 'dart:io';
import 'package:flutter/material.dart';

class ShowBillUI extends StatelessWidget {
  final double totalAmount;
  final File? imgFile;
  final int adults;
  final int children;
  final double adultPrice = 299;
  final double childPrice = 69;
  final double waterPrice = 25;
  final double cokePrice = 20;
  final double purePrice = 15;
  final double discount;

  // รับพารามิเตอร์ totalAmount และ imgFile
  ShowBillUI({
    required this.totalAmount,
    required this.imgFile,
    required this.adults,
    required this.children,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;

    // คำนวณ subtotal
    if (adults > 0) {
      subtotal += adults * adultPrice;
    }
    if (children > 0) {
      subtotal += children * childPrice;
    }
    double waterCost = (adults + children) * waterPrice;
    subtotal += waterCost;

    // คำนวณส่วนลด
    double discountAmount = subtotal * discount;
    double finalAmount = subtotal - discountAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text('บิลค่าใช้จ่าย'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // เมื่อกดปุ่มย้อนกลับจะกลับไปที่หน้า CalBillUI
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            imgFile != null
                ? Image.file(imgFile!, height: 120.0)
                : Text('ไม่มีรูปภาพ'),
            SizedBox(height: 20),
            Text(
              'บิลค่าใช้จ่าย',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('จำนวน', style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ราคา/หน่วย', style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ยอดรวม', style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ผู้ใหญ่'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$adults คน'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿$adultPrice'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿${(adults * adultPrice).toStringAsFixed(2)}'),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('เด็ก'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$children คน'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿$childPrice'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿${(children * childPrice).toStringAsFixed(2)}'),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('น้ำดื่ม (สำหรับทุกคน)'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${adults + children} คน'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿$waterPrice'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿${waterCost.toStringAsFixed(2)}'),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ส่วนลด (${discount * 100}%)'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(''),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(''),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('-฿${discountAmount.toStringAsFixed(2)}'),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ยอดรวมทั้งหมด'),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(''),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(''),
                    )),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('฿${finalAmount.toStringAsFixed(2)}'),
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
