import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class HealthDataVisualizationScreen extends StatefulWidget {
  final String healthMetricName;
  final IconData icon;
  final Color color;
  final String unit;
  final bool connected;
  final ValueChanged<bool> onConnectionChanged;

  HealthDataVisualizationScreen({
    required this.healthMetricName,
    required this.icon,
    this.color = const Color(0xFFD2416E),
    this.unit = '',
    this.connected = false,
    required this.onConnectionChanged,
  });

  @override
  _HealthDataVisualizationScreenState createState() =>
      _HealthDataVisualizationScreenState();
}

class _HealthDataVisualizationScreenState
    extends State<HealthDataVisualizationScreen> with SingleTickerProviderStateMixin {
  List<FlSpot> dataPoints = [];
  Timer? timer;
  late AnimationController _controller;
  double currentValue = 0;
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    isConnected = widget.connected;

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat(reverse: true);

    if (isConnected) {
      _startDataGeneration();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startDataGeneration() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (dataPoints.length >= 10) {
          dataPoints.removeAt(0);
        }
        currentValue = _generateRandomData();

        dataPoints.add(FlSpot(timer.tick.toDouble(), currentValue));
      });
    });
  }

  double _generateRandomData() {
    return 80 + (100 - 80) * Random().nextDouble();
  }

  void _stopDataGeneration() {
    timer?.cancel();
    setState(() {
      dataPoints.clear();
    });
  }

  void _toggleConnection() {
    setState(() {
      isConnected = !isConnected;
    });

    if (isConnected) {
      _startDataGeneration();
    } else {
      _stopDataGeneration();
    }

    widget.onConnectionChanged(isConnected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.healthMetricName} Tracking'),
        backgroundColor: widget.color,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF3EFEA)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                      widget.icon,
                                      color: widget.color,
                                      size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    widget.healthMetricName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: widget.color,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                isConnected
                                    ? '${currentValue.toStringAsFixed(2)} ${widget.unit}'
                                    : 'Not Connected',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: widget.color),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _toggleConnection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isConnected ? Colors.red : widget.color,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(isConnected ? 'Disconnect' : 'Connect'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: isConnected
                        ? LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Text(
                                  value.toStringAsFixed(0),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: widget.color, width: 1)),
                        minX: dataPoints.isNotEmpty
                            ? dataPoints.first.x
                            : 0,
                        maxX: dataPoints.isNotEmpty
                            ? dataPoints.last.x
                            : 0,
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: dataPoints,
                            isCurved: true,
                            color: widget.color,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: widget.color.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Center(
                      child: Text(
                        'Please connect to see the live data from IoT device.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center ,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}