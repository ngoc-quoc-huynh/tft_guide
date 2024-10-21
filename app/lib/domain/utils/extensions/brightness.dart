import 'dart:ui';

extension BrightnessExtension on Brightness {
  Brightness get inverted => switch (this) {
        Brightness.dark => Brightness.light,
        Brightness.light => Brightness.dark,
      };
}
