import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/init/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final dataSyncBloc = MockDataSyncBloc();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<NativeApi>(MockNativeApi()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<NativeApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'page',
    builder: () => GoldenTestGroup(
      scenarioConstraints: pageConstraints(),
      children: [
        GoldenTestScenario.builder(
          name: 'InitInProgress',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncInitInProgress(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'LoadLatestUpdatedAtInProgress',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncLoadLatestUpdatedAtInProgress(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'LoadRemoteDataInProgress',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncLoadRemoteDataInProgress(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'SaveDataLocallyInProgress',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncSaveDataLocallyInProgress(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'AnimationInProgress',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncAnimationInProgress(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'LoadOnSuccess',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncLoadOnSuccess(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'InitOnFailure',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncInitOnFailure(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
        GoldenTestScenario.builder(
          name: 'LocalDatabaseOnFailure',
          builder: (_) {
            whenListen<DataSyncState>(
              dataSyncBloc,
              const Stream<DataSyncState>.empty(),
              initialState: const DataSyncLocalDatabaseOnFailure(),
            );
            return _TestWidget(dataSyncBloc);
          },
        ),
      ],
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget(this.dataSyncBloc);

  final DataSyncBloc dataSyncBloc;

  @override
  Widget build(BuildContext context) => BlocProvider<DataSyncBloc>.value(
        value: dataSyncBloc,
        child: const InitPage(),
      );
}
