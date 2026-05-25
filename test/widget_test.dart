import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_widget_savoria/src/glassmorphism/glass_list_tile.dart';

void main() {
  testWidgets('GlassListTile widget renders correctly with properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GlassListTile(
            title: 'DO-TEST-123',
            status: 'Shipped',
            name: 'John Doe',
            shop: 'Super Shop',
            address: '123 Test Street',
            date: '2026-05-20',
            actionText: 'Confirm',
          ),
        ),
      ),
    );

    // Verify presence of texts
    expect(find.text('DO-TEST-123'), findsOneWidget);
    expect(find.text('Shipped'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Super Shop'), findsOneWidget);
    expect(find.text('123 Test Street'), findsOneWidget);
    expect(find.text('2026-05-20'), findsOneWidget);
    expect(find.text('Confirm'), findsOneWidget);
  });
}
