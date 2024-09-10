import 'package:flutter/rendering.dart';

final class Sizes {
  const Sizes._();

  static const horizontalPadding = 20.0;
  static const verticalPadding = 20.0;
  static const cardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 15,
  );

  static const progressBarAnimationShortDuration = Duration(milliseconds: 300);
  static const progressBarAnimationLongDuration = Duration(milliseconds: 650);
}
