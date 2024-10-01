import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/material_theme.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    test('returns null if file does not exist.', () async {
      when(() => fileStorageApi.loadFile('test.jpg')).thenAnswer(
        (_) => File('test.jpg'),
      );
      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.jpg',
        brightness: Brightness.light,
        textTheme: const TextTheme(),
      );
      expect(theme, isNull);
    });

    test('returns theme if file exists.', () async {
      when(() => fileStorageApi.loadFile('test.webp')).thenAnswer(
        (_) => File('test.webp'),
      );
      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.light,
        textTheme: const TextTheme(),
      );
      expect(theme, isNotNull);
    });
  });
}
