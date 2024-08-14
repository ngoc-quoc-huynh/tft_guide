import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';

final class SupabaseRepository implements RemoteDatabaseAPI {
  const SupabaseRepository();

  static final _client = Supabase.instance.client;

  @override
  Future<SupabaseRepository> initialize() async {
    await Supabase.initialize(
      // TODO: Extract these as variables
      url: 'https://desyhvpvijfqxftogtis.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRlc3lodnB2aWpmcXhmdG9ndGlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA5Njc2ODAsImV4cCI6MjAzNjU0MzY4MH0.AImzdKJW6dUMLbvSPtHsa5zL7KF-apr6lX6_RjKJQiI',
    );
    return this;
  }

  @override
  Future<List<String>> loadUpdatedAssets(DateTime? lastUpdated) async {
    final assets = await _client.rpc('load_updated_assets', params: {
      'last_updated': lastUpdated?.toIso8601String(),
    });
    return assets.cast<String>();
  }

  @override
  Future<Uint8List> loadAsset(String name) {
    return _client.storage.from('assets').download(name);
  }
}
