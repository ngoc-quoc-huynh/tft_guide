import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/domain/utils/extensions/future.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

part 'event.dart';
part 'state.dart';

final class RepairBloc extends Bloc<RepairEvent, RepairState> with BlocMixin {
  RepairBloc() : super(const RepairInitial()) {
    on<RepairStartEvent>(
      _onRepairStartEvent,
      transformer: droppable(),
    );
  }

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  Future<void> _onRepairStartEvent(
    RepairStartEvent event,
    Emitter<RepairState> emit,
  ) =>
      executeSafely(
        methodName: 'RepairBloc._onRepairStartEvent',
        function: () async {
          await _clearLocalData(emit);
          final [
            assetNames,
            baseItems,
            fullItems,
            patchNotes,
            baseItemTranslations,
            fullItemTranslations,
            patchNoteTranslations,
          ] = await _loadRemoteData(emit);
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
          await _waitForProgressBarAnimation(emit);

          emit(const RepairLoadOnSuccess());
        },
        onError: () => emit(RepairLoadOnFailure(state.progress)),
      );

  Future<void> _clearLocalData(Emitter<RepairState> emit) {
    emit(const RepairClearLocalDataInProgress());

    return FutureExtension.runParallel(
      [_fileStorageApi.clear, _localDatabaseApi.clear],
      onProgress: (progress) {
        emit(RepairClearLocalDataInProgress(progress + 1));
      },
    );
  }

  Future<List<Object>> _loadRemoteData(Emitter<RepairState> emit) {
    emit(const RepairLoadRemoteDataInProgress());
    final tasks = [
      () => _remoteDatabaseApi.loadAssetNames(null),
      () => _remoteDatabaseApi.loadBaseItems(null),
      () => _remoteDatabaseApi.loadFullItems(null),
      () => _remoteDatabaseApi.loadPatchNotes(null),
      () => _remoteDatabaseApi.loadBaseItemTranslations(null),
      () => _remoteDatabaseApi.loadFullItemTranslations(null),
      () => _remoteDatabaseApi.loadPatchNoteTranslations(null),
    ];

    return FutureExtension.runParallel(
      tasks,
      onProgress: (progress) =>
          emit(RepairLoadRemoteDataInProgress(progress + 1)),
    );
  }

  Future<void> _saveDataLocally({
    required Emitter<RepairState> emit,
    required List<String> assetNames,
    required List<BaseItemEntity> baseItems,
    required List<FullItemEntity> fullItems,
    required List<PatchNoteEntity> patchNotes,
    required List<BaseItemTranslationEntity> baseItemTranslations,
    required List<FullItemTranslationEntity> fullItemTranslations,
    required List<PatchNoteTranslationEntity> patchNoteTranslations,
  }) async {
    emit(const RepairSaveDataLocallyInProgress());
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
          emit(RepairSaveDataLocallyInProgress(progress + 1)),
    );
  }

  Future<void> _waitForProgressBarAnimation(Emitter<RepairState> emit) async {
    emit(const RepairAnimationInProgress());
    await Future<void>.delayed(Sizes.progressBarAnimationShortDuration);
  }

  Future<void> _downloadAssets(List<String> assetNames) async {
    Future<void> downloadAsset(String name) async {
      final asset = await _remoteDatabaseApi.loadAsset(name);
      await _fileStorageApi.save(name, asset);
    }

    await Future.wait(
      assetNames.map(downloadAsset),
      eagerError: true,
    );
  }
}
