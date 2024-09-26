import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/item_meta.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/item_meta.dart';

void main() {
  group('BaseItemMeta', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          BaseItemMeta.fromJson(
            const {
              'id': 'id',
              'name': 'name',
            },
          ),
          const BaseItemMeta(
            id: 'id',
            name: 'name',
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => BaseItemMeta.fromJson(
              const {'name': 'name'},
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
            () => BaseItemMeta.fromJson(
              const {'id': 'id'},
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
            () => BaseItemMeta.fromJson(
              const {
                'id': 1,
                'name': 'name',
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
            () => BaseItemMeta.fromJson(
              const {
                'id': 'id',
                'name': 1,
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
      test(
        'returns correctly.',
        () => expect(
          const BaseItemMeta(
            id: 'id',
            name: 'name',
          ).toDomain(),
          const domain.BaseItemMeta(
            id: 'id',
            name: 'name',
          ),
        ),
      );
    });
  });

  group('FullItemMeta', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          FullItemMeta.fromJson(
            const {
              'id': 'id',
              'name': 'name',
            },
          ),
          const FullItemMeta(
            id: 'id',
            name: 'name',
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => FullItemMeta.fromJson(
              const {'name': 'name'},
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
            () => FullItemMeta.fromJson(
              const {'id': 'id'},
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
            () => FullItemMeta.fromJson(
              const {
                'id': 1,
                'name': 'name',
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
            () => FullItemMeta.fromJson(
              const {
                'id': 'id',
                'name': 1,
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
      test(
        'returns correctly.',
        () => expect(
          const FullItemMeta(
            id: 'id',
            name: 'name',
          ).toDomain(),
          const domain.FullItemMeta(
            id: 'id',
            name: 'name',
          ),
        ),
      );
    });
  });
}
