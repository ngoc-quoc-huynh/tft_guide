import 'package:flutter/material.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/injector.dart';

final class MaterialThemeRepository implements ThemeApi {
  const MaterialThemeRepository();

  static final _fileStorageApi = Injector.instance.fileStorageApi;

  @override
  Future<ThemeData> computeThemeFromFileImage({
    required String fileName,
    required Brightness brightness,
    required TextTheme textTheme,
  }) async {
    final colorScheme = await ColorScheme.fromImageProvider(
      provider: FileImage(
        _fileStorageApi.loadFile(fileName),
      ),
      brightness: brightness,
    );
    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }
}
