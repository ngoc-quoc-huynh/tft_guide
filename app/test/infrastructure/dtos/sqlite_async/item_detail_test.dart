import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/item_detail.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_detail.dart';

void main() {
  group('BaseItemDetail', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () {
          expect(
            BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
              },
            ),
            const BaseItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
            ),
          );
          expect(
            BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            const BaseItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
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
        },
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => BaseItemDetail.fromJson(
              const {
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'description': 'description',
                'name': 'name',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => BaseItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
    });

    group('toDomain', () {
      test('returns correctly.', () {
        expect(
          const BaseItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
          ).toDomain(),
          const domain.BaseItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
          ),
        );

        expect(
          const BaseItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
            abilityPower: 1,
            armor: 2,
            attackDamage: 3,
            attackSpeed: 4,
            crit: 5,
            health: 6,
            magicResist: 7,
            mana: 8,
          ).toDomain(),
          const domain.BaseItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
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
    });
  });

  group('FullItemDetail', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () {
          expect(
            FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            const FullItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
              itemId1: 'itemId1',
              itemId2: 'itemId2',
            ),
          );
          expect(
            FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            const FullItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
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
        },
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => FullItemDetail.fromJson(
              const {
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'description': 'description',
                'name': 'name',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemDetail.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
    });
    group('toDomain', () {
      test('returns correctly.', () {
        expect(
          const FullItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ).toDomain(),
          const domain.FullItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        );

        expect(
          const FullItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
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
          ).toDomain(),
          const domain.FullItemDetail(
            id: 'id',
            name: 'name',
            description: 'description',
            hint: 'hint',
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
    });
  });
}
