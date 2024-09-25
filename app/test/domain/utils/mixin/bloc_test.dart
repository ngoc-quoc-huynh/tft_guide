import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

import '../../../mocks.dart';

void main() {
  const testClass = _TestClass();
  final loggerApi = MockLoggerApi();

  setUpAll(
    () {
      Injector.instance.registerSingleton<LoggerApi>(loggerApi);
      registerFallbackValue(StackTrace.empty);
    },
  );

  tearDownAll(
    () async => Injector.instance.unregister<LoggerApi>(),
  );

  group('executeSafely', () {
    test('returns true.', () async {
      int n = 0;
      final result = await testClass.executeSafely(
        methodName: 'methodName',
        function: () => n++,
        onError: () => n--,
      );

      expect(result, isTrue);
      expect(n, 1);
    });

    test('returns false.', () async {
      int n = 0;
      final result = await testClass.executeSafely(
        methodName: 'methodName',
        function: () => throw const UnknownException(),
        onError: () => n--,
      );

      expect(result, isFalse);
      expect(n, -1);
    });

    test('returns false and logs exception.', () async {
      when(
        () => loggerApi.logException(
          'methodName',
          exception: const _CustomException(),
          stackTrace: any(named: 'stackTrace'),
        ),
      );
      int n = 0;
      final result = await testClass.executeSafely(
        methodName: 'methodName',
        function: () => throw const _CustomException(),
        onError: () => n--,
      );

      expect(result, isFalse);
      expect(n, -1);
      verify(
        () => loggerApi.logException(
          'methodName',
          exception: const _CustomException(),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).called(1);
    });
  });
}

final class _TestClass with BlocMixin {
  const _TestClass();
}

final class _CustomException extends Equatable implements Exception {
  const _CustomException();

  @override
  List<Object?> get props => [];
}
