import 'package:flutter/material.dart';
import 'package:capstone_design_flutter/src/page/test2/MainPage.dart';
import 'package:capstone_design_flutter/src/page/profile/main.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 30),
            Text("마이 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 15),
                  Text("프로필", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
                width: 500, child: Divider(color: Colors.grey, thickness: 1.0)),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded),
                  SizedBox(width: 15),
                  Text("공지사항", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: Row(
                children: [
                  Icon(Icons.bluetooth_rounded),
                  SizedBox(width: 15),
                  Text("블루투스", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 15),
                  Text("설정", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.question_mark_rounded),
                  SizedBox(width: 15),
                  Text("고객센터", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
                width: 500, child: Divider(color: Colors.grey, thickness: 1.0)),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.logout_rounded),
                  SizedBox(width: 15),
                  Text("로그아웃", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
