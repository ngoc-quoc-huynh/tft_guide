import 'package:tft_guide/infrastructure/models/sqlite_async/item.dart';
import 'package:tft_guide/infrastructure/models/sqlite_async/item_translation.dart';

abstract interface class LocalDatabaseAPI {
  const LocalDatabaseAPI();

  Future<LocalDatabaseAPI> initialize();

  Future<DateTime?> loadLatestBaseItemUpdatedAt();

  Future<DateTime?> loadLatestFullItemUpdatedAt();

  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt();

  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt();

  Future<void> storeBaseItems(List<BaseItem> items);

  Future<void> storeFullItems(List<FullItem> items);

  Future<void> storeBaseItemTranslations(
    List<BaseItemTranslation> translations,
  );

  Future<void> storeFullItemTranslations(
    List<FullItemTranslation> translations,
  );

  Future<void> close();
}
