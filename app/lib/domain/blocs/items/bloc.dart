import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item_preview.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(const ItemsLoadInProgress()) {
    on<ItemsInitializeEvent>(_onItemsInitializeEvent);
  }

  final _itemsAPI = Injector.instance.itemsAPI;

  Future<void> _onItemsInitializeEvent(
    ItemsInitializeEvent event,
    Emitter<ItemsState> emit,
  ) async {
    final baseItems = await _itemsAPI.loadBaseItems();
    final fullItems = await _itemsAPI.loadFullItems();
    emit(ItemsLoadOnSuccess(baseItems: baseItems, fullItems: fullItems));
  }
}
