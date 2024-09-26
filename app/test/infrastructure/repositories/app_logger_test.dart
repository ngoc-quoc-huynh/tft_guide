import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/infrastructure/repositories/app_logger.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: missing-test-assertion, verify is sufficient.

void main() {
  final logger = MockLogger();

  setUpAll(
    () => Injector.instance.registerSingleton<Logger>(logger),
  );

  tearDownAll(
    () async => Injector.instance.unregister<Logger>(),
  );

  group('logException', () {
    test('returns correctly without parameters.', () {
      const AppLogger().logException(
        'methodName',
        exception: const UnknownException(),
        stackTrace: StackTrace.empty,
      );

      verify(
        () => logger.e(
          '''
methodName
{}''',
          error: const UnknownException(),
          stackTrace: StackTrace.empty,
        ),
      );
    });

    test('returns correctly with parameters.', () {
      const AppLogger().logException(
        'methodName',
        exception: const UnknownException(),
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.e(
          '''
methodName
{
  "parameters": {
    "id": "id"
  }
}''',
          error: const UnknownException(),
          stackTrace: StackTrace.empty,
        ),
      );
    });
  });

  group('logInfo', () {
    test('returns correctly without parameters.', () {
      const AppLogger().logInfo(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
      );
      verify(
        () => logger.i(
          '''
methodName
{
  "message": "message"
}''',
          stackTrace: StackTrace.empty,
        ),
      );
    });

    test('returns correctly with parameters.', () {
      const AppLogger().logInfo(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.i(
          '''
methodName
{
  "parameters": {
    "id": "id"
  },
  "message": "message"
}''',
          stackTrace: StackTrace.empty,
        ),
      );
    });
  });

  group('logWarning', () {
    test('returns correctly without parameters.', () {
      const AppLogger().logWarning(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
      );
      verify(
        () => logger.w(
          '''
methodName
{
  "message": "message"
}''',
          stackTrace: StackTrace.empty,
        ),
      );
    });

    test('returns correctly with parameters.', () {
      const AppLogger().logWarning(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.w(
          '''
methodName
{
  "parameters": {
    "id": "id"
  },
  "message": "message"
}''',
          stackTrace: StackTrace.empty,
        ),
      );
    });
  });
}
