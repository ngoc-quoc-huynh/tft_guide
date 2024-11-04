import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/app_update.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

Future<void> main() async {
  final appApi = MockAppApi();
  final nativeApi = MockNativeApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(
        TranslationsEn.build(),
      )
      ..registerSingleton<AppApi>(appApi)
      ..registerSingleton<NativeApi>(nativeApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<AppApi>()
      ..unregister<NativeApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'app_update',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'No update',
          child: const SettingsAppUpdateDialog.noUpdate(),
        ),
        GoldenTestScenario(
          name: 'Update',
          child: const SettingsAppUpdateDialog.update(
            appUpdateInfo: AppUpdateInfo(
              version: '1.0.0',
              releaseNotes: '- Initial release',
            ),
          ),
        ),
      ],
    ),
  );

  await goldenTest(
    'renders success correctly.',
    fileName: 'app_update_result',
    whilePerforming: tap(find.byType(FilledButton)),
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario.builder(
          name: 'Success',
          builder: (context) {
            when(
              () => appApi.downloadAppUpdate(
                '1.0.0',
                onReceiveProgress: any(named: 'onReceiveProgress'),
              ),
            ).thenAnswer((_) async => 'tft.apk');
            when(() => nativeApi.openFile('tft.apk'))
                .thenAnswer((_) => Future.value());

            return const SettingsAppUpdateDialog.update(
              appUpdateInfo: AppUpdateInfo(
                version: '1.0.0',
                releaseNotes: '- Initial release',
              ),
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'Error',
          builder: (context) {
            when(
              () => appApi.downloadAppUpdate(
                '2.0.0',
                onReceiveProgress: any(named: 'onReceiveProgress'),
              ),
            ).thenThrow(const UnknownException());

            return const SettingsAppUpdateDialog.update(
              appUpdateInfo: AppUpdateInfo(
                version: '2.0.0',
                releaseNotes: '- Initial release',
              ),
            );
          },
        ),
      ],
    ),
  );
}
