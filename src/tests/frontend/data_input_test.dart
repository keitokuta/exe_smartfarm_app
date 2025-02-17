import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/data_input_screen.dart'; // Replace 'your_app' with your actual app name

void main() {
  testWidgets('DataInputScreen form input and validation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: DataInputScreen()));

    // Find the input fields.  Replace with actual keys or finders based on your implementation
    final temperatureField = find.widgetPredicate((widget) => widget is TextFormField && widget.decoration.labelText == 'Temperature');
    final humidityField = find.widgetPredicate((widget) => widget is TextFormField && widget.decoration.labelText == 'Humidity');
    final soilConditionField = find.widgetPredicate((widget) => widget is DropdownButtonFormField<String> && (widget.decoration.labelText == 'Soil Condition'));
    final submitButton = find.widgetPredicate((widget) => widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == 'Submit');

    // Enter valid data.
    await tester.enterText(temperatureField, '25');
    await tester.enterText(humidityField, '60');
    await tester.tap(soilConditionField);
    await tester.pumpAndSettle(); // Wait for dropdown to appear
    await tester.tap(find.text('Good').last); // Assuming 'Good' is an option
    await tester.pumpAndSettle();

    // Tap the submit button.
    await tester.tap(submitButton);
    await tester.pump();

    // Add assertions to check if the data was submitted successfully.
    // This will depend on how your DataInputScreen handles submission.
    // For example, you might check for a success message or navigation to another screen.
    // expect(find.text('Data submitted successfully!'), findsOneWidget); // Example assertion

    // Enter invalid data (e.g., empty temperature).
    await tester.enterText(temperatureField, '');
    await tester.pump();

    // Tap the submit button again.
    await tester.tap(submitButton);
    await tester.pump();

    // Check for validation errors.
    expect(find.text('Please enter temperature'), findsOneWidget); // Example assertion
  });
};