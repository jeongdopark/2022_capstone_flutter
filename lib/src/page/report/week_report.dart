import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class week_report extends StatefulWidget {
  const week_report({Key key}) : super(key: key);

  @override
  State<week_report> createState() => _ChartApp();
}

class _ChartApp extends State<week_report> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_ChartData> data;
  TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Mon', 12),
      _ChartData('Tue', 15),
      _ChartData('Wed', 12),
      _ChartData('Thur', 15),
      _ChartData('Fri', 12),
      _ChartData('Sat', 15),
      _ChartData('Sun', 15),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: AppBar(
            title: const Text(
              'Weekly Report',
            ),
          ),
        ),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 30, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}
