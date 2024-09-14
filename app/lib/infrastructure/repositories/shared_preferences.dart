import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';
import 'package:tft_guide/injector.dart';

final class SharedPreferencesRepository implements LocalStorageApi {
  static final _sharedPrefs = Injector.instance.sharedPrefs;

  @override
  DateTime? get lastAppUpdate => DateTimeExtension.tryParseOrNull(
        _sharedPrefs.getString(_lastAppUpdateKey),
      );

  @override
  Future<void> updateLastAppUpdate(DateTime date) => _sharedPrefs.setString(
        _lastAppUpdateKey,
        date.toUtc().toIso8601String(),
      );

  @override
  int get readPatchNotesCount =>
      _sharedPrefs.getInt(_readPatchNotesCountKey) ?? 0;

  @override
  Future<void> updateReadPatchNotesCount(int count) =>
      _sharedPrefs.setInt(_readPatchNotesCountKey, count);

  static const _lastAppUpdateKey = 'last_app_update';
  static const _readPatchNotesCountKey = 'read_patch_notes_count';
}
