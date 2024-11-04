import 'package:dynamic_color/dynamic_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomThemeColors extends ThemeExtension<CustomThemeColors>
    with EquatableMixin {
  const CustomThemeColors({
    this.success = Colors.green,
    this.warning = Colors.amber,
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
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) =>
      switch (other) {
        CustomThemeColors() => CustomThemeColors(
            success: Color.lerp(success, other.success, t)!,
            warning: Color.lerp(warning, other.warning, t)!,
          ),
        _ => this,
      };

  CustomThemeColors harmonized(ColorScheme colorScheme) => copyWith(
        success: success.harmonizeWith(colorScheme.primary),
        warning: warning.harmonizeWith(colorScheme.primary),
      );

  @override
  // ignore: list-all-equatable-fields, we need to compare the value of the colors.
  List<Object?> get props => [success.value, warning.value, type];
}
