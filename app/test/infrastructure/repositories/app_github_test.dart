import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/infrastructure/repositories/app_github.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final repository = AppGithubRepository(
    dio: Dio(),
    owner: 'owner',
    repo: 'repo',
  );
  final dioAdapter = DioAdapter(dio: repository.dio);

  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(Injector.instance.unregister<LoggerApi>);

  group('getAppUpdateInfo', () {
    test('returns correctly.', () async {
      dioAdapter.onGet(
        'https://api.github.com/repos/owner/repo/releases/latest',
        (server) => server.reply(
          200,
          {
            'tag_name': '1.0.0',
            'body': '- Initial release.',
          },
        ),
      );

      final appUpdateInfo = await repository.getAppUpdateInfo();

      expect(
        appUpdateInfo,
        const AppUpdateInfo(
          version: '1.0.0',
          releaseNotes: '- Initial release.',
        ),
      );
    });

    test('throws UnknownException when the response data is null.', () async {
      dioAdapter.onGet(
        'https://api.github.com/repos/owner/repo/releases/latest',
        (server) => server.reply(
          200,
          null,
        ),
      );

      await expectLater(
        repository.getAppUpdateInfo(),
        throwsA(isA<UnknownException>()),
      );
    });

    test('throws UnknownException when an error occurs.', () async {
      dioAdapter.onGet(
        'https://api.github.com/repos/owner/repo/releases/latest',
        (server) => server.throws(
          400,
          DioException(
            requestOptions: RequestOptions(
              path: 'https://api.github.com/repos/owner/repo/releases/latest',
            ),
          ),
        ),
      );

      await expectLater(
        repository.getAppUpdateInfo(),
        throwsA(isA<UnknownException>()),
      );
    });
  });

  // TODO: Add downloadAppUpdate tests when https://github.com/lomsa-dev/http-mock-adapter/issues/163 is implemented.
}
