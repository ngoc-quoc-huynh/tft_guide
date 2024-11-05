import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  const repository = FeedbackRepository();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<LoggerApi>(),
  );

  group('getFeedback', () {
    test('returns correctly if isCorrect is false.', () {
      Injector.instance.registerSingleton<Random>(Random(0));
      addTearDown(Injector.instance.unregister<Random>);

      expect(
        repository.getFeedback(isCorrect: false),
        'You might want to consider rerolling your brain.',
      );
    });

    test('returns correctly if isCorrect is true.', () {
      Injector.instance.registerSingleton<Random>(Random(1));
      addTearDown(Injector.instance.unregister<Random>);

      expect(
        repository.getFeedback(isCorrect: true),
        'Brain buff activated!',
      );
    });
  });
}
