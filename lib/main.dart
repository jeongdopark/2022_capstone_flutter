import 'package:flutter/material.dart';
import 'package:capstone_design_flutter/src/page/home/home.dart';
import 'package:capstone_design_flutter/src/page/report/report.dart';
import 'package:capstone_design_flutter/src/page/test/test.dart';
import 'package:capstone_design_flutter/src/page/mypage/mypage.dart';
import 'package:capstone_design_flutter/src/page/test2/MainPage.dart';
import 'package:capstone_design_flutter/src/page/test2/ChatPage.dart';
import 'package:capstone_design_flutter/src/provider/provider_count.dart';
import 'package:capstone_design_flutter/src/page/test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:capstone_design_flutter/src/page/profile/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Test());
}

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
    // ChatPage(),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            bottomNavigationBar: Container(
              // margin: EdgeInsets.all(displayWidth * .05),
              height: displayWidth * .155,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: 3, // 네비게이션바 개수
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      HapticFeedback.lightImpact();
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == _selectedIndex
                            ? displayWidth * .32
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height:
                              index == _selectedIndex ? displayWidth * .12 : 0,
                          width:
                              index == _selectedIndex ? displayWidth * .32 : 0,
                          decoration: BoxDecoration(
                            color: index == _selectedIndex
                                ? Colors.blueAccent.withOpacity(.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == _selectedIndex
                            ? displayWidth * .31
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == _selectedIndex
                                      ? displayWidth * .13
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == _selectedIndex ? 1 : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == _selectedIndex
                                        ? '${listOfStrings[index]}'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == _selectedIndex
                                      ? displayWidth * .03
                                      : 20,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: displayWidth * .076,
                                  color: index == _selectedIndex
                                      ? Colors.blueAccent
                                      : Colors.black26,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

List<String> listOfStrings = [
  'Home',
  'Report',
  'Setting',
];

List<IconData> listOfIcons = [
  Icons.restaurant,
  Icons.bar_chart_rounded,
  Icons.settings_rounded,
];
