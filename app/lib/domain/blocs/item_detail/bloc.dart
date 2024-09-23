import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart' hide TranslationsEn;

part 'base_item/bloc.dart';
part 'event.dart';
part 'full_item/bloc.dart';
part 'state.dart';

sealed class ItemDetailBloc<Item extends ItemDetail>
    extends Bloc<ItemDetailEvent, ItemDetailState> with BlocMixin {
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
    on<ItemDetailUpdateLanguageCodeEvent>(
      _onItemDetailUpdateLocaleEvent,
      transformer: restartable(),
    );
  }

  final Future<Item> Function(String, LanguageCode) _loadItemDetail;

  static final _themeApi = Injector.instance.themeApi;
  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onItemDetailInitializeEvent(
    ItemDetailInitializeEvent event,
    Emitter<ItemDetailState> emit,
  ) async =>
      executeSafely(
        methodName: 'ItemDetailBloc._onItemDetailInitializeEvent',
        function: () async {
          final [item, themeData] = await Future.wait(
            [
              _loadItemDetail(
                event.id,
                Injector.instance.languageCode,
              ),
              _themeApi.computeThemeFromFileImage(
                fileName: event.id,
                brightness: event.brightness,
                textTheme: event.textTheme,
              ),
            ],
            eagerError: true,
          );

          emit(
            ItemDetailLoadOnSuccess<Item>(
              item: item! as Item,
              themeData: themeData as ThemeData?,
            ),
          );
        },
        onError: () => emit(const ItemDetailLoadOnFailure()),
      );

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

  Future<void> _onItemDetailUpdateLocaleEvent(
    ItemDetailUpdateLanguageCodeEvent event,
    Emitter<ItemDetailState> emit,
  ) async {
    if (state
        case ItemDetailLoadOnSuccess<Item>(:final item, :final themeData)) {
      await executeSafely(
        methodName: 'ItemDetailBloc._onItemDetailUpdateLocaleEvent',
        function: () async {
          emit(const ItemDetailLoadInProgress());

          final newItem = await _loadItemDetail(
            item.id,
            event.languageCode,
          );

          emit(
            ItemDetailLoadOnSuccess<Item>(
              item: newItem,
              themeData: themeData,
            ),
          );
        },
        onError: () => emit(const ItemDetailLoadOnFailure()),
      );
    }
  }
}
