import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Health Device Manager',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
