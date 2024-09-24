import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

import '../../mocks.dart';
import '../../utils.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.
// ignore_for_file: missing-test-assertion, it is not possible to use blocTest
// with Clock.

void main() {
  final fileStorageApi = MockFileStorageApi();
  final localDatabaseApi = MockLocalDatabaseApi();
  final remoteDatabaseApi = MockRemoteDatabaseApi();
  final localStorageApi = MockLocalStorageApi();
  final date = DateTime(2024).toUtc();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileStorageApi>(fileStorageApi)
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<RemoteDatabaseApi>(remoteDatabaseApi)
      ..registerSingleton<LocalStorageApi>(localStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<FileStorageApi>()
      ..unregister<LocalDatabaseApi>()
      ..unregister<RemoteDatabaseApi>()
      ..unregister<LocalStorageApi>(),
  );

  test(
    'initial state is DataSyncCheckInProgress.',
    () => expect(
      DataSyncBloc().state,
      const DataSyncInitInProgress(),
    ),
  );

  group('DataSyncInitializeEvent', () {
    test(
      'emits DataSyncLoadOnSuccess when the app has not been updated today.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi);
            _mockLatestUpdatedAt(fileStorageApi, localDatabaseApi);
            _mockLoadRemoteData(remoteDatabaseApi);
            _mockSaveDataLocally(localDatabaseApi);
            _mockUpdateLastAppUpdate(localStorageApi);
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(1),
            DataSyncLoadLatestUpdatedAtInProgress(2),
            DataSyncLoadLatestUpdatedAtInProgress(3),
            DataSyncLoadLatestUpdatedAtInProgress(4),
            DataSyncLoadLatestUpdatedAtInProgress(5),
            DataSyncLoadLatestUpdatedAtInProgress(6),
            DataSyncLoadRemoteDataInProgress(),
            DataSyncLoadRemoteDataInProgress(1),
            DataSyncLoadRemoteDataInProgress(2),
            DataSyncLoadRemoteDataInProgress(3),
            DataSyncLoadRemoteDataInProgress(4),
            DataSyncLoadRemoteDataInProgress(5),
            DataSyncLoadRemoteDataInProgress(6),
            DataSyncSaveDataLocallyInProgress(),
            DataSyncSaveDataLocallyInProgress(1),
            DataSyncSaveDataLocallyInProgress(2),
            DataSyncSaveDataLocallyInProgress(3),
            DataSyncSaveDataLocallyInProgress(4),
            DataSyncSaveDataLocallyInProgress(5),
            DataSyncSaveDataLocallyInProgress(6),
            DataSyncAnimationInProgress(),
            DataSyncLoadOnSuccess(),
          ],
          wait: Sizes.progressBarAnimationShortDuration.withThreshold,
          verify: (_) => verifyInOrder(
            [
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              fileStorageApi.loadLatestFileUpdatedAt,
              localDatabaseApi.loadLatestBaseItemUpdatedAt,
              localDatabaseApi.loadLatestFullItemUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteUpdatedAt,
              localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
              () => remoteDatabaseApi.loadAssetNames(null),
              () => remoteDatabaseApi.loadBaseItems(null),
              () => remoteDatabaseApi.loadFullItems(null),
              () => remoteDatabaseApi.loadPatchNotes(null),
              () => remoteDatabaseApi.loadBaseItemTranslations(null),
              () => remoteDatabaseApi.loadFullItemTranslations(null),
              () => remoteDatabaseApi.loadPatchNoteTranslations(null),
              () => localDatabaseApi.saveBaseItems([]),
              () => localDatabaseApi.saveFullItems([]),
              () => localDatabaseApi.savePatchNotes([]),
              () => localDatabaseApi.saveBaseItemTranslations([]),
              () => localDatabaseApi.saveFullItemTranslations([]),
              () => localDatabaseApi.savePatchNoteTranslations([]),
              () => localStorageApi.updateLastAppUpdate(date),
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ],
          ),
        ),
      ),
    );

    test(
      'emits DataSyncLoadOnSuccess when the app has been updated today.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi, date);
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncAnimationInProgress(),
            DataSyncLoadOnSuccess(),
          ],
          wait: Sizes.progressBarAnimationLongDuration.withThreshold,
          verify: (_) => verifyInOrder(
            [
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ],
          ),
        ),
      ),
    );

    blocTest<DataSyncBloc, DataSyncState>(
      'emits DataSyncInitOnFailure when initializing fails.',
      setUp: () {
        _mockInitialize(
          localDatabaseApi,
          remoteDatabaseApi,
          shouldThrow: true,
        );
        _mockClose(localDatabaseApi, remoteDatabaseApi);
      },
      build: DataSyncBloc.new,
      act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
      expect: () => const [
        DataSyncInitInProgress(),
        DataSyncInitOnFailure(),
      ],
      verify: (_) {
        verifyInOrder([
          localDatabaseApi.initialize,
          localDatabaseApi.close,
          remoteDatabaseApi.close,
        ]);
        verifyZeroInteractions(fileStorageApi);
        verifyNoMoreInteractions(localDatabaseApi);
        verifyNoMoreInteractions(remoteDatabaseApi);
        verifyZeroInteractions(localStorageApi);
      },
    );

    test(
      'emits DataSyncLocalDatabaseOnFailure when loading latest updated at '
      'fails.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi);
            _mockLatestUpdatedAt(
              fileStorageApi,
              localDatabaseApi,
              shouldThrow: true,
            );
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(),
            DataSyncLocalDatabaseOnFailure(),
          ],
          verify: (_) {
            verifyInOrder([
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              fileStorageApi.loadLatestFileUpdatedAt,
              localDatabaseApi.loadLatestBaseItemUpdatedAt,
              localDatabaseApi.loadLatestFullItemUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteUpdatedAt,
              localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ]);
            verifyNoMoreInteractions(fileStorageApi);
            verifyNoMoreInteractions(localDatabaseApi);
            verifyNoMoreInteractions(remoteDatabaseApi);
            verifyNoMoreInteractions(localStorageApi);
          },
        ),
      ),
    );

    test(
      'emits DataSyncLocalDatabaseOnFailure when loading latest updated at '
      'fails.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi);
            _mockLatestUpdatedAt(
              fileStorageApi,
              localDatabaseApi,
              shouldThrow: true,
            );
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(),
            DataSyncLocalDatabaseOnFailure(),
          ],
          verify: (_) {
            verifyInOrder([
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              fileStorageApi.loadLatestFileUpdatedAt,
              localDatabaseApi.loadLatestBaseItemUpdatedAt,
              localDatabaseApi.loadLatestFullItemUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteUpdatedAt,
              localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ]);
            verifyNoMoreInteractions(fileStorageApi);
            verifyNoMoreInteractions(localDatabaseApi);
            verifyNoMoreInteractions(remoteDatabaseApi);
            verifyNoMoreInteractions(localStorageApi);
          },
        ),
      ),
    );

    test(
      'emits DataSyncLoadAndSaveOnFailure when loading remote data fails.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi);
            _mockLatestUpdatedAt(fileStorageApi, localDatabaseApi);
            _mockLoadRemoteData(remoteDatabaseApi, shouldThrow: true);
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(1),
            DataSyncLoadLatestUpdatedAtInProgress(2),
            DataSyncLoadLatestUpdatedAtInProgress(3),
            DataSyncLoadLatestUpdatedAtInProgress(4),
            DataSyncLoadLatestUpdatedAtInProgress(5),
            DataSyncLoadLatestUpdatedAtInProgress(6),
            DataSyncLoadRemoteDataInProgress(),
            DataSyncLoadAndSaveOnFailure(),
            DataSyncAnimationInProgress(),
          ],
          verify: (_) {
            verifyInOrder([
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              fileStorageApi.loadLatestFileUpdatedAt,
              localDatabaseApi.loadLatestBaseItemUpdatedAt,
              localDatabaseApi.loadLatestFullItemUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteUpdatedAt,
              localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
              () => remoteDatabaseApi.loadAssetNames(null),
              () => remoteDatabaseApi.loadBaseItems(null),
              () => remoteDatabaseApi.loadFullItems(null),
              () => remoteDatabaseApi.loadPatchNotes(null),
              () => remoteDatabaseApi.loadBaseItemTranslations(null),
              () => remoteDatabaseApi.loadFullItemTranslations(null),
              () => remoteDatabaseApi.loadPatchNoteTranslations(null),
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ]);
            verifyNoMoreInteractions(fileStorageApi);
            verifyNoMoreInteractions(localDatabaseApi);
            verifyNoMoreInteractions(localStorageApi);
          },
        ),
      ),
    );

    test(
      'emits DataSyncLoadAndSaveOnFailure when storing data locally fails.',
      () => withClock(
        Clock.fixed(date),
        () => testBloc<DataSyncBloc, DataSyncState>(
          setUp: () {
            _mockInitialize(localDatabaseApi, remoteDatabaseApi);
            _mockLastAppUpdate(localStorageApi);
            _mockLatestUpdatedAt(fileStorageApi, localDatabaseApi);
            _mockLoadRemoteData(remoteDatabaseApi);
            _mockSaveDataLocally(localDatabaseApi, shouldThrow: true);
            _mockClose(localDatabaseApi, remoteDatabaseApi);
          },
          build: DataSyncBloc.new,
          act: (bloc) => bloc.add(const DataSyncInitializeEvent()),
          expect: () => const [
            DataSyncInitInProgress(),
            DataSyncInitInProgress(1),
            DataSyncCheckInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(),
            DataSyncLoadLatestUpdatedAtInProgress(1),
            DataSyncLoadLatestUpdatedAtInProgress(2),
            DataSyncLoadLatestUpdatedAtInProgress(3),
            DataSyncLoadLatestUpdatedAtInProgress(4),
            DataSyncLoadLatestUpdatedAtInProgress(5),
            DataSyncLoadLatestUpdatedAtInProgress(6),
            DataSyncLoadRemoteDataInProgress(),
            DataSyncLoadRemoteDataInProgress(1),
            DataSyncLoadRemoteDataInProgress(2),
            DataSyncLoadRemoteDataInProgress(3),
            DataSyncLoadRemoteDataInProgress(4),
            DataSyncLoadRemoteDataInProgress(5),
            DataSyncLoadRemoteDataInProgress(6),
            DataSyncSaveDataLocallyInProgress(),
            DataSyncLoadAndSaveOnFailure(),
            DataSyncAnimationInProgress(),
          ],
          verify: (_) {
            verifyInOrder([
              localDatabaseApi.initialize,
              remoteDatabaseApi.initialize,
              () => localStorageApi.lastAppUpdate,
              fileStorageApi.loadLatestFileUpdatedAt,
              localDatabaseApi.loadLatestBaseItemUpdatedAt,
              localDatabaseApi.loadLatestFullItemUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteUpdatedAt,
              localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
              localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
              () => remoteDatabaseApi.loadAssetNames(null),
              () => remoteDatabaseApi.loadBaseItems(null),
              () => remoteDatabaseApi.loadFullItems(null),
              () => remoteDatabaseApi.loadPatchNotes(null),
              () => remoteDatabaseApi.loadBaseItemTranslations(null),
              () => remoteDatabaseApi.loadFullItemTranslations(null),
              () => remoteDatabaseApi.loadPatchNoteTranslations(null),
              () => localDatabaseApi.saveBaseItems([]),
              () => localDatabaseApi.saveFullItems([]),
              () => localDatabaseApi.savePatchNotes([]),
              () => localDatabaseApi.saveBaseItemTranslations([]),
              () => localDatabaseApi.saveFullItemTranslations([]),
              () => localDatabaseApi.savePatchNoteTranslations([]),
              localDatabaseApi.close,
              remoteDatabaseApi.close,
            ]);
            verifyNoMoreInteractions(fileStorageApi);
            verifyNoMoreInteractions(localStorageApi);
          },
        ),
      ),
    );
  });
}

void _mockInitialize(
  MockLocalDatabaseApi localDatabaseApi,
  MockRemoteDatabaseApi remoteDatabaseApi, {
  bool shouldThrow = false,
}) {
  if (!shouldThrow) {
    when(
      localDatabaseApi.initialize,
    ).thenAnswer((_) => Future.value());
    when(
      remoteDatabaseApi.initialize,
    ).thenAnswer((_) => Future.value());
  } else {
    when(
      localDatabaseApi.initialize,
    ).thenThrow(const UnknownException());
  }
}

void _mockLastAppUpdate(
  MockLocalStorageApi localStorageApi, [
  DateTime? lastAppUpdate,
]) =>
    when(
      () => localStorageApi.lastAppUpdate,
    ).thenAnswer((_) => lastAppUpdate);

void _mockLatestUpdatedAt(
  MockFileStorageApi fileStorageApi,
  MockLocalDatabaseApi localDatabaseApi, {
  bool shouldThrow = false,
}) {
  when(
    () => fileStorageApi.loadLatestFileUpdatedAt(),
  ).thenReturn(null);

  if (!shouldThrow) {
    when(
      localDatabaseApi.loadLatestBaseItemUpdatedAt,
    ).thenAnswer((_) async => null);
    when(
      localDatabaseApi.loadLatestFullItemUpdatedAt,
    ).thenAnswer((_) async => null);
    when(
      localDatabaseApi.loadLatestPatchNoteUpdatedAt,
    ).thenAnswer((_) async => null);
    when(
      localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
    ).thenAnswer((_) async => null);
    when(
      localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
    ).thenAnswer((_) async => null);
    when(
      localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
    ).thenAnswer((_) async => null);
  } else {
    when(
      localDatabaseApi.loadLatestBaseItemUpdatedAt,
    ).thenThrow(const UnknownException());
  }
}

void _mockLoadRemoteData(
  MockRemoteDatabaseApi remoteDatabaseApi, {
  bool shouldThrow = false,
}) {
  if (!shouldThrow) {
    when(
      () => remoteDatabaseApi.loadAssetNames(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadBaseItems(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadFullItems(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadPatchNotes(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadBaseItemTranslations(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadFullItemTranslations(null),
    ).thenAnswer((_) async => []);
    when(
      () => remoteDatabaseApi.loadPatchNoteTranslations(null),
    ).thenAnswer((_) async => []);
  } else {
    when(
      () => remoteDatabaseApi.loadAssetNames(null),
    ).thenThrow(const UnknownException());
  }
}

void _mockSaveDataLocally(
  MockLocalDatabaseApi localDatabaseApi, {
  bool shouldThrow = false,
}) {
  if (!shouldThrow) {
    when(
      () => localDatabaseApi.saveBaseItems([]),
    ).thenAnswer((_) => Future.value());
    when(
      () => localDatabaseApi.saveFullItems([]),
    ).thenAnswer((_) => Future.value());
    when(
      () => localDatabaseApi.savePatchNotes([]),
    ).thenAnswer((_) => Future.value());
    when(
      () => localDatabaseApi.saveBaseItemTranslations([]),
    ).thenAnswer((_) => Future.value());
    when(
      () => localDatabaseApi.saveFullItemTranslations([]),
    ).thenAnswer((_) => Future.value());
    when(
      () => localDatabaseApi.savePatchNoteTranslations([]),
    ).thenAnswer((_) => Future.value());
  } else {
    when(
      () => localDatabaseApi.saveBaseItems([]),
    ).thenThrow(const UnknownException());
  }
}

void _mockUpdateLastAppUpdate(
  MockLocalStorageApi localStorageApi,
) {
  when(
    () => localStorageApi.updateLastAppUpdate(DateTime(2024).toUtc()),
  ).thenAnswer((_) => Future.value());
}

void _mockClose(
  MockLocalDatabaseApi localDatabaseApi,
  MockRemoteDatabaseApi remoteDatabaseApi,
) {
  when(
    localDatabaseApi.close,
  ).thenAnswer((_) => Future.value());
  when(
    remoteDatabaseApi.close,
  ).thenAnswer((_) => Future.value());
}