import 'package:file/memory.dart';
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
    final fileSystem = MemoryFileSystem();

    test('returns correctly.', () async {
      when(() => fileStorageApi.loadFile('test.webp'))
          .thenReturn(TestFile.file);

      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.dark,
        textTheme: const TextTheme(),
      );
      expect(
        theme,
        ThemeData.from(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xffd8bafa),
            onPrimary: Color(0xff3c245a),
            primaryContainer: Color(0xff543b72),
            onPrimaryContainer: Color(0xffeedbff),
            primaryFixed: Color(0xffeedbff),
            primaryFixedDim: Color(0xffd8bafa),
            onPrimaryFixed: Color(0xff270d43),
            onPrimaryFixedVariant: Color(0xff543b72),
            secondary: Color(0xffcfc1da),
            onSecondary: Color(0xff362d40),
            secondaryContainer: Color(0xff4d4357),
            onSecondaryContainer: Color(0xffecddf7),
            secondaryFixed: Color(0xffecddf7),
            secondaryFixedDim: Color(0xffcfc1da),
            onSecondaryFixed: Color(0xff20182a),
            onSecondaryFixedVariant: Color(0xff4d4357),
            tertiary: Color(0xfff2b7c0),
            onTertiary: Color(0xff4b252c),
            tertiaryContainer: Color(0xff653b42),
            onTertiaryContainer: Color(0xffffd9de),
            tertiaryFixed: Color(0xffffd9de),
            tertiaryFixedDim: Color(0xfff2b7c0),
            onTertiaryFixed: Color(0xff321018),
            onTertiaryFixedVariant: Color(0xff653b42),
            error: Color(0xfffcb4bd),
            onError: Color(0xff670023),
            errorContainer: Color(0xff910034),
            onErrorContainer: Color(0xfffddade),
            surface: Color(0xff151218),
            onSurface: Color(0xffe8e0e8),
            surfaceDim: Color(0xff151218),
            surfaceBright: Color(0xff3c383e),
            surfaceContainerLowest: Color(0xff100d12),
            surfaceContainerLow: Color(0xff1d1a20),
            surfaceContainer: Color(0xff221e24),
            surfaceContainerHigh: Color(0xff2c292f),
            surfaceContainerHighest: Color(0xff373339),
            onSurfaceVariant: Color(0xffccc4cf),
            outline: Color(0xff958e98),
            outlineVariant: Color(0xff4a454e),
            inverseSurface: Color(0xffe8e0e8),
            onInverseSurface: Color(0xff332f35),
            inversePrimary: Color(0xff6c538b),
            surfaceTint: Color(0xffd8bafa),
            // ignore: deprecated_member_use, we have to compare the whole class.
            background: Color(0xff151218),
            // ignore: deprecated_member_use, we have to compare the whole class.
            onBackground: Color(0xffe8e0e8),
            // ignore: deprecated_member_use, we have to compare the whole class.
            surfaceVariant: Color(0xff4a454e),
          ),
        ),
      );
    });

    test('returns null if file does not exist.', () async {
      when(() => fileStorageApi.loadFile('test.webp')).thenAnswer(
        (_) => fileSystem.file('test.webp'),
      );

      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.dark,
        textTheme: const TextTheme(),
      );
      expect(theme, isNull);
    });

    test('returns null if an error occurs.', () async {
      when(() => fileStorageApi.loadFile('test.webp'))
          .thenThrow(const UnknownException());

      final theme = await repository.computeThemeFromFileImage(
        fileName: 'test.webp',
        brightness: Brightness.dark,
        textTheme: const TextTheme(),
      );
      expect(theme, isNull);
    });
  });
}
