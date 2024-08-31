import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    on<ItemDetailUpdateThemeDataEvent>(
      _onItemDetailUpdateThemeDataEvent,
      transformer: restartable(),
    );
  }

  final Future<Item> Function(String, LanguageCode) _loadItemDetail;
  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _themeApi = Injector.instance.themeApi;

  Future<void> _onItemDetailInitializeEvent(
    ItemDetailInitializeEvent event,
    Emitter<ItemDetailState> emit,
  ) async {
    final (item, themeData) = await (
      _loadItemDetail(
        event.id,
        Injector.instance.languageCode,
      ),
      _themeApi.computeThemeFromFileImage(
        fileName: event.id,
        brightness: event.brightness,
        textTheme: event.textTheme,
      ),
    ).wait;

    emit(
      ItemDetailLoadOnSuccess<Item>(
        item: item,
        themeData: themeData,
      ),
    );
  }

  Future<void> _onItemDetailUpdateThemeDataEvent(
    ItemDetailUpdateThemeDataEvent event,
    Emitter<ItemDetailState> emit,
  ) async {
    if (state case ItemDetailLoadOnSuccess<Item>(:final item)) {
      emit(const ItemDetailLoadInProgress());
      final themeData = await _themeApi.computeThemeFromFileImage(
        fileName: item.id,
        brightness: event.brightness,
        textTheme: event.textTheme,
      );

      emit(
        ItemDetailLoadOnSuccess<Item>(
          item: item,
          themeData: themeData,
        ),
      );
    }
  }
}
