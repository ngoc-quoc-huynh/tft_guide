import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/future.dart';

import '../../../utils.dart';

void main() {
  group('runParallel', () {
    test('returns correctly.', () async {
      final result = await FutureExtension.runParallel([
        () async => 1,
        () async => 2,
      ]);
      expectList(result, [1, 2]);
    });

    test('should run tasks in parallel.', () async {
      final stopwatch = Stopwatch()..start();
      final tasks = [
        () => Future.delayed(const Duration(seconds: 2), () => 2),
        () => Future.delayed(const Duration(seconds: 1), () => 1),
      ];
      await FutureExtension.runParallel<int>(tasks);
      stopwatch.stop();

      expect(stopwatch.elapsed.inSeconds, lessThanOrEqualTo(2));
    });

    test('onProgress returns correctly.', () async {
      final List<int> progress = [];
      final tasks = [
        () => Future.delayed(const Duration(seconds: 2), () => 2),
        () => Future.delayed(const Duration(seconds: 1), () => 1),
      ];
      await FutureExtension.runParallel<int>(
        tasks,
        onProgress: progress.add,
      );

      expect(progress, [0, 1]);
    });

    test(
      'triggers onProgress until exception occurs, and then throws '
      'exception.',
      () async {
        final List<int> progress = [];
        final tasks = [
          () => Future.delayed(const Duration(seconds: 3), () => 3),
          () => Future<Never>.delayed(
                const Duration(seconds: 2),
                () => throw Exception(),
              ),
          () => Future.delayed(const Duration(seconds: 1), () => 1),
        ];

        await expectLater(
          FutureExtension.runParallel(
            tasks,
            onProgress: progress.add,
          ),
          throwsA(isA<Exception>()),
        );
        expectList(progress, [0]);
      },
    );

    test(
      'throws first exception if multiple exceptions are thrown.',
      () async {
        final tasks = [
          () => Future.delayed(
                const Duration(seconds: 2),
                () => throw Exception(2),
              ),
          () => Future<Never>.delayed(
                const Duration(seconds: 1),
                () => throw Exception(1),
              ),
        ];

        await expectLater(
          FutureExtension.runParallel(
            tasks,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'toString',
              'Exception: 1',
            ),
          ),
        );
      },
    );
  });
}
