import 'package:comic_vine_app/core/widgets/dot_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DotLoadingIndicator displays animated dots', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: DotLoadingIndicator(size: 20.0)),
    ));

    // Verify that 3 dots are displayed
    final dotFinder = find.byType(Container); // Each dot is a container
    expect(dotFinder, findsNWidgets(3));

    // Ensure that the animation starts
    await tester.pump(const Duration(milliseconds: 500));

    expect(dotFinder, findsNWidgets(3));
  });
}
