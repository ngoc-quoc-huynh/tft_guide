import 'dart:typed_data';

import 'package:tft_guide/domain/models/item_translation.dart';

abstract interface class RemoteDatabaseAPI {
  const RemoteDatabaseAPI();

  Future<RemoteDatabaseAPI> initialize();

  Future<List<String>> loadAssetsNames(DateTime? lastUpdated);

  Future<Uint8List> loadAsset(String name);

  Future<List<BaseItemTranslation>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  );

  Future<List<FullItemTranslation>> loadFullItemTranslations(
    DateTime? lastUpdated,
  );
}
