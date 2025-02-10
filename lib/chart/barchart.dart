import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<ChartSampleData> chartData;
  bool isResetVisible = false;
  late ChartSeriesController seriesController;
  Set<int> clickedXValues = <int>{};

  @override
  void initState() {
    super.initState();
    chartData = [
      //ChartSampleData(x: 1, y: 1),
      //ChartSampleData(x: 2, y: 2),
    ];
  }

  void _handleChartInteractionUp(ChartTouchInteractionArgs args) {
    final Offset value = Offset(args.position.dx, args.position.dy);
    final chartPoint = seriesController.pixelToPoint(value);
    final xValue = chartPoint.x.toInt();
    final yValue = chartPoint.y.toInt();

    if (!chartData.any((data) => data.x == xValue)) {
      setState(() {
        isResetVisible = true;
        chartData.add(ChartSampleData(x: xValue, y: yValue));
      });
    }
  }

  void _resetChartData() {
    setState(() {
      chartData = [
        //ChartSampleData(x: 1, y: 1),
        //ChartSampleData(x: 2, y: 2),
      ];
      clickedXValues.clear();
      isResetVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = 40.0;
    final bool isWebFullView = true;
    final bool isCardView = false;
    final Color cardThemeColor = Colors.white;
    final Color backgroundColor = Colors.grey[600]!;
    final IconData resetIcon = Icons.refresh;

    return Scaffold(
      backgroundColor: cardThemeColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, isCardView ? 0 : 15, 5, bottomPadding),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey[600]!, width: 1.8)),
            width: 360,
            height: 300,
            child: Stack(
              children: [
                _buildInteractiveChart(),
                _buildMarkers(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: isWebFullView ? 45 : 40,
        width: 45,
        child: FloatingActionButton(
          onPressed: isResetVisible ? _resetChartData : null,
          backgroundColor: isResetVisible ? backgroundColor : Colors.grey[600],
          child: Icon(resetIcon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMarkers() {
    return Positioned(
      top: 45,
      bottom: 60,
      left: 15,
      width: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildMarker("assets/calender_page/1-Happy.png", Colors.transparent),
          _buildMarker(
              "assets/calender_page/5-Nothing.png", Colors.transparent),
          _buildMarker("assets/calender_page/3-Angry.png", Colors.transparent),
          _buildMarker("assets/calender_page/4-Upset.png", Colors.transparent),
          _buildMarker("assets/calender_page/2-Sad.png", Colors.transparent),
        ],
      ),
    );
  }

  Widget _buildMarker(String imagePath, Color color, {double size = 30.0}) {
    return SizedBox(
      width: size,
      height: size,
      child: Transform.scale(
        scale: size / 15.0, // 调整比例以匹配圆圈大小
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  SfCartesianChart _buildInteractiveChart() {
    return SfCartesianChart(
      margin: const EdgeInsets.fromLTRB(45, 15, 20, 10),
      plotAreaBorderWidth: 0,
      enableAxisAnimation: true,
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        rangePadding: ChartRangePadding.additional,
        majorGridLines: const MajorGridLines(width: 0),
        maximum: 8.0,
        minimum: 1.0,
        desiredIntervals: 7,
        labelFormat: '{value}',
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.additional,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        minimum: 0,
        maximum: 6,
        isVisible: true,
        desiredIntervals: 6,
        labelStyle: TextStyle(color: Colors.transparent),
      ),
      series: <ChartSeries<ChartSampleData, int>>[
        LineSeries<ChartSampleData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            seriesController = controller;
          },
          animationDuration: 1000,
          color: const Color.fromRGBO(75, 135, 185, 1),
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
          ),
        ),
      ],
      onChartTouchInteractionUp: _handleChartInteractionUp,
    );
  }
}

class ChartSampleData {
  ChartSampleData({required this.x, required this.y});
  final int x;
  final int y;
}
