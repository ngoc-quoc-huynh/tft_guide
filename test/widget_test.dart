import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/main.dart';

void main() {
  group('MyApp', () {
    setUpAll(Injector.setupDependencies);

    testWidgets('Example Test works', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
