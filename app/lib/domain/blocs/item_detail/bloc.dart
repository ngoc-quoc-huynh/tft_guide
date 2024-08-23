import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';

part 'base_item/bloc.dart';

part 'base_item/state.dart';

part 'event.dart';

part 'full_item/bloc.dart';

part 'full_item/state.dart';

part 'state.dart';

sealed class ItemDetailBloc<Item extends ItemDetail>
    extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc(this._loadItemDetail)
      : super(const ItemDetailLoadInProgress()) {
    on<ItemDetailInitializeEvent>(
      _onItemDetailInitializeEvent,
      transformer: droppable(),
    );
  }

  final Future<Item> Function(String, LanguageCode) _loadItemDetail;
  @protected
  static final localDatabaseAPI = Injector.instance.localDatabaseAPI;

  Future<void> _onItemDetailInitializeEvent(
    ItemDetailInitializeEvent event,
    Emitter<ItemDetailState> emit,
  ) async {
    final item = await _loadItemDetail(
      event.id,
      Injector.instance.languageCode,
    );
    emit(ItemDetailLoadOnSuccess<Item>(item));
  }
}
