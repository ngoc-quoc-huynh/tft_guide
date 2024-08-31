import 'package:path/path.dart';
import 'package:sqlite_async/sqlite_async.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_detail.dart' as domain;
import 'package:tft_guide/domain/models/item_meta.dart' as domain;
import 'package:tft_guide/domain/models/question/item_option.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_detail.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_meta.dart';
import 'package:tft_guide/infrastructure/dtos/sqlite_async/question_item_option.dart';
import 'package:tft_guide/injector.dart';

final class SQLiteAsyncRepository implements LocalDatabaseApi {
  SQLiteAsyncRepository();

  late final SqliteDatabase _db;

  @override
  Future<LocalDatabaseApi> initialize() async {
    _db = SqliteDatabase(
      path: join(Injector.instance.appDir.path, 'test.db'),
    );
    final migrations = SqliteMigrations()
      ..createDatabase = _createDatabaseMigration
      ..add(_createDatabaseMigration);
    await migrations.migrate(_db);
    return this;
  }

  @override
  Future<DateTime?> loadLatestBaseItemUpdatedAt() async {
    final result =
        await _db.get('SELECT MAX(updated_at) FROM $_tableNameBaseItem');
    final updatedAt = result['MAX(updated_at)'] as String?;
    return switch (updatedAt) {
      null => null,
      String() => DateTime.parse(updatedAt),
    };
  }

  @override
  Future<DateTime?> loadLatestFullItemUpdatedAt() async {
    final result =
        await _db.get('SELECT MAX(updated_at) FROM $_tableNameFullItem');
    final updatedAt = result['MAX(updated_at)'] as String?;
    return switch (updatedAt) {
      null => null,
      String() => DateTime.parse(updatedAt),
    };
  }

  @override
  Future<DateTime?> loadLatestBaseItemTranslationUpdatedAt() async {
    final result = await _db
        .get('SELECT MAX(updated_at) FROM $_tableNameBaseItemTranslation');
    final updatedAt = result['MAX(updated_at)'] as String?;
    return switch (updatedAt) {
      null => null,
      String() => DateTime.parse(updatedAt),
    };
  }

  @override
  Future<DateTime?> loadLatestFullItemTranslationUpdatedAt() async {
    final result = await _db
        .get('SELECT MAX(updated_at) FROM $_tableNameFullItemTranslation');
    final updatedAt = result['MAX(updated_at)'] as String?;
    return switch (updatedAt) {
      null => null,
      String() => DateTime.parse(updatedAt),
    };
  }

  @override
  Future<void> storeBaseItems(List<BaseItemEntity> items) => _db.executeBatch(
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

  @override
  Future<void> storeFullItems(List<FullItemEntity> items) => _db.executeBatch(
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

  @override
  Future<void> storeBaseItemTranslations(
    List<BaseItemTranslationEntity> translations,
  ) =>
      _db.executeBatch(
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

  @override
  Future<void> storeFullItemTranslations(
    List<FullItemTranslationEntity> translations,
  ) =>
      _db.executeBatch(
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
    return BaseItemDetail.fromJson(json).toDomain();
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
    return FullItemDetail.fromJson(json).toDomain();
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
    return result
        .map((json) => BaseItemMeta.fromJson(json).toDomain())
        .toList();
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
    return result
        .map((json) => FullItemMeta.fromJson(json).toDomain())
        .toList();
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
    return result
        .map((json) => QuestionBaseItemOption.fromJson(json).toDomain())
        .toList();
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
    return result
        .map((json) => QuestionFullItemOption.fromJson(json).toDomain())
        .toList();
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
    return result
        .map((json) => QuestionBaseItemOption.fromJson(json).toDomain())
        .toList();
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
    return result
        .map((json) => QuestionFullItemOption.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<void> close() => _db.close();

  static const _tableNameBaseItem = 'base_item';
  static const _tableNameFullItem = 'full_item';
  static const _tableNameBaseItemTranslation = 'base_item_translation';
  static const _tableNameFullItemTranslation = 'full_item_translation';
  static final _createDatabaseMigration = SqliteMigration(
    1,
    (tx) async {
      await tx.execute(_createTableBaseItem);
      await tx.execute(_createTableFullItem);
      await tx.execute(_createTableBaseItemTranslation);
      await tx.execute(_createTableFullItemTranslation);
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

  static const _createFullItemIdsIndex = '''
CREATE INDEX idx_full_item_item_id_1 ON full_item(item_id_1);
CREATE INDEX idx_full_item_item_id_2 ON full_item(item_id_2);
''';
}
