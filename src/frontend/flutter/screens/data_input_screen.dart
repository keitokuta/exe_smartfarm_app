import 'package:flutter/material.dart';
import 'package:field_master/widgets/data_input_form.dart';

class DataInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('データ入力'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataInputForm(),
      ),
    );
  }
};