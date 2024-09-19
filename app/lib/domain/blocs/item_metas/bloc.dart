import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class ItemMetasBloc extends Bloc<ItemMetasEvent, ItemMetasState>
    with BlocMixin {
  ItemMetasBloc() : super(const ItemMetasLoadInProgress()) {
    on<ItemMetasInitializeEvent>(
      _onItemMetasInitializeEvent,
      transformer: droppable(),
    );
    on<ItemMetasUpdateLanguageEvent>(
      _onItemMetasUpdateLanguageEvent,
      transformer: restartable(),
    );
  }

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onItemMetasInitializeEvent(
    ItemMetasInitializeEvent event,
    Emitter<ItemMetasState> emit,
  ) =>
      executeSafely(
        methodName: 'ItemMetasBloc._onItemMetasInitializeEvent',
        function: () async {
          final languageCode = Injector.instance.languageCode;
          final [baseItems, fullItems] = await Future.wait(
            [
              _localDatabaseApi.loadBaseItemMetas(languageCode),
              _localDatabaseApi.loadFullItemMetas(languageCode),
            ],
            eagerError: true,
          );
          emit(ItemMetasLoadOnSuccess([...baseItems, ...fullItems]));
        },
        onError: () => emit(const ItemMetasLoadOnFailure()),
      );

  Future<void> _onItemMetasUpdateLanguageEvent(
    ItemMetasUpdateLanguageEvent event,
    Emitter<ItemMetasState> emit,
  ) async =>
      executeSafely(
        methodName: 'ItemMetasBloc._onItemMetasUpdateLanguageEvent',
        function: () async {
          emit(const ItemMetasLoadInProgress());
          final languageCode = event.languageCode;
          final (baseItems, fullItems) = await (
            _localDatabaseApi.loadBaseItemMetas(languageCode),
            _localDatabaseApi.loadFullItemMetas(languageCode),
          ).wait;
          emit(ItemMetasLoadOnSuccess([...baseItems, ...fullItems]));
        },
        onError: () => emit(const ItemMetasLoadOnFailure()),
      );
}
