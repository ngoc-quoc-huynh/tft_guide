import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/domain/models/question_item_option.dart';

abstract interface class LocalDatabaseApi {
  const LocalDatabaseApi();

  Future<LocalDatabaseApi> initialize();

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

  Future<BaseItemDetail> loadBaseItemDetail(
    String id,
    LanguageCode languageCode,
  );

  Future<FullItemDetail> loadFullItemDetail(
    String id,
    LanguageCode languageCode,
  );

  Future<List<BaseItemMeta>> loadBaseItemMetas(LanguageCode languageCode);

  Future<List<FullItemMeta>> loadFullItemMetas(LanguageCode languageCode);

  Future<List<QuestionBaseItemOption>> loadRandomQuestionBaseItemOptions(
    int amount,
    LanguageCode languageCode,
  );

  Future<List<QuestionFullItemOption>> loadRandomQuestionFullItemOptions(
    int amount,
    LanguageCode languageCode,
  );

  Future<List<QuestionBaseItemOption>> loadOtherRandomQuestionBaseItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  );

  Future<List<QuestionFullItemOption>> loadOtherRandomQuestionFullItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  );

  Future<void> close();
}
