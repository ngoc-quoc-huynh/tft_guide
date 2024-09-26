import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item.dart';

void main() {
  group('BaseItem', () {
    group('fromJson', () {
      test('returns correctly.', () {
        expect(
          BaseItem.fromJson(
            const {
              'id': 'id',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
            },
          ),
          BaseItem(
            id: 'id',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        );
        expect(
          BaseItem.fromJson(
            const {
              'id': 'id',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
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
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
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
              const {
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 1,
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': 2,
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': 'createdAt',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ).toDomain(),
          BaseItemEntity(
            id: 'id',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
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
            const {
              'id': 'id',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
              'is_active': true,
              'is_special': false,
              'item_id_1': 'itemId1',
              'item_id_2': 'itemId2',
            },
          ),
          FullItem(
            id: 'id',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        );
        expect(
          FullItem.fromJson(
            const {
              'id': 'id',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
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
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
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
              const {
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 1,
                'created_at': '2024-01-01',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': 2,
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': 'createdAt',
                'updated_at': '2024-01-01',
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
              const {
                'id': 'id',
                'created_at': '2024-01-01',
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
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
            isActive: true,
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ).toDomain(),
          FullItemEntity(
            id: 'id',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
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
