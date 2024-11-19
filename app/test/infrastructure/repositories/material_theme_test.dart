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
            primary: Color(0xffdabafa),
            onPrimary: Color(0xff3d2459),
            primaryContainer: Color(0xff553b71),
            onPrimaryContainer: Color(0xffefdbff),
            primaryFixed: Color(0xffefdbff),
            primaryFixedDim: Color(0xffdabafa),
            onPrimaryFixed: Color(0xff270d43),
            onPrimaryFixedVariant: Color(0xff553b71),
            secondary: Color(0xffd0c1da),
            onSecondary: Color(0xff362d3f),
            secondaryContainer: Color(0xff4d4357),
            onSecondaryContainer: Color(0xffecddf6),
            secondaryFixed: Color(0xffecddf6),
            secondaryFixedDim: Color(0xffd0c1da),
            onSecondaryFixed: Color(0xff20182a),
            onSecondaryFixedVariant: Color(0xff4d4357),
            tertiary: Color(0xfff3b7bf),
            onTertiary: Color(0xff4b252b),
            tertiaryContainer: Color(0xff653a41),
            onTertiaryContainer: Color(0xffffd9dd),
            tertiaryFixed: Color(0xffffd9dd),
            tertiaryFixedDim: Color(0xfff3b7bf),
            onTertiaryFixed: Color(0xff321017),
            onTertiaryFixedVariant: Color(0xff653a41),
            error: Color(0xfffcb4bd),
            onError: Color(0xff670023),
            errorContainer: Color(0xff910034),
            onErrorContainer: Color(0xfffddade),
            surface: Color(0xff151218),
            onSurface: Color(0xffe8e0e8),
            surfaceDim: Color(0xff151218),
            surfaceBright: Color(0xff3c383e),
            surfaceContainerLowest: Color(0xff100d12),
            surfaceContainerLow: Color(0xff1e1a20),
            surfaceContainer: Color(0xff221e24),
            surfaceContainerHigh: Color(0xff2c292e),
            surfaceContainerHighest: Color(0xff373339),
            onSurfaceVariant: Color(0xffccc4cf),
            outline: Color(0xff958e98),
            outlineVariant: Color(0xff4a454e),
            inverseSurface: Color(0xffe8e0e8),
            onInverseSurface: Color(0xff332f35),
            inversePrimary: Color(0xff6e538b),
            surfaceTint: Color(0xffdabafa),
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
