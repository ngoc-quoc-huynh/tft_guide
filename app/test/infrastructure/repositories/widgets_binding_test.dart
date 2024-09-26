import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/widgets_binding.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: avoid-redundant-async, no async task to do.

void main() {
  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(Injector.instance.unregister<LoggerApi>);

  group('brightness', () {
    testWidgets('returns correctly.', (tester) async {
      tester.view.platformDispatcher.platformBrightnessTestValue =
          Brightness.light;
      expect(const WidgetsBindingRepository().brightness, Brightness.light);

      tester.view.platformDispatcher.platformBrightnessTestValue =
          Brightness.dark;
      expect(const WidgetsBindingRepository().brightness, Brightness.dark);
    });
  });

  group('locale', () {
    testWidgets('returns correctly.', (tester) async {
      tester.view.platformDispatcher.localeTestValue = const Locale('en');
      expect(const WidgetsBindingRepository().locale, const Locale('en'));
    });
  });
}
