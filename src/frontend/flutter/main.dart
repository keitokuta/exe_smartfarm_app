import 'package:flutter/material.dart';
import 'package:field_master/frontend/flutter/screens/auth_screen.dart';
import 'package:field_master/frontend/flutter/screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldMaster',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(), // 初期画面を認証画面に設定
      routes: {
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }
};