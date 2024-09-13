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
part 'models.dart';
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
    final items = await _loadRemoteData(emit);
    await _storeDataLocally(emit, items);
    await _waitForProgressBarAnimation(emit);
    emit(const RepairLoadOnSuccess());
  }

  Future<List<_RepairItem>> _loadRemoteData(Emitter<RepairState> emit) {
    emit(const RepairLoadRemoteDataInProgress());
    final operations = [
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadAssetsNames,
        storeData: (val) => _downloadAssets(val as List<String>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadBaseItems,
        storeData: (val) =>
            _localDatabaseApi.storeBaseItems(val as List<BaseItemEntity>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadFullItems,
        storeData: (val) =>
            _localDatabaseApi.storeFullItems(val as List<FullItemEntity>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadPatchNotes,
        storeData: (val) =>
            _localDatabaseApi.storePatchNotes(val as List<PatchNoteEntity>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadBaseItemTranslations,
        storeData: (val) => _localDatabaseApi
            .storeBaseItemTranslations(val as List<BaseItemTranslationEntity>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadFullItemTranslations,
        storeData: (val) => _localDatabaseApi
            .storeFullItemTranslations(val as List<FullItemTranslationEntity>),
      ),
      _RepairOperation(
        loadData: _remoteDatabaseApi.loadPatchNoteTranslations,
        storeData: (val) => _localDatabaseApi.storePatchNoteTranslations(
          val as List<PatchNoteTranslationTranslationEntity>,
        ),
      ),
    ];

    int step = 1;
    final stream = Stream.fromIterable(operations).asyncMap((operation) async {
      final result = await operation.loadData(null);
      emit(RepairLoadRemoteDataInProgress(step++));
      return _RepairItem(result: result, storeData: operation.storeData);
    });
    return stream.toList();
  }

  // ignore: avoid-redundant-async, false positive
  Future<void> _storeDataLocally(
    Emitter<RepairState> emit,
    List<_RepairItem> items,
  ) async {
    emit(const RepairStoreDataLocallyInProgress());
    final stream = Stream.fromIterable(items).asyncMap(
      (item) => item.storeData(item.result),
    );
    int step = 1;
    await for (final _ in stream) {
      emit(RepairStoreDataLocallyInProgress(step++));
    }
  }

  Future<void> _waitForProgressBarAnimation(Emitter<RepairState> emit) async {
    emit(const RepairAnimationInProgress());
    await Future<void>.delayed(
      Sizes.progressBarAnimationShortDuration,
    );
  }

  Future<void> _downloadAssets(List<String> assetNames) async {
    Future<void> downloadAsset(String name) async {
      final asset = await _remoteDatabaseApi.loadAsset(name);
      await _fileStorageApi.save(name, asset);
    }

    await assetNames.map(downloadAsset).wait;
  }
}
