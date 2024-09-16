import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  const CustomThemeColors({
    this.success = Colors.green,
    this.warning = Colors.yellow,
  });

  final Color success;
  final Color warning;

  @override
  CustomThemeColors copyWith({Color? success, Color? warning}) =>
      CustomThemeColors(
        success: success ?? this.success,
        warning: warning ?? this.warning,
      );

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) {
    return switch (other) {
      CustomThemeColors() => CustomThemeColors(
          success: Color.lerp(success, other.success, t)!,
          warning: Color.lerp(warning, other.warning, t)!,
        ),
      _ => this,
    };
  }

  CustomThemeColors harmonized(ColorScheme colorScheme) => copyWith(
        success: success.harmonizeWith(colorScheme.primary),
        warning: warning.harmonizeWith(colorScheme.primary),
      );
}
