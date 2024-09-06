import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/theme_colors.dart';

extension ThemeExtension on ThemeData {
  CustomThemeColors get customColors => extension<CustomThemeColors>()!;
}
