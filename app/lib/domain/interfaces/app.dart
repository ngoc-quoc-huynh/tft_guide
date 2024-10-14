import 'package:dio/dio.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';

// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class AppApi {
  const AppApi();

  Future<AppUpdateInfo> getAppUpdateInfo();

  Future<String> downloadAppUpdate(
    String version, {
    required ProgressCallback onReceiveProgress,
  });
}
