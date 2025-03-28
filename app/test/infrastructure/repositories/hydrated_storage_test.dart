import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/infrastructure/repositories/hydrated_storage.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final sharedPrefs = MockSharedPreferencesWithCache();
  const repository = SharedPrefsHydratedStorage();

  setUpAll(
    () => Injector.instance.registerSingleton<SharedPreferencesWithCache>(
      sharedPrefs,
    ),
  );

  tearDownAll(Injector.instance.unregister<SharedPreferencesWithCache>);

  group('read', () {
    test('returns null if key does not exist.', () {
      when(() => sharedPrefs.getString('key')).thenReturn(null);

      expect(repository.read('key'), isNull);
      verify(() => sharedPrefs.getString('key')).called(1);
    });

    test('returns String if key exists.', () {
      when(() => sharedPrefs.getString('key')).thenReturn('{"id":"id"}');

      expect(
        repository.read('key'),
        {'id': 'id'},
      );
      verify(() => sharedPrefs.getString('key')).called(1);
    });
  });

  group('write', () {
    test('returns correctly.', () async {
      when(() => sharedPrefs.setString('key', '{"id":"id"}'))
          .thenAnswer((_) => Future.value());

      await expectLater(
        repository.write('key', {'id': 'id'}),
        completes,
      );
      verify(() => sharedPrefs.setString('key', '{"id":"id"}')).called(1);
    });
  });

  group('delete', () {
    test('returns correctly.', () async {
      when(() => sharedPrefs.remove('key')).thenAnswer((_) => Future.value());

      await expectLater(
        repository.delete('key'),
        completes,
      );
      verify(() => sharedPrefs.remove('key')).called(1);
    });
  });

  group('clear', () {
    test('returns correctly.', () async {
      when(sharedPrefs.clear).thenAnswer((_) => Future.value());

      await expectLater(
        repository.clear(),
        completes,
      );
      verify(sharedPrefs.clear).called(1);
    });
  });

  group('close', () {
    test(
      'returns correctly.',
      () async {
        await expectLater(
          repository.close(),
          completes,
        );
      },
    );
  });
}
