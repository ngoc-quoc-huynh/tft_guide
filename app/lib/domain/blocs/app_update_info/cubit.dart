import 'dart:async';

import 'package:clock/clock.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

final class AppUpdateInfoCubit extends HydratedCubit<AppUpdateInfo?>
    with BlocMixin {
  AppUpdateInfoCubit() : super(null);

  static final _appApi = Injector.instance.appApi;
  static final _localStorageApi = Injector.instance.localStorageApi;
  static final _packageInfo = Injector.instance.packageInfo;

  void initialize() => unawaited(
        executeSafely(
          methodName: 'AppUpdateInfoCubit.initialize',
          function: () async {
            if (_localStorageApi.lastAppUpdate?.isToday ?? false) {
              if (state?.version == _packageInfo.version) {
                emit(null);
              } else {
                emit(state);
              }
            } else {
              final appUpdateInfo = await _appApi.getAppUpdateInfo();
              if (appUpdateInfo.version != _packageInfo.version) {
                await _localStorageApi.updateLastAppUpdate(clock.now());
                emit(appUpdateInfo);
              } else {
                emit(null);
              }
            }
          },
          onError: () => emit(state),
        ),
      );

  @override
  AppUpdateInfo? fromJson(Map<String, dynamic> json) => switch (json) {
        {
          'version': final String version,
          'releaseNotes': final String releaseNotes,
        } =>
          AppUpdateInfo(version: version, releaseNotes: releaseNotes),
        Map<String, dynamic>() => null,
      };

  @override
  Map<String, dynamic>? toJson(AppUpdateInfo? state) => switch (state) {
        null => null,
        AppUpdateInfo() => {
            'version': state.version,
            'releaseNotes': state.releaseNotes,
          },
      };
}
