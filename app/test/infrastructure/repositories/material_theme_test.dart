import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/material_theme.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';
import '../../utils.dart';

void main() {
  final fileStorageApi = MockFileStorageApi();
  const repository = MaterialThemeRepository();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileStorageApi>(fileStorageApi)
      ..registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<FileStorageApi>()
      ..unregister<LoggerApi>(),
  );

  group('computeThemeFromFileImage', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    test('returns null if file does not exist.', () async {
      when(() => fileStorageApi.loadFile('test.webp')).thenAnswer(
        (_) => const TestFile('test.webp').toFile(),
      );

      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.light,
        textTheme: const TextTheme(),
      );
      expect(theme, isNull);
    });

    test('returns null if an error occurs.', () async {
      when(() => fileStorageApi.loadFile('test.webp'))
          .thenThrow(const UnknownException());

      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.light,
        textTheme: const TextTheme(),
      );
      expect(theme, isNull);
    });
  });
}
