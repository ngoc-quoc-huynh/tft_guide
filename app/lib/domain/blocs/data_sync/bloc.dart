import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';
import 'package:tft_guide/domain/utils/extensions/future.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

part 'event.dart';
part 'state.dart';

@visibleForTesting
base mixin TestDataSyncBlocMixin implements DataSyncBloc {}

final class DataSyncBloc extends Bloc<DataSyncEvent, DataSyncState>
    with BlocMixin {
  DataSyncBloc() : super(const DataSyncInitInProgress()) {
    on<DataSyncInitializeEvent>(
      _onDataInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;
  static final _localStorageApi = Injector.instance.localStorageApi;

  Future<void> _onDataInitializeEvent(
    DataSyncInitializeEvent event,
    Emitter<DataSyncState> emit,
  ) async {
    const methodName = 'DataSyncBloc._onDataInitializeEvent';

    final initSuccessfully = await executeSafely(
      methodName: methodName,
      function: () => _initSync(emit),
      onError: () => emit(const DataSyncInitOnFailure()),
    );
    if (!initSuccessfully) {
      return;
    }

    final hasUpdated = _hasAppBeenUpdatedToday(emit);
    if (!hasUpdated) {
      DateTime? assetsLatestUpDatedAt;
      DateTime? baseItemsLatestUpdatedAt;
      DateTime? fullItemsLatestUpdatedAt;
      DateTime? patchNotesLatestUpdatedAt;
      DateTime? baseItemTranslationsLatestUpdatedAt;
      DateTime? fullItemTranslationsLatestUpdatedAt;
      DateTime? patchNoteTranslationsLatestUpdatedAt;

      final updateLatestAtsSuccessfully = await executeSafely(
        methodName: methodName,
        function: () async {
          [
            assetsLatestUpDatedAt,
            baseItemsLatestUpdatedAt,
            fullItemsLatestUpdatedAt,
            patchNotesLatestUpdatedAt,
            baseItemTranslationsLatestUpdatedAt,
            fullItemTranslationsLatestUpdatedAt,
            patchNoteTranslationsLatestUpdatedAt
          ] = await _loadLatestUpdatedAts(emit);
        },
        onError: () => emit(const DataSyncLocalDatabaseOnFailure()),
      );
      if (!updateLatestAtsSuccessfully) {
        return;
      }

      await executeSafely(
        methodName: methodName,
        function: () async {
          final [
            assetNames,
            baseItems,
            fullItems,
            patchNotes,
            baseItemTranslations,
            fullItemTranslations,
            patchNoteTranslations,
          ] = await _loadRemoteData(
            emit: emit,
            latestFileUpdatedAt: assetsLatestUpDatedAt,
            latestBaseItemUpdatedAt: baseItemsLatestUpdatedAt,
            latestFullItemUpdatedAt: fullItemsLatestUpdatedAt,
            latestPatchNoteUpdatedAt: patchNotesLatestUpdatedAt,
            latestBaseItemTranslationUpdatedAt:
                baseItemTranslationsLatestUpdatedAt,
            latestFullItemTranslationUpdatedAt:
                fullItemTranslationsLatestUpdatedAt,
            latestPatchNoteTranslationUpdatedAt:
                patchNoteTranslationsLatestUpdatedAt,
          );

          await _saveDataLocally(
            emit: emit,
            assetNames: assetNames as List<String>,
            baseItems: baseItems as List<BaseItemEntity>,
            fullItems: fullItems as List<FullItemEntity>,
            patchNotes: patchNotes as List<PatchNoteEntity>,
            baseItemTranslations:
                baseItemTranslations as List<BaseItemTranslationEntity>,
            fullItemTranslations:
                fullItemTranslations as List<FullItemTranslationEntity>,
            patchNoteTranslations:
                patchNoteTranslations as List<PatchNoteTranslationEntity>,
          );
          await _localStorageApi.updateLastRemoteDataUpdate(clock.now());
        },
        onError: () => emit(const DataSyncLoadAndSaveOnFailure()),
      );
    }

    await _waitForProgressBarAnimation(emit, hasUpdated: hasUpdated);
    emit(const DataSyncLoadOnSuccess());
  }

  Future<void> _waitForProgressBarAnimation(
    Emitter<DataSyncState> emit, {
    required bool hasUpdated,
  }) async {
    emit(const DataSyncAnimationInProgress());
    await Future<void>.delayed(
      switch (hasUpdated) {
        false => Sizes.progressBarAnimationShortDuration,
        true => Sizes.progressBarAnimationLongDuration,
      },
    );
  }

  bool _hasAppBeenUpdatedToday(Emitter<DataSyncState> emit) {
    emit(const DataSyncCheckInProgress());
    final hasUpdatedToday =
        _localStorageApi.lastRemoteDataUpdate?.isToday ?? false;
    emit(const DataSyncCheckInProgress(1));

    return hasUpdatedToday;
  }

  // ignore: avoid-redundant-async, false positive
  Future<void> _initSync(Emitter<DataSyncState> emit) async {
    final tasks = [
      _localDatabaseApi.initialize,
      _remoteDatabaseApi.initialize,
    ];

    await FutureExtension.runParallel(
      tasks,
      onProgress: (progress) => emit(DataSyncInitInProgress(progress + 1)),
    );
  }

  Future<List<DateTime?>> _loadLatestUpdatedAts(
    Emitter<DataSyncState> emit,
  ) async {
    emit(const DataSyncLoadLatestUpdatedAtInProgress());

    final latestFileUpdatedAt = _fileStorageApi.loadLatestFileUpdatedAt();
    emit(const DataSyncLoadLatestUpdatedAtInProgress(1));

    final operations = [
      _localDatabaseApi.loadLatestBaseItemUpdatedAt,
      _localDatabaseApi.loadLatestFullItemUpdatedAt,
      _localDatabaseApi.loadLatestPatchNoteUpdatedAt,
      _localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt,
      _localDatabaseApi.loadLatestFullItemTranslationUpdatedAt,
      _localDatabaseApi.loadLatestPatchNoteTranslationUpdatedAt,
    ];
    final latestUpdatedAts = await FutureExtension.runParallel(
      operations,
      onProgress: (progress) =>
          emit(DataSyncLoadLatestUpdatedAtInProgress(progress + 2)),
    );

    return [latestFileUpdatedAt, ...latestUpdatedAts];
  }

  Future<List<Object>> _loadRemoteData({
    required Emitter<DataSyncState> emit,
    required DateTime? latestFileUpdatedAt,
    required DateTime? latestBaseItemUpdatedAt,
    required DateTime? latestFullItemUpdatedAt,
    required DateTime? latestPatchNoteUpdatedAt,
    required DateTime? latestBaseItemTranslationUpdatedAt,
    required DateTime? latestFullItemTranslationUpdatedAt,
    required DateTime? latestPatchNoteTranslationUpdatedAt,
  }) {
    emit(const DataSyncLoadRemoteDataInProgress());
    final tasks = [
      () => _remoteDatabaseApi.loadAssetNames(latestFileUpdatedAt),
      () => _remoteDatabaseApi.loadBaseItems(latestBaseItemUpdatedAt),
      () => _remoteDatabaseApi.loadFullItems(latestFullItemUpdatedAt),
      () => _remoteDatabaseApi.loadPatchNotes(latestPatchNoteUpdatedAt),
      () => _remoteDatabaseApi
          .loadBaseItemTranslations(latestBaseItemTranslationUpdatedAt),
      () => _remoteDatabaseApi
          .loadFullItemTranslations(latestFullItemTranslationUpdatedAt),
      () => _remoteDatabaseApi
          .loadPatchNoteTranslations(latestPatchNoteTranslationUpdatedAt),
    ];

    return FutureExtension.runParallel(
      tasks,
      onProgress: (progress) =>
          emit(DataSyncLoadRemoteDataInProgress(progress + 1)),
    );
  }

  // ignore: avoid-redundant-async, false positive
  Future<void> _saveDataLocally({
    required Emitter<DataSyncState> emit,
    required List<String> assetNames,
    required List<BaseItemEntity> baseItems,
    required List<FullItemEntity> fullItems,
    required List<PatchNoteEntity> patchNotes,
    required List<BaseItemTranslationEntity> baseItemTranslations,
    required List<FullItemTranslationEntity> fullItemTranslations,
    required List<PatchNoteTranslationEntity> patchNoteTranslations,
  }) async {
    emit(const DataSyncSaveDataLocallyInProgress());
    final tasks = [
      () => _downloadAssets(assetNames),
      () => _localDatabaseApi.saveBaseItems(baseItems),
      () => _localDatabaseApi.saveFullItems(fullItems),
      () => _localDatabaseApi.savePatchNotes(patchNotes),
      () => _localDatabaseApi.saveBaseItemTranslations(baseItemTranslations),
      () => _localDatabaseApi.saveFullItemTranslations(fullItemTranslations),
      () => _localDatabaseApi.savePatchNoteTranslations(patchNoteTranslations),
    ];
    await FutureExtension.runParallel(
      tasks,
      onProgress: (progress) =>
          emit(DataSyncSaveDataLocallyInProgress(progress + 1)),
    );
  }

  Future<void> _downloadAssets(List<String> assetNames) async {
    Future<void> downloadAsset(String name) async {
      final asset = await _remoteDatabaseApi.loadAsset(name);
      await _fileStorageApi.save(name, asset);
    }

    await assetNames.map(downloadAsset).wait;
  }

  @override
  Future<void> close() async {
    await [
      _localDatabaseApi.close(),
      _remoteDatabaseApi.close(),
    ].wait;
    return super.close();
  }
}
