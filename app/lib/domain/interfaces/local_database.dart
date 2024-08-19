import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/item_detail.dart';

abstract interface class LocalDatabaseAPI {
  const LocalDatabaseAPI();

  Future<LocalDatabaseAPI> initialize();

  Future<DateTime?> loadLatestBaseItemUpdatedAt();

  Future<DateTime?> loadLatestFullItemUpdatedAt();

  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt();

  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt();

  Future<void> storeBaseItems(List<BaseItemEntity> items);

  Future<void> storeFullItems(List<FullItemEntity> items);

  Future<void> storeBaseItemTranslations(
    List<BaseItemTranslationEntity> translations,
  );

  Future<void> storeFullItemTranslations(
    List<FullItemTranslationEntity> translations,
  );

  Future<BaseItemDetail> loadBaseItemDetail(String id);

  Future<FullItemDetail> loadFullItemDetail(String id);

  Future<List<BaseItemDetail>> loadBaseItemDetails();

  Future<List<FullItemDetail>> loadFullItemDetails();

  Future<void> close();
}
