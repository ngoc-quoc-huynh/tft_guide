import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';
import 'package:tft_guide/injector.dart';

import '../../../mocks.dart';

void main() {
  group('random', () {
    test('returns correctly.', () {
      Injector.instance.registerSingleton<Random>(MockRandom());
      addTearDown(() async => Injector.instance.unregister<Random>());

      expect(
        [1, 2, 3].random,
        1,
      );
    });
  });

  group('sampleWithoutElement', () {
    test('returns correctly.', () {
      Injector.instance.registerSingleton<Random>(MockRandom(1));
      addTearDown(() async => Injector.instance.unregister<Random>());

      expect(
        [1, 2, 3].sampleWithoutElement(1),
        [3],
      );
    });

    test('returns correctly ignoring 1.', () {
      Injector.instance.registerSingleton<Random>(MockRandom(2));
      addTearDown(() async => Injector.instance.unregister<Random>());

      expect(
        [1, 2, 3].sampleWithoutElement(
          1,
          ignore: (element) => element == 1,
        ),
        [2],
      );
    });

    test('throws AssertionError when count is smaller than 1.', () {
      expect(
        () => [1, 2, 3].sampleWithoutElement(0),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'count must be greater than 0.',
          ),
        ),
      );
    });
  });
}
