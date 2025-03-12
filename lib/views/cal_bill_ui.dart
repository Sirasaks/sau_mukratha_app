import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'show_bill_ui.dart';  // เพิ่มการนำเข้า ShowBillUI

class CalBillUI extends StatefulWidget {
  const CalBillUI({super.key});

  @override
  State<CalBillUI> createState() => _CalBillUIState();
}

class _CalBillUIState extends State<CalBillUI> {
  bool adultCheck = false;
  bool childCheck = false;

  // ตัวควบคุม TextField
  TextEditingController adultCtrl = TextEditingController(text: '0');
  TextEditingController childCtrl = TextEditingController(text: '0');
  TextEditingController cokeCtrl = TextEditingController(text: '0');
  TextEditingController pureCtrl = TextEditingController(text: '0');

  // ตัวแปรเพื่อใช้กับน้ำดื่ม
  int waterCheck = 1;

  // ตัวแปรเก็บรูปที่ถ่าย
  File? imgFile;

  // ตัวแปรเก็บประเภทสมาชิก
  List<String> memberType = [
    'ไม่เป็นสมาชิก',
    'สมาชิกทั่วไป 5%',
    'สมาชิก VIP 20%',
  ];

  // ตัวแปรเก็บส่วนลดที่เลือกจากประเภทสมาชิก
  double discount = 0;

  // ตัวแปรเก็บผลลัพธ์การคำนวณ
  double totalAmount = 0;

  // เมธอดคำนวณค่าใช้จ่ายทั้งหมด
  void calculateTotal() {
    double adultPrice = 299; // ราคาผู้ใหญ่
    double childPrice = 69; // ราคาสำหรับเด็ก
    double waterPrice = 25; // ราคาน้ำดื่ม
    double cokePrice = 20; // ราคาโค้ก
    double purePrice = 15; // ราคาน้ำเปล่า

    // ตรวจสอบว่าผู้ใช้กรอกค่าหรือไม่
    double adults = double.tryParse(adultCtrl.text) ?? 0;
    double children = double.tryParse(childCtrl.text) ?? 0;
    double coke = double.tryParse(cokeCtrl.text) ?? 0;
    double pure = double.tryParse(pureCtrl.text) ?? 0;

    // หากไม่มีการกรอกข้อมูลที่จำเป็น ให้แสดงการแจ้งเตือน
    if ((adultCheck && adults <= 0) && (childCheck && children <= 0) && (waterCheck == 1 && (coke <= 0 && pure <= 0))) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ข้อผิดพลาด"),
            content: Text("กรุณากรอกข้อมูลเพื่อคำนวณ!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("ตกลง"),
              ),
            ],
          );
        },
      );
      return;
    }

    double subtotal = 0;

    // คำนวณค่าใช้จ่ายตามจำนวนที่กรอก
    if (adultCheck) {
      subtotal += adults * adultPrice;
    }
    if (childCheck) {
      subtotal += children * childPrice;
    }
    if (waterCheck == 1) {
      subtotal += (adults + children) * waterPrice;
    }
    subtotal += coke * cokePrice;
    subtotal += pure * purePrice;

    // คำนวณส่วนลด
    double discountAmount = subtotal * discount;

    // คำนวณยอดสุทธิ
    setState(() {
      totalAmount = subtotal - discountAmount;
    });

    // ไปยังหน้า ShowBillUI พร้อมส่งข้อมูลทั้งหมดไป
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowBillUI(
          totalAmount: totalAmount,
          imgFile: imgFile,
          adults: adults.toInt(),
          children: children.toInt(),
          discount: discount,
        ),
      ),
    );
  }

  // เมธอดเปิดกล้องเพื่อถ่ายรูป
  Future<void> openCamera() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.camera, //ImageSource.gallery
      imageQuality: 75,
    );
    if (picker == null) return;
    setState(() {
      imgFile = File(picker.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 35.0, right: 35.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50.0),
                InkWell(
                  onTap: openCamera,
                  child: imgFile == null
                      ? Image.asset('assets/images/camera.jpg', height: 120.0)
                      : Image.file(imgFile!, height: 120.0),
                ),
                SizedBox(height: 35.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนคน',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (valueParam) {
                        setState(() {
                          adultCheck = valueParam!;
                          if (!valueParam) {
                            adultCtrl.text = '0';
                          }
                        });
                      },
                      value: adultCheck,
                    ),
                    Text('ผู้ใหญ่ 299 บาท/คน จำนวน  '),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enabled: adultCheck,
                        controller: adultCtrl,
                      ),
                    ),
                    Text('  คน'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (valueParam) {
                        setState(() {
                          childCheck = valueParam!;
                          if (!valueParam) {
                            childCtrl.text = '0';
                          }
                        });
                      },
                      value: childCheck,
                    ),
                    Text('เด็ก 69 บาท/คน จำนวน  '),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enabled: childCheck,
                        controller: childCtrl,
                      ),
                    ),
                    Text('  คน'),
                  ],
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'บุปเฟต์น้ำดื่ม',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      onChanged: (valueParam) {
                        setState(() {
                          waterCheck = valueParam!;
                          if (waterCheck == 1) {
                            cokeCtrl.text = '0';
                            pureCtrl.text = '0';
                          }
                        });
                      },
                      value: 1,
                      groupValue: waterCheck,
                    ),
                    Text('รับ 25 บาท/หัว'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      onChanged: (valueParam) {
                        setState(() {
                          waterCheck = valueParam!;
                        });
                      },
                      value: 2,
                      groupValue: waterCheck,
                    ),
                    Text('ไม่รับ'),
                  ],
                ),
                Row(
                  children: [
                    Text('              โค้ก 20 บาท/ขวด จำนวน  '),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enabled: waterCheck == 1 ? false : true,
                        controller: cokeCtrl,
                      ),
                    ),
                    Text('  ขวด'),
                  ],
                ),
                Row(
                  children: [
                    Text('              น้ำเปล่า 15 บาท/ขวด จำนวน  '),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enabled: waterCheck == 1 ? false : true,
                        controller: pureCtrl,
                      ),
                    ),
                    Text('  ขวด'),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ประเภทสมาชิก',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                DropdownButton<double>(
                  value: discount,  // ตั้งค่า value ให้ตรงกับตัวแปร discount
                  isExpanded: true,
                  items: memberType
                      .map(
                        (e) => DropdownMenuItem<double>(
                          child: Text(
                            e,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          value: memberType.indexOf(e) == 0
                              ? 0.0
                              : (memberType.indexOf(e) == 1
                                  ? 0.05
                                  : 0.2),  // กำหนดค่า discount ให้ตรงกับค่าที่เลือก
                        ),
                      )
                      .toList(),
                  onChanged: (valueParam) {
                    setState(() {
                      discount = valueParam!;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: calculateTotal, // เรียกใช้งานฟังก์ชันคำนวณ
                        icon: Icon(Icons.calculate),
                        label: Text('คำนวณเงิน'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
