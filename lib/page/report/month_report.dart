import 'package:flutter/material.dart';

class month_report extends StatefulWidget {
  const month_report({Key? key}) : super(key: key);

  @override
  State<month_report> createState() => _month_reportState();
}

class _month_reportState extends State<month_report> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      color: Colors.lightBlueAccent,
      child: Text("monthly report"),
    );
  }
}
