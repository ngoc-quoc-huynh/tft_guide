import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/utils/mixins/animation.dart';

void main() {
  const testClass = _TestClass();

  group('computeRankAnimationDuration', () {
    test(
      'returns correctly if eloGain is null.',
      () => expect(
        testClass.computeRankAnimationDuration(null),
        const Duration(milliseconds: 500),
      ),
    );

    test(
      'returns correctly if eloGain is not null.',
      () {
        expect(
          testClass.computeRankAnimationDuration(0),
          const Duration(milliseconds: 500),
        );
        expect(
          testClass.computeRankAnimationDuration(5),
          const Duration(milliseconds: 1000),
        );
        expect(
          testClass.computeRankAnimationDuration(10),
          const Duration(milliseconds: 1500),
        );
      },
    );
  });
}

final class _TestClass with AnimationMixin {
  const _TestClass();
}
