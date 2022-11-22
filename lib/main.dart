import 'package:flutter/material.dart';
import 'package:capstone_design_flutter/page/home/home.dart';
import 'package:capstone_design_flutter/page/report/report.dart';
import 'package:capstone_design_flutter/page/test/test.dart';
import 'package:capstone_design_flutter/page/mypage/mypage.dart';
import 'package:capstone_design_flutter/page/test2/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    report_page(),
    Mypage(),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_outlined), label: '홈'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_outlined), label: '리포트'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_outlined), label: '마이페이지'),
            ],
          ),
          body: _widgetOptions[_selectedIndex]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
