import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tft_guide/domain/blocs/app_update_info/cubit.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final packageInfo = MockPackageInfo();
  final hydratedThemeModeCubit = MockHydratedThemeModeCubit();
  final languageCodeValueCubit = MockLanguageCodeValueCubit();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<PackageInfo>(packageInfo),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<PackageInfo>(),
  );

  when(() => packageInfo.version).thenReturn('1.0.0');
  whenListen<ThemeMode>(
    hydratedThemeModeCubit,
    const Stream<ThemeMode>.empty(),
    initialState: ThemeMode.light,
  );
  whenListen<LanguageCode>(
    languageCodeValueCubit,
    const Stream<LanguageCode>.empty(),
    initialState: LanguageCode.en,
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'page',
    builder: () => GoldenTestGroup(
      scenarioConstraints: pageConstraints(height: 800),
      children: [
        GoldenTestScenario.builder(
          name: 'Default',
          builder: (_) {
            final adminCubit = MockValueCubit<bool>();
            whenListen<bool>(
              adminCubit,
              const Stream<bool>.empty(),
              initialState: false,
            );
            final appUpdateInfoCubit = MockAppUpdateInfoCubit();
            whenListen<AppUpdateInfo?>(
              appUpdateInfoCubit,
              const Stream<AppUpdateInfo>.empty(),
            );

            return _TestWidget(
              adminCubit: adminCubit,
              appUpdateInfoCubit: appUpdateInfoCubit,
              hydratedThemeModeCubit: hydratedThemeModeCubit,
              languageCodeValueCubit: languageCodeValueCubit,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'With new app',
          builder: (_) {
            final adminCubit = MockValueCubit<bool>();
            whenListen<bool>(
              adminCubit,
              const Stream<bool>.empty(),
              initialState: false,
            );
            final appUpdateInfoCubit = MockAppUpdateInfoCubit();
            whenListen<AppUpdateInfo?>(
              appUpdateInfoCubit,
              const Stream<AppUpdateInfo>.empty(),
              initialState: const AppUpdateInfo(
                version: '2.0.0',
                releaseNotes: '- New design',
              ),
            );

            return _TestWidget(
              adminCubit: adminCubit,
              appUpdateInfoCubit: appUpdateInfoCubit,
              hydratedThemeModeCubit: hydratedThemeModeCubit,
              languageCodeValueCubit: languageCodeValueCubit,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'With admin features',
          constraints: pageConstraints(height: 870),
          builder: (_) {
            final adminCubit = MockValueCubit<bool>();
            whenListen<bool>(
              adminCubit,
              const Stream<bool>.empty(),
              initialState: true,
            );
            final appUpdateInfoCubit = MockAppUpdateInfoCubit();
            whenListen<AppUpdateInfo?>(
              appUpdateInfoCubit,
              const Stream<AppUpdateInfo>.empty(),
            );
            final hydratedEloCubit = MockHydratedEloCubit();
            whenListen<int>(
              hydratedEloCubit,
              const Stream<int>.empty(),
              initialState: 0,
            );
            return _TestWidget(
              adminCubit: adminCubit,
              appUpdateInfoCubit: appUpdateInfoCubit,
              hydratedEloCubit: hydratedEloCubit,
              hydratedThemeModeCubit: hydratedThemeModeCubit,
              languageCodeValueCubit: languageCodeValueCubit,
            );
          },
        ),
      ],
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget({
    required this.adminCubit,
    required this.appUpdateInfoCubit,
    required this.hydratedThemeModeCubit,
    required this.languageCodeValueCubit,
    this.hydratedEloCubit,
  });

  final AdminCubit adminCubit;
  final AppUpdateInfoCubit appUpdateInfoCubit;
  final HydratedEloCubit? hydratedEloCubit;
  final HydratedThemeModeCubit hydratedThemeModeCubit;
  final LanguageCodeValueCubit languageCodeValueCubit;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AdminCubit>.value(
            value: adminCubit,
          ),
          BlocProvider<AppUpdateInfoCubit>.value(
            value: appUpdateInfoCubit,
          ),
          if (hydratedEloCubit case final hydratedEloCubit?)
            BlocProvider<HydratedEloCubit>.value(
              value: hydratedEloCubit,
            ),
          BlocProvider<HydratedThemeModeCubit>.value(
            value: hydratedThemeModeCubit,
          ),
          BlocProvider<LanguageCodeValueCubit>.value(
            value: languageCodeValueCubit,
          ),
        ],
        child: const SettingsPage(),
      );
}
