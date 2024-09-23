import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

@immutable
final class MaterialThemeRepository with LoggerMixin implements ThemeApi {
  const MaterialThemeRepository();

  static final _fileStorageApi = Injector.instance.fileStorageApi;

  @override
  Future<ThemeData?> computeThemeFromFileImage({
    required String fileName,
    required Brightness brightness,
    required TextTheme textTheme,
  }) async {
    const methodName = 'MaterialThemeRepository.computeThemeFromFileImage';
    final parameters = {
      'fileName': fileName,
      'brightness': brightness.toString(),
      'textTheme': textTheme.toString(),
    };

    try {
      final file = _fileStorageApi.loadFile(fileName);
      if (!file.existsSync()) {
        logWarning(
          methodName,
          'Could not retrieve file to compute the theme.',
          parameters: parameters,
          stackTrace: StackTrace.current,
        );

        return null;
      }

      final colorScheme = await ColorScheme.fromImageProvider(
        provider: FileImage(file),
        brightness: brightness,
      );
      final harmonizedColorScheme = colorScheme.harmonized();
      logInfo(
        methodName,
        'Computed theme from image.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return ThemeData.from(
        colorScheme: harmonizedColorScheme,
        textTheme: textTheme.apply(
          bodyColor: harmonizedColorScheme.onSurface,
          displayColor: harmonizedColorScheme.onSurface,
        ),
      );
    } on Exception catch (e, stackTrace) {
      logWarning(
        methodName,
        'Could not compute theme: $e',
        stackTrace: stackTrace,
        parameters: parameters,
      );

      return null;
    }
  }
}
