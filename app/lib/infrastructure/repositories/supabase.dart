import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/models/item_translation.dart' as domain;
import 'package:tft_guide/infrastructure/models/supabase/item_translation.dart';

// TODO: Error handling
final class SupabaseRepository implements RemoteDatabaseAPI {
  const SupabaseRepository();

  static final _client = Supabase.instance.client;

  @override
  Future<SupabaseRepository> initialize() async {
    await Supabase.initialize(
      // TODO: Extract these as variables
      url: 'https://desyhvpvijfqxftogtis.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI'
          '6ImRlc3lodnB2aWpmcXhmdG9ndGlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA'
          '5Njc2ODAsImV4cCI6MjAzNjU0MzY4MH0.AImzdKJW6dUMLbvSPtHsa5zL7KF-apr'
          '6lX6_RjKJQiI',
    );
    return this;
  }

  @override
  Future<List<String>> loadUpdatedAssets(DateTime? lastUpdated) async {
    final assets = await _client.rpc<List<dynamic>>(
      'load_updated_assets',
      params: {'last_updated': lastUpdated?.toIso8601String()},
    );
    return assets.cast<String>();
  }

  @override
  Future<Uint8List> loadAsset(String name) {
    return _client.storage.from('assets').download(name);
  }

  @override
  Future<List<domain.BaseItemTranslation>> loadBaseItemTranslations() async {
    final response = await _client.from('base_item_translation').select();
    return response
        .map(BaseItemTranslation.fromJson)
        .map((translation) => translation.toDomain())
        .toList();
  }

  @override
  Future<List<domain.FullItemTranslation>> loadFullItemTranslations() async {
    final response = await _client.from('full_item_translation').select();
    return response
        .map(FullItemTranslation.fromJson)
        .map((translation) => translation.toDomain())
        .toList();
  }
}
