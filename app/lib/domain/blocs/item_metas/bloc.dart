import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class ItemMetasBloc extends Bloc<ItemMetasEvent, ItemMetasState> {
  ItemMetasBloc() : super(const ItemMetasLoadInProgress()) {
    on<ItemMetasInitializeEvent>(
      _onItemMetasInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _localDatabaseAPI = Injector.instance.localDatabaseAPI;

  Future<void> _onItemMetasInitializeEvent(
    ItemMetasInitializeEvent event,
    Emitter<ItemMetasState> emit,
  ) async {
    final languageCode = Injector.instance.languageCode;
    final (baseItems, fullItems) = await (
      _localDatabaseAPI.loadBaseItemMetas(languageCode),
      _localDatabaseAPI.loadFullItemMetas(languageCode),
    ).wait;
    emit(ItemMetasLoadOnSuccess([...baseItems, ...fullItems]));
  }
}
