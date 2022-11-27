import 'package:flutter/material.dart';
import 'package:capstone_design_flutter/src/page/home/home.dart';
import 'package:capstone_design_flutter/src/page/report/report.dart';
import 'package:capstone_design_flutter/src/page/test/test.dart';
import 'package:capstone_design_flutter/src/page/mypage/mypage.dart';
import 'package:capstone_design_flutter/src/page/test2/MainPage.dart';
import 'package:capstone_design_flutter/src/page/test2/ChatPage.dart';
import 'package:capstone_design_flutter/src/provider/provider_count.dart';
import 'package:provider/provider.dart';

void main() => runApp(Test());

class Test extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: MyApp(),
        ));
  }
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
    ChatPage()
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
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
                    icon: Icon(Icons.restaurant), label: '홈'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart_rounded), label: '리포트'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity_rounded), label: '마이페이지'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity_rounded), label: '블루투스 통신'),
              ],
            ),
            body: _widgetOptions[_selectedIndex]),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
