import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/colors.dart';

final class CustomTheme {
  const CustomTheme._();

  static ThemeData lightTheme(TextTheme textTheme) =>
      _themeData(Brightness.light, textTheme);

  static ThemeData darkTheme(TextTheme textTheme) =>
      _themeData(Brightness.dark, textTheme);

  static ColorScheme _colorScheme(Brightness brightness) =>
      ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: CustomColors.purple,
      );

  static ThemeData _themeData(Brightness brightness, TextTheme textTheme) {
    final colorScheme = _colorScheme(brightness);
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map.fromEntries(
          TargetPlatform.values.map(
            (platform) => MapEntry(
              platform,
              const CupertinoPageTransitionsBuilder(),
            ),
          ),
        ),
      ),
    );
  }
}
