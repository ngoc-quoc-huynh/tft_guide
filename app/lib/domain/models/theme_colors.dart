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
  List<Object?> get props {
    int normalizeTo255(double component) => (component * 255).round();
    return [
      normalizeTo255(success.r),
      normalizeTo255(success.g),
      normalizeTo255(success.b),
      normalizeTo255(success.a),
      normalizeTo255(warning.r),
      normalizeTo255(warning.g),
      normalizeTo255(warning.b),
      normalizeTo255(warning.a),
      type,
    ];
  }
}
