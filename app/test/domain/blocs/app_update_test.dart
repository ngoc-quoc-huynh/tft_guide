import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/app_update/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final appApi = MockAppApi();

  setUpAll(
    () => Injector.instance.registerSingleton<AppApi>(appApi),
  );

  tearDownAll(Injector.instance.unregister<AppApi>);

  test(
    'initial state is AppUpdateInitial',
    () => expect(
      AppUpdateBloc('1.0.0').state,
      const AppUpdateInitial(),
    ),
  );

  group('AppUpdateInitializeEvent', () {
    blocTest<AppUpdateBloc, AppUpdateState>(
      'emits AppUpdateLoadOnSuccess.',
      build: () => AppUpdateBloc('1.0.0'),
      setUp: () => when(
        () => appApi.downloadAppUpdate(
          '1.0.0',
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenAnswer((invocation) {
        final onReceiveProgress =
            invocation.namedArguments[const Symbol('onReceiveProgress')] as void
                Function(int, int);
        onReceiveProgress(50, 100);
        onReceiveProgress(100, 100);
        return Future.value('app.apk');
      }),
      act: (bloc) => bloc.add(const AppUpdateInitializeEvent()),
      expect: () => const [
        AppUpdateLoadInProgress(0),
        AppUpdateLoadInProgress(50),
        AppUpdateLoadInProgress(100),
        AppUpdateLoadOnSuccess('app.apk'),
      ],
      verify: (_) => verify(
        () => appApi.downloadAppUpdate(
          '1.0.0',
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).called(1),
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      'emits AppUpdateLoadOnFailure when an error occurs.',
      build: () => AppUpdateBloc('1.0.0'),
      setUp: () => when(
        () => appApi.downloadAppUpdate(
          '1.0.0',
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenThrow(const UnknownException()),
      act: (bloc) => bloc.add(const AppUpdateInitializeEvent()),
      expect: () => const [
        AppUpdateLoadInProgress(0),
        AppUpdateLoadOnFailure(),
      ],
      verify: (_) => verify(
        () => appApi.downloadAppUpdate(
          '1.0.0',
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).called(1),
    );
  });
}
