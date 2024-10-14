import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tft_guide/domain/blocs/app_update_info/cubit.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final storage = MockStorage();
  final appApi = MockAppApi();
  final localStorageApi = MockLocalStorageApi();
  final packageInfo = MockPackageInfo();

  setUpAll(
    () {
      Injector.instance
        ..registerSingleton<AppApi>(appApi)
        ..registerSingleton<LocalStorageApi>(localStorageApi)
        ..registerSingleton<PackageInfo>(packageInfo);

      when(
        // ignore: avoid-dynamic, since it is the method signature.
        () => storage.write(any(), any<dynamic>()),
      ).thenAnswer((_) => Future.value());
      HydratedBloc.storage = storage;
    },
  );

  tearDownAll(() {
    Injector.instance
      ..unregister<AppApi>()
      ..unregister<LocalStorageApi>()
      ..unregister<PackageInfo>();
    HydratedBloc.storage = null;
  });

  test(
    'initial state is null.',
    () => expect(AppUpdateInfoCubit().state, isNull),
  );

  group('initialize', () {
    test(
      'emits null if lastUpdate is today and version is the same.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => testBloc<AppUpdateInfoCubit, AppUpdateInfo?>(
          setUp: () {
            when(() => localStorageApi.lastAppUpdate)
                .thenReturn(DateTime.utc(2024));
            when(() => packageInfo.version).thenReturn('1.0.0');
          },
          seed: () => const AppUpdateInfo(
            version: '1.0.0',
            releaseNotes: '- Initial release.',
          ),
          build: AppUpdateInfoCubit.new,
          act: (cubit) => cubit.initialize(),
          expect: () => const [null],
          verify: (_) {
            verifyInOrder([
              () => localStorageApi.lastAppUpdate,
              () => packageInfo.version,
            ]);
            verifyNoMoreInteractions(appApi);
          },
        ),
      ),
    );

    test(
      'emits nothing if lastUpdate is today and version is not the same.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => testBloc<AppUpdateInfoCubit, AppUpdateInfo?>(
          setUp: () {
            when(() => localStorageApi.lastAppUpdate)
                .thenReturn(DateTime.utc(2024));
            when(() => packageInfo.version).thenReturn('0.1.0');
          },
          seed: () => const AppUpdateInfo(
            version: '1.0.0',
            releaseNotes: '- Initial release.',
          ),
          build: AppUpdateInfoCubit.new,
          act: (cubit) => cubit.initialize(),
          expect: () => const <AppUpdateInfo>[],
          verify: (_) {
            verifyInOrder([
              () => localStorageApi.lastAppUpdate,
              () => packageInfo.version,
            ]);
            verifyNoMoreInteractions(appApi);
          },
        ),
      ),
    );

    test(
      'emits app update info if lastAppUpdate is null and version is not the '
      'same.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => testBloc<AppUpdateInfoCubit, AppUpdateInfo?>(
          setUp: () {
            when(() => localStorageApi.lastAppUpdate).thenReturn(null);
            when(appApi.getAppUpdateInfo).thenAnswer(
              (_) async => const AppUpdateInfo(
                version: '1.0.0',
                releaseNotes: '- Initial release.',
              ),
            );
            when(() => packageInfo.version).thenReturn('0.1.0');
            when(() => localStorageApi.updateLastAppUpdate(DateTime.utc(2024)))
                .thenAnswer((_) => Future.value());
          },
          build: AppUpdateInfoCubit.new,
          act: (cubit) => cubit.initialize(),
          expect: () => const <AppUpdateInfo?>[
            AppUpdateInfo(
              version: '1.0.0',
              releaseNotes: '- Initial release.',
            ),
          ],
          verify: (_) {
            verifyInOrder([
              () => localStorageApi.lastAppUpdate,
              appApi.getAppUpdateInfo,
              () => packageInfo.version,
              () => localStorageApi.updateLastAppUpdate(DateTime.utc(2024)),
            ]);
          },
        ),
      ),
    );

    test(
      'emits null if lastAppUpdate is null and version is the same.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => testBloc<AppUpdateInfoCubit, AppUpdateInfo?>(
          setUp: () {
            when(() => localStorageApi.lastAppUpdate).thenReturn(null);
            when(appApi.getAppUpdateInfo).thenAnswer(
              (_) async => const AppUpdateInfo(
                version: '1.0.0',
                releaseNotes: '- Initial release.',
              ),
            );
            when(() => packageInfo.version).thenReturn('1.0.0');
          },
          build: AppUpdateInfoCubit.new,
          act: (cubit) => cubit.initialize(),
          expect: () => const [null],
          verify: (_) {
            verifyInOrder([
              () => localStorageApi.lastAppUpdate,
              appApi.getAppUpdateInfo,
              () => packageInfo.version,
            ]);
            verifyNever(
              () => localStorageApi.updateLastAppUpdate(DateTime.utc(2024)),
            );
          },
        ),
      ),
    );

    blocTest<AppUpdateInfoCubit, AppUpdateInfo?>(
      'emits nothing if an error occurs.',
      setUp: () {
        when(() => localStorageApi.lastAppUpdate).thenReturn(null);
        when(appApi.getAppUpdateInfo).thenThrow(const UnknownException());
      },
      build: AppUpdateInfoCubit.new,
      seed: () => null,
      act: (cubit) => cubit.initialize(),
      expect: () => const <AppUpdateInfo?>[],
      verify: (_) {
        verifyInOrder([
          () => localStorageApi.lastAppUpdate,
          appApi.getAppUpdateInfo,
        ]);
        verifyNoMoreInteractions(packageInfo);
        verifyNoMoreInteractions(localStorageApi);
      },
    );
  });

  group('fromJson', () {
    test(
      'returns correctly',
      () => expect(
        AppUpdateInfoCubit().fromJson({
          'version': '1.0.0',
          'releaseNotes': '- Initial release',
        }),
        const AppUpdateInfo(
          version: '1.0.0',
          releaseNotes: '- Initial release',
        ),
      ),
    );

    test(
      'returns null',
      () => expect(
        AppUpdateInfoCubit().fromJson({}),
        isNull,
      ),
    );
  });

  group('toJson', () {
    test(
      'returns correctly',
      () => expect(
        AppUpdateInfoCubit().toJson(
          const AppUpdateInfo(
            version: '1.0.0',
            releaseNotes: '- Initial release',
          ),
        ),
        {
          'version': '1.0.0',
          'releaseNotes': '- Initial release',
        },
      ),
    );

    test(
      'returns null.',
      () => expect(AppUpdateInfoCubit().toJson(null), isNull),
    );
  });
}
