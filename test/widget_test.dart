// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);


    expect(find.text('+'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
    expect(find.text('/'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);


    await tester.tap(find.text("10"));
    await tester.tap(find.text("+"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("="));
    await tester.pump();

    expect(find.text('19'), findsOneWidget);

    await tester.tap(find.text("10"));
    await tester.tap(find.text("/"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("="));
    await tester.pump();

    expect(find.text('5.00'), findsOneWidget);


  });
}
