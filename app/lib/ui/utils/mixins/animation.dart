import 'package:flutter/foundation.dart';
import 'package:tft_guide/static/config.dart';

mixin AnimationMixin {
  Duration computeRankAnimationDuration(int? eloGain) => lerpDuration(
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 1500),
        (eloGain ?? 0) / Config.totalQuestions,
      );
}
