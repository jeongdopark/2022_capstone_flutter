import 'package:flutter/material.dart';

class week_report extends StatefulWidget {
  const week_report({Key key}) : super(key: key);

  @override
  State<week_report> createState() => _week_reportState();
}

class _week_reportState extends State<week_report> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      color: Colors.limeAccent,
      child: Text("weekly report"),
    );
  }
}
