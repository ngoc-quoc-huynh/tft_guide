import 'package:path/path.dart';
import 'package:sqlite_async/sqlite_async.dart';
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

final class SQLiteAsyncRepository with LoggerMixin implements LocalDatabaseApi {
  SQLiteAsyncRepository();

  final _db = SqliteDatabase(
    path: join(Injector.instance.appDir.path, 'test.db'),
  );

  @override
  Future<void> initialize() async {
    final migrations = SqliteMigrations()
      ..createDatabase = _createDatabaseMigration
      ..add(_createDatabaseMigration);
    await migrations.migrate(_db);
    logInfo(
      'SQLiteAsyncRepository.initialize',
      'Initialized SQLite.',
      stackTrace: StackTrace.current,
    );
  }

  @override
  Future<DateTime?> loadLatestBaseItemUpdatedAt() async {
    final updatedAt = await _loadLatestUpdatedAt(_tableNameBaseItem);
    logInfo(
      'SQLiteAsyncRepository.loadLatestBaseItemUpdatedAt',
      'Retrieved latest base item updated at: ${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<DateTime?> loadLatestFullItemUpdatedAt() async {
    final updatedAt = await _loadLatestUpdatedAt(_tableNameFullItem);
    logInfo(
      'SQLiteAsyncRepository.loadLatestFullItemUpdatedAt',
      'Retrieved latest full item updated at: ${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<DateTime?> loadLatestPatchNoteUpdatedAt() async {
    final updatedAt = await _loadLatestUpdatedAt(_tableNamePatchNote);
    logInfo(
      'SQLiteAsyncRepository.loadLatestPatchNoteUpdatedAt',
      'Retrieved latest patch note updated at: '
          '${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt() async {
    final updatedAt = await _loadLatestUpdatedAt(_tableNamePatchNote);
    logInfo(
      'SQLiteAsyncRepository.loadLatestBaseItemTranslationUpdatedAt',
      'Retrieved latest base item translation updated at: '
          '${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt() async {
    final updatedAt = await _loadLatestUpdatedAt(_tableNameFullItemTranslation);
    logInfo(
      'SQLiteAsyncRepository.loadLatestFullItemTranslationUpdatedAt',
      'Retrieved latest full item translation updated at: '
          '${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<DateTime?> loadLatestPatchNoteTranslationUpdatedAt() async {
    final updatedAt =
        await _loadLatestUpdatedAt(_tableNamePatchNoteTranslation);
    logInfo(
      'SQLiteAsyncRepository.loadLatestPatchNoteTranslationUpdatedAt',
      'Retrieved latest patch note translation updated at: '
          '${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<void> storeBaseItems(List<BaseItemEntity> items) async {
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
      'SQLiteAsyncRepository.storeBaseItems',
      'Stored ${items.length} base items.',
      stackTrace: StackTrace.current,
      parameters: {'items': items.map((item) => item.id).join(',')},
    );
  }

  @override
  Future<void> storeFullItems(List<FullItemEntity> items) async {
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
      'SQLiteAsyncRepository.storeFullItems',
      'Stored ${items.length} full items.',
      stackTrace: StackTrace.current,
      parameters: {'items': items.map((item) => item.id).join(',')},
    );
  }

  @override
  Future<void> storePatchNotes(List<PatchNoteEntity> patchNotes) async {
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
      'SQLiteAsyncRepository.storePatchNotes',
      'Stored ${patchNotes.length} patch notes.',
      stackTrace: StackTrace.current,
      parameters: {
        'patchNotes': patchNotes.map((patchNote) => patchNote.id).join(','),
      },
    );
  }

  @override
  Future<void> storeBaseItemTranslations(
    List<BaseItemTranslationEntity> translations,
  ) async {
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
      'SQLiteAsyncRepository.storeBaseItemTranslations',
      'Stored ${translations.length} base item translations.',
      stackTrace: StackTrace.current,
      parameters: {
        'translations':
            translations.map((translation) => translation.id).join(','),
      },
    );
  }

  @override
  Future<void> storeFullItemTranslations(
    List<FullItemTranslationEntity> translations,
  ) async {
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
      'SQLiteAsyncRepository.storeFullItemTranslations',
      'Stored ${translations.length} full item translations.',
      stackTrace: StackTrace.current,
      parameters: {
        'translations':
            translations.map((translation) => translation.id).join(','),
      },
    );
  }

  @override
  Future<void> storePatchNoteTranslations(
    List<PatchNoteTranslationTranslationEntity> translations,
  ) async {
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
      'SQLiteAsyncRepository.storePatchNoteTranslations',
      'Stored ${translations.length} patch note translations.',
      stackTrace: StackTrace.current,
      parameters: {
        'translations':
            translations.map((translation) => translation.id).join(','),
      },
    );
  }

  @override
  Future<domain.BaseItemDetail> loadBaseItemDetail(
    String id,
    LanguageCode languageCode,
  ) async {
    final json = await _db.get(
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
      'SQLiteAsyncRepository.loadBaseItemDetail',
      'Loaded base item detail.',
      stackTrace: StackTrace.current,
      parameters: {
        'id': id,
        'languageCode': languageCode.toString(),
      },
    );

    return item;
  }

  @override
  Future<domain.FullItemDetail> loadFullItemDetail(
    String id,
    LanguageCode languageCode,
  ) async {
    final json = await _db.get(
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
      'SQLiteAsyncRepository.loadFullItemDetail',
      'Loaded full item detail.',
      stackTrace: StackTrace.current,
      parameters: {
        'id': id,
        'languageCode': languageCode.toString(),
      },
    );

    return item;
  }

  @override
  Future<List<domain.BaseItemMeta>> loadBaseItemMetas(
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadBaseItemMetas',
      'Loaded ${items.length} base item metas.',
      stackTrace: StackTrace.current,
      parameters: {'languageCode': languageCode.toString()},
    );

    return items;
  }

  @override
  Future<List<domain.FullItemMeta>> loadFullItemMetas(
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadFullItemMetas',
      'Loaded ${items.length} full item metas.',
      stackTrace: StackTrace.current,
      parameters: {'languageCode': languageCode.toString()},
    );

    return items;
  }

  @override
  Future<List<domain.QuestionBaseItemOption>> loadRandomQuestionBaseItemOptions(
    int amount,
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadRandomQuestionBaseItemOptions',
      'Loaded random question base item options: '
          '${options.map((option) => option.id)}.',
      stackTrace: StackTrace.current,
      parameters: {
        'amount': amount.toString(),
        'languageCode': languageCode.toString(),
      },
    );

    return options;
  }

  @override
  Future<List<domain.QuestionFullItemOption>> loadRandomQuestionFullItemOptions(
    int amount,
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadRandomQuestionFullItemOptions',
      'Loaded random question full item options: '
          '${options.map((option) => option.id)}.',
      stackTrace: StackTrace.current,
      parameters: {
        'amount': amount.toString(),
        'languageCode': languageCode.toString(),
      },
    );

    return options;
  }

  @override
  Future<List<domain.QuestionBaseItemOption>>
      loadOtherRandomQuestionBaseItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadOtherRandomQuestionBaseItemOptions',
      'Loaded other random question base item options: '
          '${options.map((option) => option.id)}.',
      stackTrace: StackTrace.current,
      parameters: {
        'id': id,
        'amount': amount.toString(),
        'languageCode': languageCode.toString(),
      },
    );

    return options;
  }

  @override
  Future<List<domain.QuestionFullItemOption>>
      loadOtherRandomQuestionFullItemOptions(
    String id,
    int amount,
    LanguageCode languageCode,
  ) async {
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
      'SQLiteAsyncRepository.loadOtherRandomQuestionFullItemOptions',
      'Loaded other random question full item options: '
          '${options.map((option) => option.id)}.',
      stackTrace: StackTrace.current,
      parameters: {
        'id': id,
        'amount': amount.toString(),
        'languageCode': languageCode.toString(),
      },
    );

    return options;
  }

  @override
  Future<domain.PaginatedPatchNotes> loadPatchNotes({
    required int currentPage,
    required int pageSize,
    required LanguageCode languageCode,
  }) async {
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
      'SQLiteAsyncRepository.loadPatchNotes',
      'Loaded patch notes. '
          '${paginatedPatchNotes.patchNotes.map(
        (patchNote) => patchNote.createdAt,
      )}.',
      stackTrace: StackTrace.current,
      parameters: {
        'currentPage': currentPage.toString(),
        'pageSize': pageSize.toString(),
        'languageCode': languageCode.toString(),
      },
    );

    return paginatedPatchNotes;
  }

  @override
  Future<int> loadBaseItemsCount() async {
    final count = await _loadCount(_tableNameBaseItem);
    logInfo(
      'SQLiteAsyncRepository.loadBaseItemsCount',
      'Loaded base items count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<int> loadFullItemsCount() async {
    final count = await _loadCount(_tableNameFullItem);
    logInfo(
      'SQLiteAsyncRepository.loadFullItemsCount',
      'Loaded full items count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<int> loadPatchNotesCount() async {
    final count = await _loadCount(_tableNamePatchNote);
    logInfo(
      'SQLiteAsyncRepository.loadPatchNotesCount',
      'Loaded patch notes count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<int> loadBaseItemTranslationsCount() async {
    final count = await _loadCount(_tableNameBaseItemTranslation);
    logInfo(
      'SQLiteAsyncRepository.loadBaseItemTranslationsCount',
      'Loaded base item translations count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<int> loadFullItemTranslationsCount() async {
    final count = await _loadCount(_tableNameFullItemTranslation);
    logInfo(
      'SQLiteAsyncRepository.loadFullItemTranslationsCount',
      'Loaded full item translations count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<int> loadPatchNoteTranslationsCount() async {
    final count = await _loadCount(_tableNamePatchNoteTranslation);
    logInfo(
      'SQLiteAsyncRepository.loadPatchNoteTranslationsCount',
      'Loaded patch note translations count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<void> close() async {
    await _db.close();
    logInfo(
      'SQLiteAsyncRepository.close',
      'Closed repository.',
      stackTrace: StackTrace.current,
    );
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
    text VARCHAR(255) NOT NULL,
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
