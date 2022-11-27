import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../test2/communication.dart';
import 'package:capstone_design_flutter/src/page/test2/ChatPage.dart';
import 'package:capstone_design_flutter/src/provider/provider_count.dart';
import 'package:provider/provider.dart';

// StatelessWidget은 변화지 않는 화면을 작업할 때 사용.
// 변화는 화면을 작업 하고싶을 경우에는 StatefulWidget을 사용.

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // MaterialApp = 앱으로서 기능을 할 수 있도록 도와주는 뼈대
  @override
  Widget build(BuildContext context) {
    print('hello');
    print(Provider.of<AppState>(context).getDisplayText);
    // return MaterialApp() -> Material 디자인 테마를 사용
    return MaterialApp(
      title: "MyApp", // 앱 이름
      debugShowCheckedModeBanner: false,
      // 앱의 기본적인 테마를 지정
      theme: ThemeData(
        primarySwatch: Colors.blue, // priamrySwatch 기본적인 앱의 색상을 지정
      ),

      home: MyWidget(), // 앱이 실행될 때 표시할 화면의 함수를 호출
    );
  }
}

// 앱이 실행 될때 표시할 화면의 함수
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // scaffold = 구성된 앱에서 디자인적인 부분을 도와주는 뼈대

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(width: 30.0, image: AssetImage("imgs/umul_logo.png")),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_alert_rounded),
                    color: const Color(0xff00c7ff),
                    iconSize: 40.0)
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(a, style: TextStyle(fontSize: 20)),
                ]),
            Container(
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffF0F0F0)),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text('${context.watch<AppState>().getDisplayText}',
                        style: TextStyle(fontSize: 20.0)))),
            SizedBox(height: 10),
            Provider.of<AppState>(context, listen: false).getConnectStatus ==
                    "False"
                ? Column(children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<AppState>(context, listen: false)
                              .setConnectStatus("True");
                        },
                        icon: Icon(Icons.play_arrow_rounded),
                        color: const Color(0xff00c7ff),
                        iconSize: 50.0),
                    Text("식사 시작",
                        style: TextStyle(color: const Color(0xff00c7ff)))
                  ])
                : Column(children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<AppState>(context, listen: false)
                              .setConnectStatus("False");
                          Provider.of<AppState>(context, listen: false)
                              .setDisplayText("");
                        },
                        icon: Icon(Icons.pause_rounded),
                        color: const Color(0xff00c7ff),
                        iconSize: 50.0),
                    Text("식사 종료",
                        style: TextStyle(color: const Color(0xff00c7ff)))
                  ]),
            SizedBox(
              height: 10,
            )
          ],
        )),
      ),
    );
  }
}
