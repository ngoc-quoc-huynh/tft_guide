import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/domain/models/app_update_info.dart' as domain;
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/infrastructure/dtos/app_github/app_update_info.dart';
import 'package:tft_guide/injector.dart';

final class AppGithubRepository with LoggerMixin implements AppApi {
  const AppGithubRepository({
    required this.dio,
    required this.owner,
    required this.repo,
  });

  final Dio dio;
  final String owner;
  final String repo;

  static const _baseUrl = 'https://github.com';
  static const _apiBaseUrl = 'https://api.github.com';
  static const _apkName = 'app.apk';

  static final _tmpDir = Injector.instance.tmpDir;

  @override
  Future<domain.AppUpdateInfo> getAppUpdateInfo() async {
    const methodName = 'AppGithubRepository.getAppUpdateInfo';

    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$_apiBaseUrl/repos/$owner/$repo/releases/latest',
      );

      if (response.data case final Map<String, dynamic> data) {
        final appUpdateInfo = AppUpdateInfo.fromJson(data).toDomain();
        logInfo(
          methodName,
          'Retrieved app update info: $appUpdateInfo.',
          stackTrace: StackTrace.current,
        );

        return appUpdateInfo;
      } else {
        logWarning(
          methodName,
          'Invalid response data.',
          stackTrace: StackTrace.current,
        );

        throw const UnknownException();
      }
    } on DioException catch (e, stackTrace) {
      logException(
        methodName,
        exception: e,
        stackTrace: stackTrace,
      );
      Error.throwWithStackTrace(const UnknownException(), stackTrace);
    }
  }

  @override
  Future<String> downloadAppUpdate(
    String version, {
    required ProgressCallback onReceiveProgress,
  }) async {
    const methodName = 'AppGithubRepository.downloadAppUpdate';

    try {
      final path = join(_tmpDir.path, _apkName);
      await dio.download(
        '$_baseUrl/$owner/$repo/releases/download/v$version/$_apkName',
        path,
        onReceiveProgress: onReceiveProgress,
      );
      logInfo(
        methodName,
        'Downloaded app update.',
        stackTrace: StackTrace.current,
      );

      return path;
    } on DioException catch (e, stackTrace) {
      logException(
        methodName,
        exception: e,
        stackTrace: stackTrace,
      );
      Error.throwWithStackTrace(const UnknownException(), stackTrace);
    }
  }
}
