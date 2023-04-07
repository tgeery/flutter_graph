import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Graph Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CountPerMonthChart()
    );
  }
}

class CountPerMonthChart extends StatelessWidget {
  double yMin = 0;
  double yMax = 4;
  double xMin = 0;
  double xMax = 13;
  CountPerMonthChart();

  Widget countTitle(double value, TitleMeta meta) {
    return SideTitleWidget(axisSide: meta.axisSide, space: 10, child: Text(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: GraphLine(),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: GraphAxis(title: monthTitle),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
          leftTitles: GraphAxis(title: countTitle,),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 2),
            left: BorderSide(color: Colors.black, width: 2),
            right: BorderSide(color: Colors.transparent),
            top: BorderSide(color: Colors.transparent),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: false,
            color: Colors.black,
            barWidth: 5,
            isStrokeCapRound: false,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(1, 1),
              FlSpot(2, 3),
              FlSpot(3, 2),
              FlSpot(4, 1),
              FlSpot(5, 1),
              FlSpot(6, 2),
              FlSpot(7, 3),
              FlSpot(8, 3),
              FlSpot(9, 4),
              FlSpot(10, 2),
              FlSpot(11, 2),
              FlSpot(12, 3),
            ],
          )
        ],
        minX: xMin,
        maxX: xMax,
        maxY: yMax,
        minY: yMin,
      )
    );
  }
}

class GraphLine extends LineTouchData {
  GraphLine({tooltipTextColor = Colors.white,
             tooltipBgColor = Colors.black
            }) : super(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    var textStyle = TextStyle(color: tooltipTextColor);
                    return LineTooltipItem(touchedSpot.y.toString(), textStyle);
                  }).toList();
                },
                tooltipBgColor: tooltipBgColor,
              )
            );
}

class GraphAxis extends AxisTitles {  
  GraphAxis({sz = 30, title = null}) : super(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: sz,
      interval: 1,
      getTitlesWidget: title,
    )
  );
}

Widget monthTitle(double value, TitleMeta meta) {
  var txt = Text("");
  switch(value.toInt()) {
    case 1: {txt = Text("J");} break;
    case 2: {txt = Text("F");} break;
    case 3: {txt = Text("M");} break;
    case 4: {txt = Text("A");} break;
    case 5: {txt = Text("M");} break;
    case 6: {txt = Text("J");} break;
    case 7: {txt = Text("J");} break;
    case 8: {txt = Text("A");} break;
    case 9: {txt = Text("S");} break;
    case 10: {txt = Text("O");} break;
    case 11: {txt = Text("N");} break;
    case 12: {txt = Text("D");} break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: txt,
  );
}