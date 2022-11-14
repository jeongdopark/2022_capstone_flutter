import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    // return MaterialApp() -> Material 디자인 테마를 사용
    return MaterialApp(
      title: "MyApp", // 앱 이름
      debugShowCheckedModeBanner: false, // 타이틀 바 우측 띠 제거

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
            SizedBox(height: 50),
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
            SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("홈", style: TextStyle(fontSize: 20)),
                    Text("동기부여 멘트 및 한 줄 뉴스를 보여줍니다"),
                    Text("10:04"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffF0F0F0)),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 150, horizontal: 125),
                    child: Text('횟수'))),
            SizedBox(height: 50),
            Column(children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.play_arrow_rounded),
                  color: const Color(0xff00c7ff),
                  iconSize: 80.0),
              Text("식사 시작", style: TextStyle(color: const Color(0xff00c7ff)))
            ]),
            SizedBox(height: 50)
          ],
        )),
      ),
    );
  }
}
