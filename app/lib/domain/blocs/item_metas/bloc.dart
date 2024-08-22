import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/injector.dart';

part 'base_item/bloc.dart';
part 'event.dart';
part 'full_item/bloc.dart';
part 'state.dart';

sealed class ItemMetasBloc extends Bloc<ItemMetasEvent, ItemMetasState> {
  ItemMetasBloc(this._loadItemMetas) : super(const ItemMetasLoadInProgress()) {
    on<ItemMetasInitializeEvent>(
      _onItemMetasInitializeEvent,
      transformer: droppable(),
    );
  }

  final Future<List<ItemMeta>> Function(LanguageCode) _loadItemMetas;
  @protected
  static final localDatabaseAPI = Injector.instance.localDatabaseAPI;

  Future<void> _onItemMetasInitializeEvent(
    ItemMetasInitializeEvent event,
    Emitter<ItemMetasState> emit,
  ) async {
    final items = await _loadItemMetas(Injector.instance.languageCode);
    emit(ItemMetasLoadOnSuccess(items));
  }
}
