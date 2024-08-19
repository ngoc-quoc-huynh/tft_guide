import 'package:path/path.dart';
import 'package:sqlite_async/sqlite_async.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/injector.dart';

final class SQLiteAsyncRepository implements LocalDatabaseAPI {
  SQLiteAsyncRepository();

  late final SqliteDatabase _db;

  @override
  Future<LocalDatabaseAPI> initialize() async {
    _db = SqliteDatabase(
      path: join(Injector.instance.appDir.path, 'test.db'),
    );
    final migrations = SqliteMigrations()
      ..add(
        SqliteMigration(
          1,
          (tx) async {
            await tx.execute(_createTableBaseItem);
            await tx.execute(_createTableFullItem);
            await tx.execute(_createTableBaseItemTranslation);
            await tx.execute(_createTableFullItemTranslation);
          },
        ),
      );
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
INSERT INTO $_tableNameBaseItem (id, ability_power, armor, attack_damage, attack_speed, crit, health, magic_resist, mana, created_at, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT(id)
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
INSERT INTO $_tableNameFullItem (id, is_active, item_id_1, item_id_2, ability_power, armor, attack_damage, attack_speed, crit, health, magic_resist, mana, created_at, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT(id)
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
                item.isActive,
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
INSERT INTO $_tableNameBaseItemTranslation (id, item_id, language_code, name, description, hint, created_at, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT(id)
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
INSERT INTO $_tableNameFullItemTranslation (id, item_id, language_code, name, description, hint, created_at, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT(id)
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
  Future<void> close() => _db.close();

  static const _tableNameBaseItem = 'base_item';
  static const _tableNameFullItem = 'full_item';
  static const _tableNameBaseItemTranslation = 'base_item_translation';
  static const _tableNameFullItemTranslation = 'full_item_translation';
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
}
