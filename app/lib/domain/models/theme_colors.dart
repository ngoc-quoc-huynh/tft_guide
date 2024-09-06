import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  const CustomThemeColors({
    this.success = Colors.green,
  });

  final Color success;

  @override
  CustomThemeColors copyWith({Color? success}) => CustomThemeColors(
        success: success ?? this.success,
      );

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) {
    return switch (other) {
      CustomThemeColors() => CustomThemeColors(
          success: Color.lerp(success, other.success, t)!,
        ),
      _ => this,
    };
  }

  CustomThemeColors harmonized(ColorScheme colorScheme) => copyWith(
        success: success.harmonizeWith(colorScheme.primary),
      );
}
