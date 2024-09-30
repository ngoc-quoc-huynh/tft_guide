import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/shared_preferences.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final sharedPrefs = MockSharedPreferencesWithCache();
  final repository = SharedPreferencesRepository();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<SharedPreferencesWithCache>(sharedPrefs)
      ..registerSingleton<LoggerApi>(
        MockLoggerApi(),
      ),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<SharedPreferencesWithCache>()
      ..unregister<LoggerApi>(),
  );

  group('lastAppUpdate', () {
    test('returns null if no value is set.', () {
      when(() => sharedPrefs.getString('last_app_update')).thenReturn(null);

      expect(repository.lastAppUpdate, isNull);
      verify(() => sharedPrefs.getString('last_app_update')).called(1);
    });

    test('returns the last app update if a value is set.', () {
      when(() => sharedPrefs.getString('last_app_update'))
          .thenReturn('2024-01-01');

      expect(repository.lastAppUpdate, DateTime(2024));
      verify(() => sharedPrefs.getString('last_app_update')).called(1);
    });
  });

  group('updateLastAppUpdate', () {
    test('returns correctly.', () async {
      when(
        () => sharedPrefs.setString(
          'last_app_update',
          '2023-12-31T23:00:00.000Z',
        ),
      ).thenAnswer((_) => Future.value());

      await expectLater(
        repository.updateLastAppUpdate(DateTime(2024)),
        completes,
      );
      verify(
        () => sharedPrefs.setString(
          'last_app_update',
          '2023-12-31T23:00:00.000Z',
        ),
      ).called(1);
    });
  });

  group('readPatchNotesCount', () {
    test('returns 0 if no value is set.', () {
      when(() => sharedPrefs.getInt('read_patch_notes_count')).thenReturn(null);

      expect(repository.readPatchNotesCount, 0);
      verify(() => sharedPrefs.getInt('read_patch_notes_count')).called(1);
    });

    test('returns the read patch notes count if a value is set.', () {
      when(() => sharedPrefs.getInt('read_patch_notes_count')).thenReturn(1);

      expect(repository.readPatchNotesCount, 1);
      verify(() => sharedPrefs.getInt('read_patch_notes_count')).called(1);
    });
  });

  group('updateReadPatchNotesCount', () {
    test('returns correctly.', () async {
      when(() => sharedPrefs.setInt('read_patch_notes_count', 1))
          .thenAnswer((_) => Future.value());

      await expectLater(
        repository.updateReadPatchNotesCount(1),
        completes,
      );
      verify(() => sharedPrefs.setInt('read_patch_notes_count', 1)).called(1);
    });
  });
}
