import 'package:dio/src/options.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';

final class MockAppApi implements AppApi {
  const MockAppApi();

  @override
  Future<AppUpdateInfo> getAppUpdateInfo() async => const AppUpdateInfo(
        version: '1.0.0',
        releaseNotes: '- Initial relase.',
      );

  @override
  Future<String> downloadAppUpdate(
    String version, {
    required ProgressCallback onReceiveProgress,
  }) =>
      throw const UnknownException();
}
