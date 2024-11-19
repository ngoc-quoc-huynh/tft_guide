import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/main.dart';

extension type Robot(WidgetTester _tester) {
  Future<void> initApp() async {
    await _tester.pumpWidget(const TftApp());
    await _tester.pumpAndSettle(const Duration(milliseconds: 500));
  }
}
