import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';

abstract interface class LocalDatabaseApi {
  const LocalDatabaseApi();

  Future<void> initialize();

  Future<DateTime?> loadLatestBaseItemUpdatedAt();

  Future<DateTime?> loadLatestFullItemUpdatedAt();

  Future<DateTime?> loadLatestPatchNoteUpdatedAt();

  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt();

  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt();

  Future<DateTime?> loadLatestPatchNoteTranslationUpdatedAt();

  Future<void> saveBaseItems(List<BaseItemEntity> items);

  Future<void> saveFullItems(List<FullItemEntity> items);

  Future<void> savePatchNotes(List<PatchNoteEntity> patchNotes);

  Future<void> saveBaseItemTranslations(
    List<BaseItemTranslationEntity> translations,
  );

  Future<void> saveFullItemTranslations(
    List<FullItemTranslationEntity> translations,
  );

  Future<void> savePatchNoteTranslations(
    List<PatchNoteTranslationEntity> translations,
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

  Future<PaginatedPatchNotes> loadPatchNotes({
    required int currentPage,
    required int pageSize,
    required LanguageCode languageCode,
  });

  Future<int> loadBaseItemsCount();

  Future<int> loadFullItemsCount();

  Future<int> loadPatchNotesCount();

  Future<int> loadBaseItemTranslationsCount();

  Future<int> loadFullItemTranslationsCount();

  Future<int> loadPatchNoteTranslationsCount();

  Future<void> clear();

  Future<void> close();
}
