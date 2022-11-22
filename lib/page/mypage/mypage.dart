import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 50),
            Text("마이페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 70),
            GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 15),
                  Text("프로필 수정", style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            SizedBox(height: 50),
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
                print("hello");
              },
              child: Row(
                children: [
                  Icon(Icons.bluetooth_rounded),
                  SizedBox(width: 15),
                  Text("기기 변경", style: TextStyle(fontSize: 20))
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
                  Icon(Icons.account_circle),
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
            SizedBox(height: 50),
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
            SizedBox(height: 50),
          ],
        )),
      ),
    );
  }
}
