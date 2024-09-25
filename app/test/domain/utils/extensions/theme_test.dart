import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/theme_colors.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';

void main() {
  group('customColors', () {
    test(
      'returns correctly.',
      () => expect(
        ThemeData(extensions: const [CustomThemeColors()]).customColors,
        const CustomThemeColors(),
      ),
    );
  });
}
