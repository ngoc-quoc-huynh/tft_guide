import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

part 'event.dart';
part 'state.dart';

final class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc() : super(const RepairInitial()) {
    on<RepairStartEvent>(_onRepairStartEvent);
  }

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  Future<void> _onRepairStartEvent(
    RepairStartEvent event,
    Emitter<RepairState> emit,
  ) async {
    emit(const RepairInitial());

    try {
      final [
        assetNames,
        baseItems,
        fullItems,
        patchNotes,
        baseItemTranslations,
        fullItemTranslations,
        patchNoteTranslations,
      ] = await _loadRemoteData(emit);
      await _storeDataLocally(
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
    } on Exception {
      emit(RepairLoadOnFailure(state.progress));
    }
  }

  Future<List<Object>> _loadRemoteData(Emitter<RepairState> emit) {
    emit(const RepairLoadRemoteDataInProgress());
    final operations = [
      () => _remoteDatabaseApi.loadAssetNames(null),
      () => _remoteDatabaseApi.loadBaseItems(null),
      () => _remoteDatabaseApi.loadFullItems(null),
      () => _remoteDatabaseApi.loadPatchNotes(null),
      () => _remoteDatabaseApi.loadBaseItemTranslations(null),
      () => _remoteDatabaseApi.loadFullItemTranslations(null),
      () => _remoteDatabaseApi.loadPatchNoteTranslations(null),
    ];

    int step = 1;
    final futures = operations.map((loadData) async {
      final data = await loadData();
      emit(RepairLoadRemoteDataInProgress(step++));
      return data;
    });

    return Future.wait(
      futures,
      eagerError: true,
    );
  }

  Future<void> _storeDataLocally({
    required Emitter<RepairState> emit,
    required List<String> assetNames,
    required List<BaseItemEntity> baseItems,
    required List<FullItemEntity> fullItems,
    required List<PatchNoteEntity> patchNotes,
    required List<BaseItemTranslationEntity> baseItemTranslations,
    required List<FullItemTranslationEntity> fullItemTranslations,
    required List<PatchNoteTranslationEntity> patchNoteTranslations,
  }) async {
    emit(const RepairStoreDataLocallyInProgress());
    final operations = [
      () => _downloadAssets(assetNames),
      () => _localDatabaseApi.storeBaseItems(baseItems),
      () => _localDatabaseApi.storeFullItems(fullItems),
      () => _localDatabaseApi.storePatchNotes(patchNotes),
      () => _localDatabaseApi.storeBaseItemTranslations(baseItemTranslations),
      () => _localDatabaseApi.storeFullItemTranslations(fullItemTranslations),
      () => _localDatabaseApi.storePatchNoteTranslations(patchNoteTranslations),
    ];

    int step = 1;
    final futures = operations.map((storeData) async {
      await storeData();
      emit(RepairStoreDataLocallyInProgress(step++));
    });

    await Future.wait(
      futures,
      eagerError: true,
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
