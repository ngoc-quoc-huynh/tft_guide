import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/widgets_binding.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: avoid-redundant-async, no async task to do.

void main() {
  const repository = WidgetsBindingRepository();

  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(Injector.instance.unregister<LoggerApi>);

  group('brightness', () {
    testWidgets('returns correctly.', (tester) async {
      tester.view.platformDispatcher.platformBrightnessTestValue =
          Brightness.light;
      expect(repository.brightness, Brightness.light);

      tester.view.platformDispatcher.platformBrightnessTestValue =
          Brightness.dark;
      expect(repository.brightness, Brightness.dark);
    });
  });

  group('locale', () {
    testWidgets('returns correctly.', (tester) async {
      tester.view.platformDispatcher.localeTestValue = const Locale('en');
      expect(repository.locale, const Locale('en'));
    });
  });
}
