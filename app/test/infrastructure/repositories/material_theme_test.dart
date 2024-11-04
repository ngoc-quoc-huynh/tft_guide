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
      final image = await TestImage().file;
      when(() => fileStorageApi.loadFile('test.webp')).thenAnswer(
        (_) => image,
      );

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
            primary: Color(0xfff1be6d),
            onPrimary: Color(0xff432c00),
            primaryContainer: Color(0xff604100),
            onPrimaryContainer: Color(0xffffdeae),
            primaryFixed: Color(0xffffdeae),
            primaryFixedDim: Color(0xfff1be6d),
            onPrimaryFixed: Color(0xff281900),
            onPrimaryFixedVariant: Color(0xff604100),
            secondary: Color(0xffdcc3a1),
            onSecondary: Color(0xff3d2e16),
            secondaryContainer: Color(0xff55442a),
            onSecondaryContainer: Color(0xfff9dfbb),
            secondaryFixed: Color(0xfff9dfbb),
            secondaryFixedDim: Color(0xffdcc3a1),
            onSecondaryFixed: Color(0xff261904),
            onSecondaryFixedVariant: Color(0xff55442a),
            tertiary: Color(0xffb6cea3),
            onTertiary: Color(0xff223517),
            tertiaryContainer: Color(0xff384c2c),
            onTertiaryContainer: Color(0xffd1eabe),
            tertiaryFixed: Color(0xffd1eabe),
            tertiaryFixedDim: Color(0xffb6cea3),
            onTertiaryFixed: Color(0xff0d2005),
            onTertiaryFixedVariant: Color(0xff384c2c),
            error: Color(0xfffeb69a),
            onError: Color(0xff5a1c00),
            errorContainer: Color(0xff7f2b00),
            onErrorContainer: Color(0xffffdbcf),
            surface: Color(0xff18130b),
            onSurface: Color(0xffece1d4),
            surfaceDim: Color(0xff18130b),
            surfaceBright: Color(0xff3f382f),
            surfaceContainerLowest: Color(0xff120d07),
            surfaceContainerLow: Color(0xff201b13),
            surfaceContainer: Color(0xff241f17),
            surfaceContainerHigh: Color(0xff2f2921),
            surfaceContainerHighest: Color(0xff3a342b),
            onSurfaceVariant: Color(0xffd2c4b4),
            outline: Color(0xff9b8f80),
            outlineVariant: Color(0xff4f4539),
            inverseSurface: Color(0xffece1d4),
            onInverseSurface: Color(0xff362f27),
            inversePrimary: Color(0xff7d570e),
            surfaceTint: Color(0xfff1be6d),
            // ignore: deprecated_member_use, we have to compare the whole class.
            background: Color(0xff18130b),
            // ignore: deprecated_member_use, we have to compare the whole class.
            onBackground: Color(0xffece1d4),
            // ignore: deprecated_member_use, we have to compare the whole class.
            surfaceVariant: Color(0xff4f4539),
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
