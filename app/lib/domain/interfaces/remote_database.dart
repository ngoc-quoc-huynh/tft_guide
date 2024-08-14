import 'dart:typed_data';

abstract interface class RemoteDatabaseAPI {
  const RemoteDatabaseAPI();

  Future<RemoteDatabaseAPI> initialize();

  Future<List<String>> loadUpdatedAssets(DateTime? lastUpdated);

  Future<Uint8List> loadAsset(String name);
}
