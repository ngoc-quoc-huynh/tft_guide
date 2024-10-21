import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/brightness.dart';

void main() {
  group('inverted', () {
    test('returns correctly.', () {
      expect(Brightness.dark.inverted, Brightness.light);
      expect(Brightness.light.inverted, Brightness.dark);
    });
  });
}
