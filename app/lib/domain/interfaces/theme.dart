import 'package:flutter/material.dart';

// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class ThemeApi {
  const ThemeApi();

  Future<ThemeData> computeThemeFromFileImage({
    required String fileName,
    required Brightness brightness,
    required TextTheme textTheme,
  });
}
