import 'package:flutter/material.dart';
import '../test2/communication.dart';
import 'package:capstone_design_flutter/src/provider/provider_count.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';

// StatelessWidget은 변화지 않는 화면을 작업할 때 사용.
// 변화는 화면을 작업 하고싶을 경우에는 StatefulWidget을 사용.

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle =
      const TextStyle(fontSize: 40.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    print("initState");
    timer = new Timer.periodic(
        new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build_test");
    print(this.mounted);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RepaintBoundary(
          child: new SizedBox(
            height: 40.0,
            child: new MinutesAndSeconds(dependencies: dependencies),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() =>
      new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    print("initState_2");
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void dispose() {
    print("dispose, 2");
    super.dispose();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      if (this.mounted) {
        setState(() {
          minutes = elapsed.minutes;
          seconds = elapsed.seconds;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("timer_test");
    print(this.mounted);
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr', style: dependencies.textStyle);
  }
}

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
  bool isLoading = true;

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isLoading = false;
    });
  }

  // scaffold = 구성된 앱에서 디자인적인 부분을 도와주는 뼈대
  final Dependencies dependencies = new Dependencies();

  void rightButtonPressed() {
    Future.delayed(Duration(milliseconds: 3000), () {
      print('test_delay_start');
      if (mounted) {
        setState(() {
          if (dependencies.stopwatch.isRunning) {
            print("end");
            dependencies.stopwatch.stop();
            dependencies.stopwatch.reset();
          } else {
            print("start");
            dependencies.stopwatch.start();
          }
        });
      }
    });
  }

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
              width: 330,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffB3E5FC)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Provider.of<AppState>(context, listen: false)
                              .getConnectStatus ==
                          "False"
                      ? Column(
                          children: [
                            Text(
                              "기기 착용 후",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "시작 버튼을 터치하세요",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : isLoading == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoadingAnimationWidget.hexagonDots(
                                  color: Color(0xFF0277BD),
                                  size: 55,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(height: 20),
                                Text(
                                    context
                                                .watch<AppState>()
                                                .getDisplayNumber ==
                                            0
                                        ? ""
                                        : '${context.watch<AppState>().getDisplayNumber}',
                                    style: TextStyle(
                                        fontSize: 45.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    new TimerText(dependencies: dependencies),
                                  ],
                                ),
                                SizedBox(height: 40),
                                LoadingAnimationWidget.horizontalRotatingDots(
                                  color: Color(0xFF0277BD),
                                  // rightDotColor: const Color(0xFF448AFF),
                                  size: 40,
                                ),
                              ],
                            )),
            ),
            SizedBox(height: 10),
            Provider.of<AppState>(context, listen: false).getConnectStatus ==
                    "False"
                ? Column(children: [
                    Provider.of<AppState>(context, listen: false)
                                .getBlueConnectStatus ==
                            "False"
                        ? IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "기기와 블루투스 연결을 해주세요",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                backgroundColor: Color(0xffB3E5FC),
                                duration: Duration(milliseconds: 1500),
                              ));
                            },
                            icon: Icon(Icons.play_arrow_rounded),
                            color: Colors.blueAccent,
                            iconSize: 50.0)
                        : IconButton(
                            onPressed: () {
                              rightButtonPressed();
                              loadData();
                              Provider.of<AppState>(context, listen: false)
                                  .setConnectStatus("True");
                            },
                            icon: Icon(Icons.play_arrow_rounded),
                            color: Colors.blueAccent,
                            iconSize: 50.0),
                    Text("Start",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ))
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            Provider.of<AppState>(context, listen: false)
                                .setBlueConnectStatus("False");
                            rightButtonPressed();
                            Provider.of<AppState>(context, listen: false)
                                .setConnectStatus("False");
                            Provider.of<AppState>(context, listen: false)
                                .setDisplayText("");
                          },
                          icon: Icon(Icons.stop_rounded),
                          color: Colors.blueAccent,
                          iconSize: 50.0),
                      Text("End",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ))
                    ]),
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
