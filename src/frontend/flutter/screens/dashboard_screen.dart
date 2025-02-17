import 'package:flutter/material.dart';
import 'package:your_app/widgets/data_input_form.dart';
import 'package:your_app/widgets/data_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to data input screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataInputForm()),
                );
              },
              child: Text('データ入力'),
            ),
            SizedBox(height: 20),
            DataChart(), // Display data chart
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement data export functionality
                // Example:
                // exportData();
              },
              child: Text('データエクスポート'),
            ),
          ],
        ),
      ),
    );
  }
};