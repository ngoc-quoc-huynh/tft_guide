import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(const ItemsLoadInProgress()) {
    on<ItemsInitializeEvent>(_onItemsInitializeEvent);
  }

  final _itemsRepository = Injector.instance.itemsRepository;

  Future<void> _onItemsInitializeEvent(
    ItemsInitializeEvent event,
    Emitter<ItemsState> emit,
  ) async {
    final items = (await [
      _itemsRepository.loadBaseItems(),
      _itemsRepository.loadFullItems(),
    ].wait)
        .flattened
        .toList();
    emit(ItemsLoadOnSuccess(items));
  }
}
