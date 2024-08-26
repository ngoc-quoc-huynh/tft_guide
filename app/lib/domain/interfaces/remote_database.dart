import 'dart:typed_data';

import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';

abstract interface class RemoteDatabaseApi {
  const RemoteDatabaseApi();

  Future<RemoteDatabaseApi> initialize();

  Future<List<String>> loadAssetsNames(DateTime? lastUpdated);

  Future<Uint8List> loadAsset(String name);

  Future<List<BaseItemEntity>> loadBaseItems(DateTime? lastUpdated);

  Future<List<FullItemEntity>> loadFullItems(DateTime? lastUpdated);

  Future<List<BaseItemTranslationEntity>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  );

  Future<List<FullItemTranslationEntity>> loadFullItemTranslations(
    DateTime? lastUpdated,
  );

  Future<void> close();
}
