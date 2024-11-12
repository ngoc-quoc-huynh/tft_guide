import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

import 'robot.dart';

extension type GamePageRobot(WidgetTester _tester) implements Robot {
  void verifyInitialScreen() {
    expect(
      find.image(AssetImage(Assets.iron1())),
      findsOneWidget,
    );
    _verifyLpCounter(99);
  }

  Future<void> startGame() async {
    await _tester.tap(find.byType(FilledButton));
    await _tester.pumpAndSettle();
  }

  Future<void> checkSelectionItem(
    int index, {
    required bool isCorrect,
  }) async {
    await _tester.tap(find.bySubtype<SelectionItem>().at(index));
    await _tester.pump();
    await _tester.tap(find.text('Check'));
    await _tester.pumpAndSettle();
    expect(find.byType(FeedbackBottomSheet), findsOneWidget);
    expect(
      find.byIcon(
        switch (isCorrect) {
          false => Icons.error,
          true => Icons.check_circle,
        },
      ),
      findsOneWidget,
    );
    await _tester.tap(find.text('Continue'));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyEndScreen() async {
    await _tester.pumpAndSettle();
    expect(
      find.image(AssetImage(Assets.bronze4())),
      findsOneWidget,
    );
    _verifyLpCounter(5);
    expect(find.text('+ 6'), findsOneWidget);
  }

  void _verifyLpCounter(int expectedValue) {
    final animatedCounter = find
        .byType(AnimatedFlipCounter)
        .evaluate()
        .single
        .widget as AnimatedFlipCounter;
    expect(animatedCounter.value, expectedValue);
  }
}
