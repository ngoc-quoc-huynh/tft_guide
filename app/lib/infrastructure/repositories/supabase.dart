import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item_translation.dart';

// TODO: Error handling
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
  Future<List<BaseItemTranslationEntity>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  ) async {
    final response =
        await _client.from('base_item_translation').select().maybeApply(
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
        await _client.from('full_item_translation').select().maybeApply(
              lastUpdated,
              (query, lastUpdated) => query.gt('updated_at', lastUpdated),
            );

    return response
        .map((json) => FullItemTranslation.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<List<BaseItemEntity>> loadBaseItems(DateTime? lastUpdated) async {
    final response = await _client.from('base_item').select().maybeApply(
          lastUpdated,
          (query, lastUpdated) => query.gt('updated_at', lastUpdated),
        );
    return response.map((json) => BaseItem.fromJson(json).toDomain()).toList();
  }

  @override
  Future<List<FullItemEntity>> loadFullItems(DateTime? lastUpdated) async {
    final response = await _client.from('full_item').select().maybeApply(
          lastUpdated,
          (query, lastUpdated) => query.gt('updated_at', lastUpdated),
        );
    return response.map((json) => FullItem.fromJson(json).toDomain()).toList();
  }

  @override
  Future<void> close() => _client.dispose();
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
