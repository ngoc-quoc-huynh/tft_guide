import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/pages/patch_notes/card.dart';

import 'robot.dart';

extension type PatchNotesPageRobot(WidgetTester _tester) implements Robot {
  Future<void> openTab() async {
    await _tester.tap(find.byIcon(Icons.newspaper));
    await _tester.pumpAndSettle();
  }

  void verifyScreen() {
    expect(find.byType(PatchNotesCard), findsNWidgets(1));
    expect(find.text('01.01.24'), findsOneWidget);
  }
}
