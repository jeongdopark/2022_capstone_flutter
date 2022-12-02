import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Month_line extends StatefulWidget {
  const Month_line({Key key}) : super(key: key);

  @override
  State<Month_line> createState() => _ChartApp();
}

class _ChartApp extends State<Month_line> {
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

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_ChartData> data;
  TooltipBehavior _tooltip;

  @override
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(2010, 35),
      SalesData(2011, 28),
      SalesData(2012, 34),
      SalesData(2013, 32),
      SalesData(2014, 40)
    ];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
          // Renders line chart
          LineSeries<SalesData, int>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]))));
  }
}
