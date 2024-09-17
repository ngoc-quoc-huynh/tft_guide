import 'dart:typed_data';

import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';

abstract interface class RemoteDatabaseApi {
  const RemoteDatabaseApi();

  Future<void> initialize();

  Future<List<String>> loadAssetNames(DateTime? lastUpdated);

  Future<Uint8List> loadAsset(String name);

  Future<List<BaseItemEntity>> loadBaseItems(DateTime? lastUpdated);

  Future<List<FullItemEntity>> loadFullItems(DateTime? lastUpdated);

  Future<List<PatchNoteEntity>> loadPatchNotes(DateTime? lastUpdated);

  Future<List<BaseItemTranslationEntity>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  );

  Future<List<FullItemTranslationEntity>> loadFullItemTranslations(
    DateTime? lastUpdated,
  );

  Future<List<PatchNoteTranslationEntity>> loadPatchNoteTranslations(
    DateTime? lastUpdated,
  );

  Future<int> loadAssetsCount();

  Future<int> loadBaseItemsCount();

  Future<int> loadFullItemsCount();

  Future<int> loadPatchNotesCount();

  Future<int> loadBaseItemTranslationsCount();

  Future<int> loadFullItemTranslationsCount();

  Future<int> loadPatchNoteTranslationsCount();

  Future<void> close();
}
