import 'package:path/path.dart';
import 'package:sqlite_async/sqlite_async.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
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
  Future<void> close() => _db.close();

  static const _createTableBaseItem = '''
CREATE TABLE IF NOT EXISTS base_item (
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
CREATE TABLE IF NOT EXISTS full_item (
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
    FOREIGN KEY (item_id_1) REFERENCES base_item(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id_2) REFERENCES base_item(id) ON DELETE CASCADE
);
''';

  static const _createTableBaseItemTranslation = '''
CREATE TABLE IF NOT EXISTS base_item_translation (
    id VARCHAR(50) PRIMARY KEY,
    language_code CHAR(2) NOT NULL,
    item_id VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    hint VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (item_id) REFERENCES base_item(id) ON DELETE CASCADE
);
''';

  static const _createTableFullItemTranslation = '''
CREATE TABLE IF NOT EXISTS full_item_translation (
    id VARCHAR(50) PRIMARY KEY,
    language_code CHAR(2) NOT NULL,
    item_id VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    hint VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (item_id) REFERENCES full_item(id) ON DELETE CASCADE
);
''';
}
