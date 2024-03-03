import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/colors.dart';

final class CustomTheme {
  const CustomTheme._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: CustomColors.darkBlue,
    colorScheme: const ColorScheme.dark(
      primary: CustomColors.blue,
      secondary: CustomColors.orange,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      // Not necessary to override for other platforms.
      // ignore: avoid-missing-enum-constant-in-map
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false,
        ),
      },
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: CustomColors.orange),
    ),
  );
}
