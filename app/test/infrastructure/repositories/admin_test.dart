import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/admin.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  const repository = AdminRepository('1234');

  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(Injector.instance.unregister<LoggerApi>);

  group('checkPassword', () {
    test(
      'returns true if password is correct.',
      () => expect(
        repository.checkPassword('1234'),
        isTrue,
      ),
    );

    test(
      'returns false if password is incorrect.',
      () => expect(
        repository.checkPassword('1'),
        isFalse,
      ),
    );
  });
}
