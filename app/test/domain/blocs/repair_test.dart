import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/repair/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

import '../../mocks.dart';
import '../../utils.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final fileStorageApi = MockFileStorageApi();
  final localDatabaseApi = MockLocalDatabaseApi();
  final remoteDatabaseApi = MockRemoteDatabaseApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileStorageApi>(fileStorageApi)
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<RemoteDatabaseApi>(remoteDatabaseApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<FileStorageApi>()
      ..unregister<LocalDatabaseApi>()
      ..unregister<RemoteDatabaseApi>(),
  );

  test(
    'initial state is RepairInitial',
    () => expect(
      RepairBloc().state,
      const RepairInitial(),
    ),
  );

  group('RepairStartEvent', () {
    blocTest<RepairBloc, RepairState>(
      'emits RepairLoadOnSuccess.',
      setUp: () {
        _mockClearLocalData(fileStorageApi, localDatabaseApi);
        _mockLoadRemoteData(remoteDatabaseApi);
        _mockSaveDataLocally(localDatabaseApi);
      },
      build: RepairBloc.new,
      act: (bloc) => bloc.add(const RepairStartEvent()),
      wait: Sizes.progressBarAnimationShortDuration.withThreshold,
      expect: () => const [
        RepairClearLocalDataInProgress(),
        RepairClearLocalDataInProgress(1),
        RepairClearLocalDataInProgress(2),
        RepairLoadRemoteDataInProgress(),
        RepairLoadRemoteDataInProgress(1),
        RepairLoadRemoteDataInProgress(2),
        RepairLoadRemoteDataInProgress(3),
        RepairLoadRemoteDataInProgress(4),
        RepairLoadRemoteDataInProgress(5),
        RepairLoadRemoteDataInProgress(6),
        RepairLoadRemoteDataInProgress(7),
        RepairSaveDataLocallyInProgress(),
        RepairSaveDataLocallyInProgress(1),
        RepairSaveDataLocallyInProgress(2),
        RepairSaveDataLocallyInProgress(3),
        RepairSaveDataLocallyInProgress(4),
        RepairSaveDataLocallyInProgress(5),
        RepairSaveDataLocallyInProgress(6),
        RepairSaveDataLocallyInProgress(7),
        RepairAnimationInProgress(),
        RepairLoadOnSuccess(),
      ],
      verify: (_) => verifyInOrder(
        [
          fileStorageApi.clear,
          localDatabaseApi.clear,
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
        ],
      ),
    );

    blocTest<RepairBloc, RepairState>(
      'emits RepairLoadOnFailure when loading remote data fails.',
      setUp: () {
        _mockClearLocalData(fileStorageApi, localDatabaseApi);
        _mockLoadRemoteData(remoteDatabaseApi, shouldThrow: true);
        _mockSaveDataLocally(localDatabaseApi);
      },
      build: RepairBloc.new,
      act: (bloc) => bloc.add(const RepairStartEvent()),
      expect: () => const [
        RepairClearLocalDataInProgress(),
        RepairClearLocalDataInProgress(1),
        RepairClearLocalDataInProgress(2),
        RepairLoadRemoteDataInProgress(),
        RepairLoadOnFailure(33),
      ],
      verify: (_) {
        verifyInOrder(
          [
            fileStorageApi.clear,
            localDatabaseApi.clear,
            () => remoteDatabaseApi.loadAssetNames(null),
            () => remoteDatabaseApi.loadBaseItems(null),
            () => remoteDatabaseApi.loadFullItems(null),
            () => remoteDatabaseApi.loadPatchNotes(null),
            () => remoteDatabaseApi.loadBaseItemTranslations(null),
            () => remoteDatabaseApi.loadFullItemTranslations(null),
            () => remoteDatabaseApi.loadPatchNoteTranslations(null),
          ],
        );
        verifyNoMoreInteractions(localDatabaseApi);
      },
    );

    blocTest<RepairBloc, RepairState>(
      'emits RepairLoadOnFailure when saving data locally fails.',
      setUp: () {
        _mockClearLocalData(fileStorageApi, localDatabaseApi);
        _mockLoadRemoteData(remoteDatabaseApi);
        _mockSaveDataLocally(localDatabaseApi, shouldThrow: true);
      },
      build: RepairBloc.new,
      act: (bloc) => bloc.add(const RepairStartEvent()),
      expect: () => const [
        RepairClearLocalDataInProgress(),
        RepairClearLocalDataInProgress(1),
        RepairClearLocalDataInProgress(2),
        RepairLoadRemoteDataInProgress(),
        RepairLoadRemoteDataInProgress(1),
        RepairLoadRemoteDataInProgress(2),
        RepairLoadRemoteDataInProgress(3),
        RepairLoadRemoteDataInProgress(4),
        RepairLoadRemoteDataInProgress(5),
        RepairLoadRemoteDataInProgress(6),
        RepairLoadRemoteDataInProgress(7),
        RepairSaveDataLocallyInProgress(),
        RepairLoadOnFailure(66),
      ],
      verify: (_) {
        verifyInOrder(
          [
            fileStorageApi.clear,
            localDatabaseApi.clear,
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
          ],
        );
      },
    );
  });
}

void _mockClearLocalData(
  MockFileStorageApi fileStorageApi,
  MockLocalDatabaseApi localDatabaseApi,
) {
  when(fileStorageApi.clear).thenAnswer((_) => Future.value());
  when(localDatabaseApi.clear).thenAnswer((_) => Future.value());
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
