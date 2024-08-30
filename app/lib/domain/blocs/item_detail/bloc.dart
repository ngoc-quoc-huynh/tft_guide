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
  }

  final Future<Item> Function(String, LanguageCode) _loadItemDetail;
  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _fileStorageApi = Injector.instance.fileStorageApi;

  Future<void> _onItemDetailInitializeEvent(
    ItemDetailInitializeEvent event,
    Emitter<ItemDetailState> emit,
  ) async {
    final (item, colorScheme) = await (
      _loadItemDetail(
        event.id,
        Injector.instance.languageCode,
      ),
      // TODO: Extract this method to infrastructure for easier testing
      ColorScheme.fromImageProvider(
        provider: FileImage(
          _fileStorageApi.loadFile(event.id),
        ),
        brightness: event.brightness,
      ),
    ).wait;
    final themeData = ThemeData.from(
      colorScheme: colorScheme,
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
