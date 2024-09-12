import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note_translation.dart';

// TODO: Error handling & refactor
final class SupabaseRepository implements RemoteDatabaseApi {
  const SupabaseRepository();

  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<void> initialize() => Supabase.initialize(
        url: const String.fromEnvironment('url'),
        anonKey: const String.fromEnvironment('anon_key'),
        debug: false,
      );

  @override
  Future<List<String>> loadAssetsNames(DateTime? lastUpdated) async {
    final assets = await _client.rpc<List<dynamic>>(
      'load_asset_names',
      params: {'last_updated': lastUpdated?.toIso8601String()},
    );
    return assets.cast<String>();
  }

  @override
  Future<Uint8List> loadAsset(String name) =>
      _client.storage.from('assets').download(name);

  @override
  Future<List<BaseItemEntity>> loadBaseItems(DateTime? lastUpdated) async {
    final response = await _client.from(_tableNameBaseItem).select().maybeApply(
          lastUpdated,
          (query, lastUpdated) => query.gt('updated_at', lastUpdated),
        );
    return response.map((json) => BaseItem.fromJson(json).toDomain()).toList();
  }

  @override
  Future<List<FullItemEntity>> loadFullItems(DateTime? lastUpdated) async {
    final response = await _client.from(_tableNameFullItem).select().maybeApply(
          lastUpdated,
          (query, lastUpdated) => query.gt('updated_at', lastUpdated),
        );
    return response.map((json) => FullItem.fromJson(json).toDomain()).toList();
  }

  @override
  Future<List<PatchNoteEntity>> loadPatchNotes(DateTime? lastUpdated) async {
    final response =
        await _client.from(_tableNamePatchNote).select().maybeApply(
              lastUpdated,
              (query, lastUpdated) => query.gt('updated_at', lastUpdated),
            );
    return response.map((json) => PatchNote.fromJson(json).toDomain()).toList();
  }

  @override
  Future<List<BaseItemTranslationEntity>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  ) async {
    final response =
        await _client.from(_tableNameBaseItemTranslation).select().maybeApply(
              lastUpdated,
              (query, lastUpdated) => query.gt('updated_at', lastUpdated),
            );
    return response
        .map((json) => BaseItemTranslation.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<List<FullItemTranslationEntity>> loadFullItemTranslations(
    DateTime? lastUpdated,
  ) async {
    final response =
        await _client.from(_tableNameFullItemTranslation).select().maybeApply(
              lastUpdated,
              (query, lastUpdated) => query.gt('updated_at', lastUpdated),
            );

    return response
        .map((json) => FullItemTranslation.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<List<PatchNoteTranslationTranslationEntity>> loadPatchNoteTranslations(
    DateTime? lastUpdated,
  ) async {
    final response =
        await _client.from(_tableNamePatchNoteTranslation).select().maybeApply(
              lastUpdated,
              (query, lastUpdated) => query.gt('updated_at', lastUpdated),
            );

    return response
        .map((json) => PatchNoteTranslation.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<int> loadAssetsCount() => _client.rpc<int>('load_assets_count');

  @override
  Future<int> loadBaseItemsCount() => _client.from(_tableNameBaseItem).count();

  @override
  Future<int> loadFullItemsCount() => _client.from(_tableNameFullItem).count();

  @override
  Future<int> loadPatchNotesCount() =>
      _client.from(_tableNamePatchNote).count();

  @override
  Future<int> loadBaseItemTranslationsCount() =>
      _client.from(_tableNameBaseItemTranslation).count();

  @override
  Future<int> loadFullItemTranslationsCount() =>
      _client.from(_tableNameFullItemTranslation).count();

  @override
  Future<int> loadPatchNoteTranslationsCount() =>
      _client.from(_tableNamePatchNoteTranslation).count();

  @override
  Future<void> close() => _client.dispose();
  static const _tableNameBaseItem = 'base_item';
  static const _tableNameFullItem = 'full_item';
  static const _tableNamePatchNote = 'patch_note';
  static const _tableNameBaseItemTranslation = 'base_item_translation';
  static const _tableNameFullItemTranslation = 'full_item_translation';
  static const _tableNamePatchNoteTranslation = 'patch_note_translation';
}

extension<T> on PostgrestFilterBuilder<T> {
  PostgrestFilterBuilder<T> maybeApply<V>(
    V? value,
    PostgrestFilterBuilder<T> Function(
      PostgrestFilterBuilder<T>,
      V,
    ) apply,
  ) =>
      switch (value) {
        null => this,
        V() => apply(this, value),
      };
}
