import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:capstone_design_flutter/page/report/week_report.dart';
import 'package:capstone_design_flutter/page/report/month_report.dart';

class report_page extends StatefulWidget {
  const report_page({Key key}) : super(key: key);

  @override
  State<report_page> createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {
  int currentPos = 0;
  final listPaths = [
    week_report(),
    month_report(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "저작 리포트",
                      style: TextStyle(fontSize: 30),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_alert_rounded),
                        color: const Color(0xff00c7ff),
                        iconSize: 40.0)
                  ],
                ),
                SizedBox(height: 50),
                Container(
                    padding: EdgeInsets.all(15),
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffF0F0F0)),
                    child: Text(
                      'OOO님의 저작 습관을 요약해 보았습니다!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(height: 50),
                Container(
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: 500,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffF0F0F0)),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                            itemCount: listPaths.length,
                            options: CarouselOptions(
                                height: 330,
                                viewportFraction: 2,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentPos = index;
                                  });
                                }),
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                listPaths[itemIndex]),

                        // CarouselSlider(
                        //   options: CarouselOptions(height: 300.0),
                        //   items: [week_report(), month_report()].map((i) {
                        //     return Builder(
                        //       builder: (BuildContext context) {
                        //         return Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             margin:
                        //                 EdgeInsets.symmetric(horizontal: 5.0),
                        //             decoration:
                        //                 BoxDecoration(color: Colors.amber),
                        //             child: Text(
                        //               'text $i',
                        //               style: TextStyle(fontSize: 16.0),
                        //             ));
                        //       },
                        //     );
                        //   }).toList(),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: listPaths.map((url) {
                            int index = listPaths.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPos == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
