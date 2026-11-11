import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reyes_calculator/main.dart';

void main() {
  testWidgets('Calculator renders initial widgets correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('My Stateful Calculator'), findsOneWidget);
    expect(find.text('BASIC CALCULATOR'), findsOneWidget);
    expect(find.text('First Number'), findsOneWidget);
    expect(find.text('Second Number'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Created by: Jules\nSection: 3450'), findsOneWidget);
  });

  testWidgets('Performs addition correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '12');
    await tester.enterText(secondField, '8');

    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    expect(find.text('20.0'), findsOneWidget);
    expect(find.text('12.0 + 8.0'), findsOneWidget);
  });

  testWidgets('Performs subtraction correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '25');
    await tester.enterText(secondField, '10');

    await tester.tap(find.widgetWithText(ElevatedButton, '−'));
    await tester.pump();

    expect(find.text('15.0'), findsOneWidget);
    expect(find.text('25.0 - 10.0'), findsOneWidget);
  });

  testWidgets('Performs multiplication correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '6');
    await tester.enterText(secondField, '7');

    await tester.tap(find.widgetWithText(ElevatedButton, '×'));
    await tester.pump();

    expect(find.text('42.0'), findsOneWidget);
    expect(find.text('6.0 × 7.0'), findsOneWidget);
  });

  testWidgets('Performs division correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '20');
    await tester.enterText(secondField, '4');

    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();

    expect(find.text('5.0'), findsOneWidget);
    expect(find.text('20.0 ÷ 4.0'), findsOneWidget);
  });

  testWidgets('Handles division by zero properly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '10');
    await tester.enterText(secondField, '0');

    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();

    expect(find.text('Cannot divide by zero'), findsOneWidget);
    expect(find.text('Please change the second number'), findsOneWidget);
  });

  testWidgets('Handles invalid input gracefully', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, 'abc');
    await tester.enterText(secondField, '5');

    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    expect(find.text('Invalid input'), findsOneWidget);
    expect(find.text('Please enter two valid numbers'), findsOneWidget);
  });

  testWidgets('Clears inputs and resets state with Clear button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final firstField = find.byType(TextField).at(0);
    final secondField = find.byType(TextField).at(1);

    await tester.enterText(firstField, '50');
    await tester.enterText(secondField, '2');
    await tester.tap(find.widgetWithText(ElevatedButton, '×'));
    await tester.pump();

    expect(find.text('100.0'), findsOneWidget);

    // Scroll to and tap clear button
    final clearButton = find.widgetWithText(OutlinedButton, 'Clear');
    await tester.ensureVisible(clearButton);
    await tester.tap(clearButton);
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
  });
}
