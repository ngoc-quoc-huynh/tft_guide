import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

final class SharedPreferencesRepository
    with LoggerMixin
    implements LocalStorageApi {
  static final _sharedPrefs = Injector.instance.sharedPrefs;

  @override
  DateTime? get lastAppUpdate {
    final lastUpdate = DateTimeExtension.tryParseOrNull(
      _sharedPrefs.getString(_lastAppUpdateKey),
    );
    logInfo(
      'SharedPreferencesRepository.lastAppUpdate',
      'Retrieved last app update: ${lastUpdate?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return lastUpdate;
  }

  @override
  Future<void> updateLastAppUpdate(DateTime date) async {
    await _sharedPrefs.setString(
      _lastAppUpdateKey,
      date.toUtc().toIso8601String(),
    );

    logInfo(
      'SharedPreferencesRepository.updateLastAppUpdate',
      'Updated last app update.',
      stackTrace: StackTrace.current,
    );
  }

  @override
  int get readPatchNotesCount {
    final count = _sharedPrefs.getInt(_readPatchNotesCountKey) ?? 0;
    logInfo(
      'SharedPreferencesRepository.readPatchNotesCount',
      'Retrieved read patch notes count: $count',
      stackTrace: StackTrace.current,
    );

    return count;
  }

  @override
  Future<void> updateReadPatchNotesCount(int count) async {
    await _sharedPrefs.setInt(_readPatchNotesCountKey, count);

    logInfo(
      'SharedPreferencesRepository.updateReadPatchNotesCount',
      'Updated read patch notes count to $count.',
      stackTrace: StackTrace.current,
      parameters: {'count': count.toString()},
    );
  }

  static const _lastAppUpdateKey = 'last_app_update';
  static const _readPatchNotesCountKey = 'read_patch_notes_count';
}
