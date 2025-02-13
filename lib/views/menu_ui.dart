import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuUI extends StatefulWidget {
  const MenuUI({super.key});

  @override
  State<MenuUI> createState() => _MenuUIState();
}

class _MenuUIState extends State<MenuUI> {
  //สร้างตัวแปรเก็บรูปเมนูที่จะแสดงที่ ListView
  List<String> menuShow = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
    'assets/images/img6.png',
    'assets/images/img7.png',
  ];

  //สร้างตัวแปรเก็บรูปร้านสาขาที่จะแสดงที่ ListView
  List<String> branchShop = [
    'assets/images/shop1.png',
    'assets/images/shop2.png',
    'assets/images/shop3.png',
    'assets/images/shop4.png',
    'assets/images/shop5.png',
  ];

  //สร้างตัวแปรเก็บตำแหน่งร้านบน GOOGLE MAP
  List<String> shoplocation = [
    'https://www.google.co.th/maps/@17.4853032,78.389975,16z',
    'https://www.google.co.th/maps/@17.453859,78.4240065,14.25z',
    'https://www.google.co.th/maps/@17.4360468,78.4640511,14.25z',
    'https://www.google.co.th/maps/@17.3409989,78.4907183,14.25z',
    'https://www.google.co.th/maps/@17.3258672,78.4585822,14.25',
  ];
  //เ

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 24.0,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 180.0,
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'เมนูเด็ด',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 100.0,
              margin: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menuShow.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        menuShow[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ร้านในเครือ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: branchShop.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 15.0,
                    ),
                    child: InkWell(
                      onTap: (){
                        _launchInBrowser(
                          Uri.parse(shoplocation[index]),
                        );
                      },
                      child: Image.asset(
                        branchShop[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
