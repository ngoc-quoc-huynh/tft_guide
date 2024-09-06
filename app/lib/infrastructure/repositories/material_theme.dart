import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/injector.dart';

final class MaterialThemeRepository implements ThemeApi {
  const MaterialThemeRepository();

  static final _fileStorageApi = Injector.instance.fileStorageApi;

  @override
  Future<ThemeData?> computeThemeFromFileImage({
    required String fileName,
    required Brightness brightness,
    required TextTheme textTheme,
  }) async {
    final file = _fileStorageApi.loadFile(fileName);
    if (!file.existsSync()) {
      return null;
    }

    final colorScheme = await ColorScheme.fromImageProvider(
      provider: FileImage(file),
      brightness: brightness,
    );
    final harmonizedColorScheme = colorScheme.harmonized();
    return ThemeData.from(
      colorScheme: harmonizedColorScheme,
      textTheme: textTheme.apply(
        bodyColor: harmonizedColorScheme.onSurface,
        displayColor: harmonizedColorScheme.onSurface,
      ),
    );
  }
}
