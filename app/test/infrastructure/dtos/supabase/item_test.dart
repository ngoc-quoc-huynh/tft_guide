import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item.dart';

void main() {
  final dateTime = DateTime.utc(2024);
  final dateTimeString = dateTime.toIso8601String();

  group('BaseItem', () {
    group('fromJson', () {
      test('returns correctly.', () {
        expect(
          BaseItem.fromJson(
            {
              'id': 'id',
              'created_at': dateTimeString,
              'updated_at': dateTimeString,
            },
          ),
          BaseItem(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
          ),
        );
        expect(
          BaseItem.fromJson(
            {
              'id': 'id',
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
          ),
          BaseItem(
            id: 'id',
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
        );
      });

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => BaseItem.fromJson(
              {
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'updated_at': dateTimeString,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
        },
      );

      test(
        'throws TypeError if value is wrong type.',
        () {
          expect(
            () => BaseItem.fromJson(
              {
                'id': 1,
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'created_at': 2,
                'updated_at': dateTimeString,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 1,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
        },
      );

      test(
        'throws FormatException date is wrong format.',
        () {
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'created_at': 'createdAt',
                'updated_at': dateTimeString,
              },
            ),
            throwsA(
              isA<FormatException>().having(
                (e) => e.message,
                'message',
                'Invalid date format',
              ),
            ),
          );
          expect(
            () => BaseItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
              },
            ),
            throwsA(
              isA<FormatException>().having(
                (e) => e.message,
                'message',
                'Invalid date format',
              ),
            ),
          );
        },
      );
    });

    group('toDomain', () {
      test(
        'returns correctly.',
        () => expect(
          BaseItem(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
          ).toDomain(),
          BaseItemEntity(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
          ),
        ),
      );
    });
  });

  group('FullItem', () {
    group('fromJson', () {
      test('returns correctly.', () {
        expect(
          FullItem.fromJson(
            {
              'id': 'id',
              'created_at': dateTimeString,
              'updated_at': dateTimeString,
              'is_active': true,
              'is_special': false,
              'item_id_1': 'itemId1',
              'item_id_2': 'itemId2',
            },
          ),
          FullItem(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        );
        expect(
          FullItem.fromJson(
            {
              'id': 'id',
              'created_at': dateTimeString,
              'updated_at': dateTimeString,
              'is_active': true,
              'is_special': false,
              'item_id_1': 'itemId1',
              'item_id_2': 'itemId2',
              'ability_power': 1,
              'armor': 2,
              'attack_damage': 3,
              'attack_speed': 4,
              'crit': 5,
              'health': 6,
              'magic_resist': 7,
              'mana': 8,
            },
          ),
          FullItem(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
            abilityPower: 1,
            armor: 2,
            attackDamage: 3,
            attackSpeed: 4,
            crit: 5,
            health: 6,
            magicResist: 7,
            mana: 8,
          ),
        );
      });

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => FullItem.fromJson(
              {
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'bool' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_active': true,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'bool' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
        },
      );

      test(
        'throws TypeError if value is wrong type.',
        () {
          expect(
            () => FullItem.fromJson(
              {
                'id': 1,
                'created_at': dateTimeString,
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': 2,
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 1,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
                'is_active': 1,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'bool' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
                'is_active': true,
                'is_special': 1,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'bool' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
                'is_active': true,
                'is_special': false,
                'item_id_1': 1,
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 1,
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'int' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
        },
      );

      test(
        'throws FormatException date is wrong format.',
        () {
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': 'createdAt',
                'updated_at': dateTimeString,
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<FormatException>().having(
                (e) => e.message,
                'message',
                'Invalid date format',
              ),
            ),
          );
          expect(
            () => FullItem.fromJson(
              {
                'id': 'id',
                'created_at': dateTimeString,
                'updated_at': 'updatedAt',
                'is_active': true,
                'is_special': false,
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<FormatException>().having(
                (e) => e.message,
                'message',
                'Invalid date format',
              ),
            ),
          );
        },
      );
    });

    group('toDomain', () {
      test(
        'returns correctly.',
        () => expect(
          FullItem(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ).toDomain(),
          FullItemEntity(
            id: 'id',
            createdAt: dateTime,
            updatedAt: dateTime,
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        ),
      );
    });
  });
}
