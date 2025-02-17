import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataInputForm extends StatefulWidget {
  @override
  _DataInputFormState createState() => _DataInputFormState();
}

class _DataInputFormState extends State<DataInputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numericController = TextEditingController();
  String? _dropdownValue;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _numericController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _numericController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '数値入力',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '数値を入力してください';
                }
                if (double.tryParse(value) == null) {
                  return '有効な数値を入力してください';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'ドロップダウン',
                border: OutlineInputBorder(),
              ),
              value: _dropdownValue,
              items: <String>['Option 1', 'Option 2', 'Option 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'オプションを選択してください';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text(_selectedDate == null
                    ? '日付を選択'
                    : "選択された日付: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}"),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('日付を選択'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // フォームが有効な場合の処理
                  print('数値: ${_numericController.text}');
                  print('ドロップダウン: $_dropdownValue');
                  print('日付: $_selectedDate');
                }
              },
              child: Text('送信'),
            ),
          ],
        ),
      ),
    );
  }
};