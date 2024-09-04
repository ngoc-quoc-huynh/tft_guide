import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'models.dart';
part 'state.dart';

final class DataSyncBloc extends Bloc<DataSyncEvent, DataSyncState> {
  DataSyncBloc() : super(const DataSyncCheckInProgress()) {
    on<DataSyncInitializeEvent>(_onDataInitializeEvent);
  }

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  // TODO: Error handling
  Future<void> _onDataInitializeEvent(
    DataSyncInitializeEvent event,
    Emitter<DataSyncState> emit,
  ) async {
    // TODO: Check if we already updated today
    await _check(emit);
    await _initSync(emit);
    final operationResults = await _loadLatestUpdatedAts(emit);
    final items = await _loadRemoteData(emit, operationResults);
    await _storeDataLocally(emit, items);
    emit(const DataSyncLoadOnSuccess());
  }

  Future<void> _check(Emitter<DataSyncState> emit) async {
    emit(const DataSyncCheckInProgress(1));
  }

  // ignore: avoid-redundant-async, false positive
  Future<void> _initSync(Emitter<DataSyncState> emit) async {
    emit(const DataSyncInitInProgress());
    final initStream = Stream.fromFutures([
      _localDatabaseApi.initialize(),
      _remoteDatabaseApi.initialize(),
    ]);
    int step = 1;
    await for (final _ in initStream) {
      emit(DataSyncInitInProgress(step++));
    }
  }

  Future<List<_SyncOperationResult>> _loadLatestUpdatedAts(
    Emitter<DataSyncState> emit,
  ) {
    emit(const DataSyncLoadLatestUpdatedAtInProgress());
    final operations = [
      _SyncOperation(
        loadLatestUpdatedAt: _fileStorageApi.loadLatestFileUpdatedAt(),
        loadData: _remoteDatabaseApi.loadAssetsNames,
        storeData: (val) => _downloadAssets(val as List<String>),
      ),
      _SyncOperation(
        loadLatestUpdatedAt: _localDatabaseApi.loadLatestBaseItemUpdatedAt(),
        loadData: _remoteDatabaseApi.loadBaseItems,
        storeData: (val) =>
            _localDatabaseApi.storeBaseItems(val as List<BaseItemEntity>),
      ),
      _SyncOperation(
        loadLatestUpdatedAt: _localDatabaseApi.loadLatestFullItemUpdatedAt(),
        loadData: _remoteDatabaseApi.loadFullItems,
        storeData: (val) =>
            _localDatabaseApi.storeFullItems(val as List<FullItemEntity>),
      ),
      _SyncOperation(
        loadLatestUpdatedAt:
            _localDatabaseApi.loadLatestBaseItemTranslationUpdatedAt(),
        loadData: _remoteDatabaseApi.loadBaseItemTranslations,
        storeData: (val) => _localDatabaseApi
            .storeBaseItemTranslations(val as List<BaseItemTranslationEntity>),
      ),
      _SyncOperation(
        loadLatestUpdatedAt:
            _localDatabaseApi.loadLatestFullItemTranslationUpdatedAt(),
        loadData: _remoteDatabaseApi.loadFullItemTranslations,
        storeData: (val) => _localDatabaseApi
            .storeFullItemTranslations(val as List<FullItemTranslationEntity>),
      ),
    ];

    int step = 1;
    final stream = Stream.fromIterable(operations).asyncMap(
      (operation) async {
        final lastUpdate = await operation.loadLatestUpdatedAt;
        emit(DataSyncLoadLatestUpdatedAtInProgress(step++));
        return _SyncOperationResult(
          loadData: operation.loadData,
          storeData: operation.storeData,
          latestUpdatedAt: lastUpdate,
        );
      },
    );

    return stream.toList();
  }

  Future<List<_SyncItem>> _loadRemoteData(
    Emitter<DataSyncState> emit,
    List<_SyncOperationResult> operationResults,
  ) {
    emit(const DataSyncLoadRemoteDataInProgress());

    int step = 1;
    final stream = Stream.fromIterable(operationResults).asyncMap(
      (operation) async {
        final result = await operation.loadData(operation.latestUpdatedAt);
        emit(DataSyncLoadRemoteDataInProgress(step++));
        return _SyncItem(
          result: result,
          storeData: operation.storeData,
        );
      },
    );
    return stream.toList();
  }

  // ignore: avoid-redundant-async, false positive
  Future<void> _storeDataLocally(
    Emitter<DataSyncState> emit,
    List<_SyncItem> items,
  ) async {
    emit(const DataSyncStoreDataLocallyInProgress());

    final stream = Stream.fromIterable(items).asyncMap(
      (item) => item.storeData(item.result),
    );
    int step = 1;
    await for (final _ in stream) {
      emit(DataSyncStoreDataLocallyInProgress(step++));
    }
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
