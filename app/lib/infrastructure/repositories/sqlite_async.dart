import 'package:path/path.dart';
import 'package:sqlite_async/sqlite3.dart';
import 'package:sqlite_async/sqlite_async.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/exceptions/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/domain/models/item_detail.dart' as domain;
import 'package:tft_guide/domain/models/item_meta.dart' as domain;
import 'package:tft_guide/domain/models/patch_note.dart' as domain;
import 'package:tft_guide/domain/models/question/item_option.dart' as domain;
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_detail.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_meta.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/patch_note.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/question_item_option.dart';
import 'package:tft_guide/injector.dart';

final class SqliteAsyncRepository with LoggerMixin implements LocalDatabaseApi {
  SqliteAsyncRepository();

  final _db = SqliteDatabase(
    path: join(Injector.instance.appDir.path, 'test.db'),
  );

  @override
  Future<void> initialize() async {
    const methodName = 'SqliteAsyncRepository.initialize';

    try {
      final migrations = SqliteMigrations()
        ..createDatabase = _createDatabaseMigration
        ..add(_createDatabaseMigration);
      await migrations.migrate(_db);
      logInfo(
        methodName,
        'Initialized SQLite.',
        stackTrace: StackTrace.current,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestBaseItemUpdatedAt() async {
    const methodName = 'SqliteAsyncRepository.loadLatestBaseItemUpdatedAt';

    try {
      final updatedAt = await _loadLatestUpdatedAt(_tableNameBaseItem);
      logInfo(
        methodName,
        'Retrieved latest base item updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestFullItemUpdatedAt() async {
    const methodName = 'SqliteAsyncRepository.loadLatestFullItemUpdatedAt';

    try {
      final updatedAt = await _loadLatestUpdatedAt(_tableNameFullItem);
      logInfo(
        methodName,
        'Retrieved latest full item updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestPatchNoteUpdatedAt() async {
    const methodName = 'SqliteAsyncRepository.loadLatestPatchNoteUpdatedAt';

    try {
      final updatedAt = await _loadLatestUpdatedAt(_tableNamePatchNote);
      logInfo(
        methodName,
        'Retrieved latest patch note updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt() async {
    const methodName =
        'SqliteAsyncRepository.loadLatestBaseItemTranslationUpdatedAt';

    try {
      final updatedAt = await _loadLatestUpdatedAt(_tableNamePatchNote);
      logInfo(
        methodName,
        'Retrieved latest base item translation updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt() async {
    const methodName =
        'SqliteAsyncRepository.loadLatestFullItemTranslationUpdatedAt';

    try {
      final updatedAt =
          await _loadLatestUpdatedAt(_tableNameFullItemTranslation);
      logInfo(
        methodName,
        'Retrieved latest full item translation updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<DateTime?> loadLatestPatchNoteTranslationUpdatedAt() async {
    const methodName =
        'SqliteAsyncRepository.loadLatestPatchNoteTranslationUpdatedAt';

    try {
      final updatedAt =
          await _loadLatestUpdatedAt(_tableNamePatchNoteTranslation);
      logInfo(
        methodName,
        'Retrieved latest patch note translation updated at: '
        '${updatedAt?.toIso8601String()}.',
        stackTrace: StackTrace.current,
      );

      return updatedAt;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> storeBaseItems(List<BaseItemEntity> items) async {
    const methodName = 'SqliteAsyncRepository.storeBaseItems';
    final parameters = {'items': items.map((item) => item.id).join(',')};

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNameBaseItem (
    id,
    ability_power,
    armor,
    attack_damage,
    attack_speed,
    crit,
    health,
    magic_resist,
    mana,
    created_at,
    updated_at
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    ability_power = excluded.ability_power,
    armor = excluded.armor,
    attack_damage = excluded.attack_damage,
    attack_speed = excluded.attack_speed,
    crit = excluded.crit,
    health = excluded.health,
    magic_resist = excluded.magic_resist,
    mana = excluded.mana,
    updated_at = excluded.updated_at;
''',
        items
            .map(
              (item) => [
                item.id,
                item.abilityPower,
                item.armor,
                item.attackDamage,
                item.attackSpeed,
                item.crit,
                item.health,
                item.magicResist,
                item.mana,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${items.length} base items.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<void> storeFullItems(List<FullItemEntity> items) async {
    const methodName = 'SqliteAsyncRepository.storeFullItems';
    final parameters = {'items': items.map((item) => item.id).join(',')};

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNameFullItem (
    id,
    is_active,
    is_special,
    item_id_1,
    item_id_2,
    ability_power,
    armor,
    attack_damage,
    attack_speed,
    crit,
    health,
    magic_resist,
    mana,
    created_at,
    updated_at
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    is_active = excluded.is_active,
    ability_power = excluded.ability_power,
    armor = excluded.armor,
    attack_damage = excluded.attack_damage,
    attack_speed = excluded.attack_speed,
    crit = excluded.crit,
    health = excluded.health,
    magic_resist = excluded.magic_resist,
    mana = excluded.mana,
    updated_at = excluded.updated_at;
''',
        items
            .map(
              (item) => [
                item.id,
                item.isActive,
                item.isSpecial,
                item.itemId1,
                item.itemId2,
                item.abilityPower,
                item.armor,
                item.attackDamage,
                item.attackSpeed,
                item.crit,
                item.health,
                item.magicResist,
                item.mana,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${items.length} full items.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<void> storePatchNotes(List<PatchNoteEntity> patchNotes) async {
    const methodName = 'SqliteAsyncRepository.storePatchNotes';
    final parameters = {
      'patchNotes': patchNotes.map((patchNote) => patchNote.id).join(','),
    };

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNamePatchNote (
    id,
    created_at,
    updated_at
)
VALUES (?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    updated_at = excluded.updated_at;
''',
        patchNotes
            .map(
              (item) => [
                item.id,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${patchNotes.length} patch notes.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<void> storeBaseItemTranslations(
    List<BaseItemTranslationEntity> translations,
  ) async {
    const methodName = 'SqliteAsyncRepository.storeBaseItemTranslations';
    final parameters = {
      'translations':
          translations.map((translation) => translation.id).join(','),
    };

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNameBaseItemTranslation (
    id,
    item_id,
    language_code,
    name,
    description,
    hint,
    created_at,
    updated_at
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    name = excluded.name,
    description = excluded.description,
    hint = excluded.hint,
    updated_at = excluded.updated_at;
''',
        translations
            .map(
              (item) => [
                item.id,
                item.itemId,
                item.languageCode.name,
                item.name,
                item.description,
                item.hint,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${translations.length} base item translations.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<void> storeFullItemTranslations(
    List<FullItemTranslationEntity> translations,
  ) async {
    const methodName = 'SqliteAsyncRepository.storeFullItemTranslations';
    final parameters = {
      'translations':
          translations.map((translation) => translation.id).join(','),
    };

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNameFullItemTranslation (
    id,
    item_id,
    language_code,
    name,
    description,
    hint,
    created_at,
    updated_at
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    name = excluded.name,
    description = excluded.description,
    hint = excluded.hint,
    updated_at = excluded.updated_at;
''',
        translations
            .map(
              (item) => [
                item.id,
                item.itemId,
                item.languageCode.name,
                item.name,
                item.description,
                item.hint,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${translations.length} full item translations.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<void> storePatchNoteTranslations(
    List<PatchNoteTranslationEntity> translations,
  ) async {
    const methodName = 'SqliteAsyncRepository.storePatchNoteTranslations';
    final parameters = {
      'translations':
          translations.map((translation) => translation.id).join(','),
    };

    try {
      await _db.executeBatch(
        '''
INSERT INTO $_tableNamePatchNoteTranslation (
    id,
    patch_note_id,
    language_code,
    text,
    created_at,
    updated_at
)
VALUES (?, ?, ?, ?, ?, ?)
ON CONFLICT (id)
DO UPDATE SET
    text = excluded.text,
    updated_at = excluded.updated_at;
''',
        translations
            .map(
              (item) => [
                item.id,
                item.patchNoteId,
                item.languageCode.name,
                item.text,
                item.createdAt.toIso8601String(),
                item.updatedAt.toIso8601String(),
              ],
            )
            .toList(),
      );
      logInfo(
        methodName,
        'Stored ${translations.length} patch note translations.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<domain.BaseItemDetail> loadBaseItemDetail(
    String id,
    LanguageCode languageCode,
  ) async {
    const methodName = 'SqliteAsyncRepository.loadBaseItemDetail';
    final parameters = {
      'id': id,
      'languageCode': languageCode.toString(),
    };

    try {
      final json = await _db.getOrThrow(
        '''
SELECT b.id, 
       t.name, 
       t.description, 
       t.hint, 
       b.ability_power, 
       b.armor, 
       b.attack_damage, 
       b.attack_speed, 
       b.crit, 
       b.health, 
       b.magic_resist, 
       b.mana
FROM $_tableNameBaseItem AS b
LEFT JOIN $_tableNameBaseItemTranslation AS t 
       ON b.id = t.item_id 
       AND t.language_code = ?
WHERE b.id = ?;
''',
        [languageCode.name, id],
      );

      final item = BaseItemDetail.fromJson(json).toDomain();
      logInfo(
        methodName,
        'Loaded base item detail.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return item;
    } on ElementNotFoundException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<domain.FullItemDetail> loadFullItemDetail(
    String id,
    LanguageCode languageCode,
  ) async {
    const methodName = 'SqliteAsyncRepository.loadFullItemDetail';
    final parameters = {
      'id': id,
      'languageCode': languageCode.toString(),
    };

    try {
      final json = await _db.getOrThrow(
        '''
SELECT f.id, 
       t.name, 
       t.description, 
       t.hint, 
       f.item_id_1, 
       f.item_id_2, 
       f.ability_power, 
       f.armor, 
       f.attack_damage, 
       f.attack_speed, 
       f.crit, 
       f.health, 
       f.magic_resist, 
       f.mana
FROM $_tableNameFullItem AS f
LEFT JOIN $_tableNameFullItemTranslation AS t 
       ON f.id = t.item_id 
       AND t.language_code = ?
WHERE f.id = ?;
''',
        [languageCode.name, id],
      );

      final item = FullItemDetail.fromJson(json).toDomain();
      logInfo(
        methodName,
        'Loaded full item detail.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return item;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.BaseItemMeta>> loadBaseItemMetas(
    LanguageCode languageCode,
  ) async {
    const methodName = 'SqliteAsyncRepository.loadBaseItemMetas';
    final parameters = {'languageCode': languageCode.toString()};

    try {
      final result = await _db.getAll(
        '''
SELECT b.id, 
       t.name, 
       t.description, 
       b.ability_power, 
       b.armor, 
       b.attack_damage, 
       b.attack_speed, 
       b.crit, 
       b.health, 
       b.magic_resist, 
       b.mana
FROM $_tableNameBaseItem AS b
LEFT JOIN $_tableNameBaseItemTranslation AS t 
       ON b.id = t.item_id 
       AND t.language_code = ?
ORDER BY t.name ASC;
''',
        [languageCode.name],
      );
      final items =
          result.map((json) => BaseItemMeta.fromJson(json).toDomain()).toList();
      logInfo(
        methodName,
        'Loaded ${items.length} base item metas.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return items;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.FullItemMeta>> loadFullItemMetas(
    LanguageCode languageCode,
  ) async {
    const methodName = 'SqliteAsyncRepository.loadFullItemMetas';
    final parameters = {'languageCode': languageCode.toString()};

    try {
      final result = await _db.getAll(
        '''
SELECT f.id, 
       t.name
FROM $_tableNameFullItem AS f
LEFT JOIN $_tableNameFullItemTranslation AS t 
       ON f.id = t.item_id 
       AND t.language_code = ?
WHERE f.is_active
ORDER BY t.name ASC;
''',
        [languageCode.name],
      );
      final items =
          result.map((json) => FullItemMeta.fromJson(json).toDomain()).toList();
      logInfo(
        methodName,
        'Loaded ${items.length} full item metas.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return items;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.QuestionBaseItemOption>> loadRandomQuestionBaseItemOptions(
    int amount,
    LanguageCode languageCode,
  ) async {
    const methodName =
        'SqliteAsyncRepository.loadRandomQuestionBaseItemOptions';
    final parameters = {
      'amount': amount.toString(),
      'languageCode': languageCode.toString(),
    };

    try {
      final result = await _db.getAll(
        '''
SELECT b.id, t.name, t.description
FROM base_item AS b
LEFT JOIN base_item_translation AS t
       ON b.id = t.item_id
       AND t.language_code = ?
ORDER BY RANDOM()
LIMIT ?;
''',
        [languageCode.name, amount],
      );
      final options = result
          .map((json) => QuestionBaseItemOption.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded random question base item options: '
        '${options.map((option) => option.id)}.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return options;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.QuestionFullItemOption>> loadRandomQuestionFullItemOptions(
    int amount,
    LanguageCode languageCode,
  ) async {
    const methodName =
        'SqliteAsyncRepository.loadRandomQuestionFullItemOptions';
    final parameters = {
      'amount': amount.toString(),
      'languageCode': languageCode.toString(),
    };

    try {
      final result = await _db.getAll(
        '''
SELECT f.id, t.name, t.description, f.is_special, f.item_id_1, f.item_id_2
FROM full_item AS f
LEFT JOIN full_item_translation AS t
       ON f.id = t.item_id
       AND t.language_code = ?
WHERE f.is_active IS TRUE
ORDER BY RANDOM()
LIMIT ?;
''',
        [languageCode.name, amount],
      );
      final options = result
          .map((json) => QuestionFullItemOption.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded random question full item options: '
        '${options.map((option) => option.id)}.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return options;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.QuestionBaseItemOption>>
      loadOtherRandomQuestionBaseItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  ) async {
    const methodName =
        'SqliteAsyncRepository.loadOtherRandomQuestionBaseItemOptions';
    final parameters = {
      'id': id,
      'amount': amount.toString(),
      'languageCode': languageCode.toString(),
    };

    try {
      final result = await _db.getAll(
        '''
WITH random_item AS (
    SELECT id
    FROM base_item
    WHERE id != ?
    ORDER BY RANDOM()
    LIMIT ?
)

SELECT b.id, t.name, t.description
FROM base_item AS b
LEFT JOIN base_item_translation AS t
       ON b.id = t.item_id
       AND t.language_code = ?
WHERE b.id IN (SELECT id FROM random_item);
''',
        [id, amount, languageCode.name],
      );
      final options = result
          .map((json) => QuestionBaseItemOption.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded other random question base item options: '
        '${options.map((option) => option.id)}.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return options;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<domain.QuestionFullItemOption>>
      loadOtherRandomQuestionFullItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  ) async {
    const methodName =
        'SqliteAsyncRepository.loadOtherRandomQuestionFullItemOptions';
    final parameters = {
      'id': id,
      'amount': amount.toString(),
      'languageCode': languageCode.toString(),
    };

    try {
      final result = await _db.getAll(
        '''
WITH is_special AS (
    SELECT is_special
    FROM full_item
    WHERE id = ?
),
related_items AS (
    SELECT f1.*
    FROM full_item f1
    JOIN full_item f2
        ON f1.id != f2.id
        AND (
            f1.item_id_1 = f2.item_id_1
            OR f1.item_id_1 = f2.item_id_2
            OR f1.item_id_2 = f2.item_id_1
            OR f1.item_id_2 = f2.item_id_2
        )
    WHERE f2.id = ?
    AND f1.is_active IS TRUE
)

SELECT
    f.id,
    t.name,
    t.description,
    f.is_special,
    f.item_id_1,
    f.item_id_2
FROM (
    SELECT * FROM related_items
    WHERE (SELECT is_special FROM is_special) IS FALSE
    AND is_active IS TRUE
    
    UNION ALL

    SELECT *
    FROM full_item
    WHERE (SELECT is_special FROM is_special) IS TRUE
    AND is_active IS TRUE
) AS f
LEFT JOIN full_item_translation t
    ON f.id = t.item_id
    AND t.language_code = ?
WHERE f.id != ?
ORDER BY RANDOM()
LIMIT ?;
''',
        [id, id, languageCode.name, id, amount],
      );
      final options = result
          .map((json) => QuestionFullItemOption.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded other random question full item options: '
        '${options.map((option) => option.id)}.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return options;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<domain.PaginatedPatchNotes> loadPatchNotes({
    required int currentPage,
    required int pageSize,
    required LanguageCode languageCode,
  }) async {
    const methodName = 'SqliteAsyncRepository.loadPatchNotes';
    final parameters = {
      'currentPage': currentPage.toString(),
      'pageSize': pageSize.toString(),
      'languageCode': languageCode.toString(),
    };

    try {
      final count = await _loadCount(_tableNamePatchNote);
      final patchNotesResult = await _db.getAll(
        '''
SELECT t.text, p.created_at
FROM $_tableNamePatchNote AS p
LEFT JOIN 
    $_tableNamePatchNoteTranslation AS t
    ON p.id = t.patch_note_id
    AND t.language_code = ?
WHERE 
    p.oid NOT IN (
        SELECT p.oid 
        FROM $_tableNamePatchNote AS p
        ORDER BY p.created_at DESC
        LIMIT ?
    )
ORDER BY p.created_at DESC
LIMIT ?;
''',
        [
          languageCode.name,
          currentPage * pageSize,
          pageSize,
        ],
      );
      final paginatedPatchNotes = PaginatedPatchNotes.fromJson(
        pageSize: pageSize,
        count: count,
        patchNotesJson: patchNotesResult,
      ).toDomain();

      logInfo(
        methodName,
        'Loaded patch notes. '
        '${paginatedPatchNotes.patchNotes.map(
          (patchNote) => patchNote.createdAt,
        )}.',
        stackTrace: StackTrace.current,
        parameters: parameters,
      );

      return paginatedPatchNotes;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<int> loadBaseItemsCount() async {
    const methodName = 'SqliteAsyncRepository.loadBaseItemsCount';

    try {
      final count = await _loadCount(_tableNameBaseItem);
      logInfo(
        methodName,
        'Loaded base items count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadFullItemsCount() async {
    const methodName = 'SqliteAsyncRepository.loadFullItemsCount';

    try {
      final count = await _loadCount(_tableNameFullItem);
      logInfo(
        methodName,
        'Loaded full items count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadPatchNotesCount() async {
    const methodName = 'SqliteAsyncRepository.loadPatchNotesCount';

    try {
      final count = await _loadCount(_tableNamePatchNote);
      logInfo(
        methodName,
        'Loaded patch notes count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadBaseItemTranslationsCount() async {
    const methodName = 'SqliteAsyncRepository.loadBaseItemTranslationsCount';

    try {
      final count = await _loadCount(_tableNameBaseItemTranslation);
      logInfo(
        methodName,
        'Loaded base item translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadFullItemTranslationsCount() async {
    const methodName = 'SqliteAsyncRepository.loadFullItemTranslationsCount';

    try {
      final count = await _loadCount(_tableNameFullItemTranslation);
      logInfo(
        methodName,
        'Loaded full item translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadPatchNoteTranslationsCount() async {
    const methodName = 'SqliteAsyncRepository.loadPatchNoteTranslationsCount';

    try {
      final count = await _loadCount(_tableNamePatchNoteTranslation);
      logInfo(
        methodName,
        'Loaded patch note translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } on Exception catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> close() async {
    await _db.close();
    logInfo(
      'SqliteAsyncRepository.close',
      'Closed repository.',
      stackTrace: StackTrace.current,
    );
  }

  Never _handleException({
    required String methodName,
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) {
    final throwException = switch (exception) {
      ElementNotFoundException() => exception,
      _ => const UnknownException(),
    };

    logException(
      methodName,
      exception: exception,
      stackTrace: stackTrace,
      parameters: parameters,
    );
    throw throwException;
  }

  Future<DateTime?> _loadLatestUpdatedAt(String table) async {
    final result = await _db.get('SELECT MAX(updated_at) FROM $table');
    final updatedAt = result['MAX(updated_at)'] as String?;
    return switch (updatedAt) {
      null => null,
      String() => DateTime.parse(updatedAt),
    };
  }

  Future<int> _loadCount(String tableName) async {
    final result = await _db.get(
      '''
SELECT COUNT(id) AS count
FROM $tableName
''',
    );
    return result['count'] as int;
  }

  static const _tableNameBaseItem = 'base_item';
  static const _tableNameFullItem = 'full_item';
  static const _tableNamePatchNote = 'patch_note';
  static const _tableNameBaseItemTranslation = 'base_item_translation';
  static const _tableNameFullItemTranslation = 'full_item_translation';
  static const _tableNamePatchNoteTranslation = 'patch_note_translation';
  static final _createDatabaseMigration = SqliteMigration(
    1,
    (tx) async {
      await tx.execute(_createTableBaseItem);
      await tx.execute(_createTableFullItem);
      await tx.execute(_createTablePatchNote);
      await tx.execute(_createTableBaseItemTranslation);
      await tx.execute(_createTableFullItemTranslation);
      await tx.execute(_createTablePatchNoteTranslation);
      await tx.execute(_createFullItemIdsIndex);
    },
  );
  static const _createTableBaseItem = '''
CREATE TABLE IF NOT EXISTS $_tableNameBaseItem (
    id VARCHAR(50) PRIMARY KEY,
    ability_power SMALLINT,
    armor SMALLINT,
    attack_damage SMALLINT,
    attack_speed SMALLINT,
    crit SMALLINT,
    health SMALLINT,
    magic_resist SMALLINT,
    mana SMALLINT,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
''';
  static const _createTableFullItem = '''
CREATE TABLE IF NOT EXISTS $_tableNameFullItem (
    id VARCHAR(50) PRIMARY KEY,
    item_id_1 VARCHAR(50) NOT NULL,
    item_id_2 VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL,
    is_special BOOLEAN NOT NULL,
    ability_power SMALLINT,
    armor SMALLINT,
    attack_damage SMALLINT,
    attack_speed SMALLINT,
    crit SMALLINT,
    health SMALLINT,
    magic_resist SMALLINT,
    mana SMALLINT,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (item_id_1) REFERENCES $_tableNameBaseItem(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id_2) REFERENCES $_tableNameBaseItem(id) ON DELETE CASCADE
);
''';
  static const _createTablePatchNote = '''
CREATE TABLE IF NOT EXISTS $_tableNamePatchNote (
    id VARCHAR(50) PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
''';
  static const _createTableBaseItemTranslation = '''
CREATE TABLE IF NOT EXISTS $_tableNameBaseItemTranslation (
    id VARCHAR(50) PRIMARY KEY,
    language_code CHAR(2) NOT NULL,
    item_id VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    hint VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (item_id) REFERENCES $_tableNameBaseItem(id) ON DELETE CASCADE
);
''';
  static const _createTableFullItemTranslation = '''
CREATE TABLE IF NOT EXISTS $_tableNameFullItemTranslation (
    id VARCHAR(50) PRIMARY KEY,
    language_code CHAR(2) NOT NULL,
    item_id VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    hint VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (item_id) REFERENCES $_tableNameFullItem(id) ON DELETE CASCADE
);
''';
  static const _createTablePatchNoteTranslation = '''
CREATE TABLE IF NOT EXISTS $_tableNamePatchNoteTranslation (
    id VARCHAR(50) PRIMARY KEY,
    language_code CHAR(2) NOT NULL,
    patch_note_id VARCHAR(50),
    text TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (patch_note_id) REFERENCES $_tableNamePatchNote(id) ON DELETE CASCADE
);
''';

  static const _createFullItemIdsIndex = '''
CREATE INDEX idx_full_item_item_id_1 ON full_item(item_id_1);
CREATE INDEX idx_full_item_item_id_2 ON full_item(item_id_2);
''';
}

extension on SqliteDatabase {
  Future<Row> getOrThrow(
    String sql, [
    List<Object?> parameters = const [],
  ]) async {
    final result = await getOptional(sql, parameters);

    return switch (result) {
      null => throw const ElementNotFoundException(),
      Row() => result,
    };
  }
}
