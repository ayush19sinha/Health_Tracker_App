import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/HealthCard.dart';
import 'health_data_visualization_screen.dart';
import '../app_theme.dart';

class DeviceListScreen extends StatefulWidget {
  final String deviceName;
  final String connectionType;

  DeviceListScreen({required this.deviceName, required this.connectionType});

  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  List<Map<String, dynamic>> healthMetrics = [
    {
      'title': 'Pulse Monitor',
      'value': '75',
      'color': Color(0xFFD2416E),
      'unit': 'bpm',
      'icon': Icons.favorite,
      'isConnected': false
    },
    {
      'title': 'Oxygen Meter',
      'value': '98',
      'color': Color(0xFFFFC107),
      'unit': '%',
      'icon': Icons.bubble_chart,
      'isConnected': false
    },
    {
      'title': 'Temperature Sensor',
      'value': '36.5',
      'color': Color(0xFF66BB6A),
      'unit': '°C',
      'icon': Icons.thermostat,
      'isConnected': false
    },
    {
      'title': 'Blood Pressure Reader',
      'value': '120/80',
      'color': Color(0xFF8E44AD),
      'unit': 'mmHg',
      'icon': Icons.health_and_safety,
      'isConnected': false
    },
  ];

  void toggleConnection(int index, bool newState) {
    setState(() {
      healthMetrics[index]['isConnected'] = newState;
    });
  }

  void navigateToHealthDataScreen(int index) {
    final metric = healthMetrics[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HealthDataVisualizationScreen(
          healthMetricName: metric['title'],
          icon: metric['icon'],
          color: metric['color'],
          unit: metric['unit'],
          connected: metric['isConnected'],
          onConnectionChanged: (bool newState) {
            toggleConnection(index, newState);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Metrics')
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
        ),
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: healthMetrics.length,
            itemBuilder: (BuildContext context, int index) {
              final metric = healthMetrics[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        navigateToHealthDataScreen(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: HealthCard(
                          title: metric['title'],
                          value: metric['value'],
                          color: metric['color'],
                          unit: metric['unit'],
                          icon: metric['icon'],
                          isConnected: metric['isConnected'],
                          onToggleConnection: () {
                            toggleConnection(index, !metric['isConnected']);
                            navigateToHealthDataScreen(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
