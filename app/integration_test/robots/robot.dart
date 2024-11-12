import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/main.dart';

extension type Robot(WidgetTester _tester) {
  Future<void> initApp() async {
    await _tester.pumpWidget(const TftApp());
    // This is intended. We need to pump the InitPage and the RankedPage
    await _tester.pumpAndSettle();
    await _tester.pumpAndSettle();
    await _tester.pumpAndSettle();
  }
}
