import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/old/item.dart';
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
    final items = await [
      _itemsAPI.loadBaseItems(),
      _itemsAPI.loadFullItems(),
    ].wait;
    emit(
      ItemsLoadOnSuccess(
        baseItems: items.first.cast<BaseItem>(),
        fullItems: items[1].cast<FullItem>(),
      ),
    );
  }
}
