import 'package:flutter_test/flutter_test.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/infrastructure/repositories/supabase.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';
import '../../utils.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

// TODO: Add tests for error handling if error handling is supported by
// MockSupabaseHttpClient.
void main() {
  final httpClient = MockSupabaseHttpClient();
  final client = SupabaseClient(
    'https://mock.supabase.co',
    'anoneKey',
    httpClient: httpClient,
  );
  final repository = SupabaseRepository(client);
  final dateTime = DateTime(2024).toUtc();
  final dateTimeString = dateTime.toIso8601String();

  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDown(httpClient.reset);

  tearDownAll(() async {
    httpClient.close();
    await client.dispose();
    await Injector.instance.unregister<LoggerApi>();
  });

  group('initialize', () {
    test(
      'returns correctly.',
      () => expectLater(repository.initialize(), completes),
    );
  });

  group('loadAssetNames', () {
    // TODO: Add tests when rpc is supported.
  });

  group('loadAsset', () {
    // TODO: Add tests when storage is supported.
  });

  group('loadBaseItems', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadBaseItems(null);
      expect(items, isEmpty);
    });

    test('returns items if lastUpdated is null.', () async {
      await client.from('base_item').insert([
        {
          'id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
        },
        {
          'id': '2',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'ability_power': 1,
          'armor': 2,
          'attack_damage': 3,
          'attack_speed': 4,
          'crit': 5,
          'health': 6,
          'magic_resist': 7,
          'mana': 8,
        },
      ]);

      final items = await repository.loadBaseItems(null);
      final expected = [
        BaseItemEntity(
          id: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
        BaseItemEntity(
          id: '2',
          createdAt: dateTime,
          updatedAt: dateTime,
          abilityPower: 1,
          armor: 2,
          attackDamage: 3,
          attackSpeed: 4,
          crit: 5,
          health: 6,
          magicResist: 7,
          mana: 8,
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions
    // are supported.
  });

  group('loadFullItems', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadFullItems(null);
      expect(items, isEmpty);
    });

    test('returns items if lastUpdated is null.', () async {
      await client.from('full_item').insert([
        {
          'id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'is_active': true,
          'is_special': true,
          'item_id_1': '1',
          'item_id_2': '2',
        },
        {
          'id': '2',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'is_active': true,
          'is_special': false,
          'item_id_1': '1',
          'item_id_2': '3',
          'ability_power': 1,
          'armor': 2,
          'attack_damage': 3,
          'attack_speed': 4,
          'crit': 5,
          'health': 6,
          'magic_resist': 7,
          'mana': 8,
        },
      ]);

      final items = await repository.loadFullItems(null);
      final expected = [
        FullItemEntity(
          id: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
          isActive: true,
          isSpecial: true,
          itemId1: '1',
          itemId2: '2',
        ),
        FullItemEntity(
          id: '2',
          createdAt: dateTime,
          updatedAt: dateTime,
          isActive: true,
          isSpecial: false,
          itemId1: '1',
          itemId2: '3',
          abilityPower: 1,
          armor: 2,
          attackDamage: 3,
          attackSpeed: 4,
          crit: 5,
          health: 6,
          magicResist: 7,
          mana: 8,
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions are
    // supported.
  });

  group('loadPatchNotes', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadPatchNotes(null);
      expect(items, isEmpty);
    });

    test('returns patch notes if lastUpdated is null.', () async {
      await client.from('patch_note').insert([
        {
          'id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
        },
      ]);

      final items = await repository.loadPatchNotes(null);
      final expected = [
        PatchNoteEntity(
          id: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions are
    // supported.
  });

  group('loadBaseItemTranslations', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadBaseItemTranslations(null);
      expect(items, isEmpty);
    });

    test('returns translations if lastUpdated is null.', () async {
      await client.from('base_item_translation').insert([
        {
          'id': '1',
          'item_id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'language_code': 'en',
          'name': 'name',
          'description': 'description',
          'hint': 'hint',
        },
      ]);

      final items = await repository.loadBaseItemTranslations(null);
      final expected = [
        BaseItemTranslationEntity(
          id: '1',
          itemId: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
          languageCode: LanguageCode.en,
          name: 'name',
          description: 'description',
          hint: 'hint',
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions are
    // supported.
  });

  group('loadFullItemTranslations', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadFullItemTranslations(null);
      expect(items, isEmpty);
    });

    test('returns translations if lastUpdated is null.', () async {
      await client.from('full_item_translation').insert([
        {
          'id': '1',
          'item_id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'language_code': 'en',
          'name': 'name',
          'description': 'description',
          'hint': 'hint',
        },
      ]);

      final items = await repository.loadFullItemTranslations(null);
      final expected = [
        FullItemTranslationEntity(
          id: '1',
          itemId: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
          languageCode: LanguageCode.en,
          name: 'name',
          description: 'description',
          hint: 'hint',
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions are
    // supported.
  });

  group('loadPatchNoteTranslations', () {
    test('returns empty list if lastUpdated is null.', () async {
      final items = await repository.loadPatchNoteTranslations(null);
      expect(items, isEmpty);
    });

    test('returns translations if lastUpdated is null.', () async {
      await client.from('patch_note_translation').insert([
        {
          'id': '1',
          'patch_note_id': '1',
          'created_at': dateTimeString,
          'updated_at': dateTimeString,
          'language_code': 'en',
          'text': 'text',
        },
      ]);

      final items = await repository.loadPatchNoteTranslations(null);
      final expected = [
        PatchNoteTranslationEntity(
          id: '1',
          patchNoteId: '1',
          createdAt: dateTime,
          updatedAt: dateTime,
          languageCode: LanguageCode.en,
          text: 'text',
        ),
      ];
      expectList(items, expected);
    });

    // TODO: Add tests when lastUpdated is not null when aggregate functions are
    // supported.
  });

  group('loadAssetsCount', () {
    // TODO: Add tests when rpc is supported.
  });

  group('loadBaseItemsCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('loadFullItemsCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('loadPatchNotesCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('loadBaseItemTranslationsCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('loadFullItemTranslationsCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('loadPatchNoteTranslationsCount', () {
    // TODO: Add tests when count requests are supported.
  });

  group('close', () {
    test(
      'returns correctly.',
      () => expectLater(repository.close(), completes),
    );
  });
}
