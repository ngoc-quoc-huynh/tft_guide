import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/supabase/item_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/language_code.dart';

void main() {
  group('BaseItemTranslation', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          BaseItemTranslation.fromJson(
            const {
              'id': 'id',
              'item_id': 'itemId',
              'language_code': 'en',
              'name': 'name',
              'description': 'description',
              'hint': 'hint',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
            },
          ),
          BaseItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => BaseItemTranslation.fromJson(
              const {
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 1,
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 1,
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
                'created_at': 1,
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
        'throws FormatException if date is wrong format.',
        () {
          expect(
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
          BaseItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ).toDomain(),
          BaseItemTranslationEntity(
            id: 'id',
            itemId: 'itemId',
            languageCode: domain.LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        ),
      );
    });
  });

  group('FullItemTranslation', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          FullItemTranslation.fromJson(
            const {
              'id': 'id',
              'item_id': 'itemId',
              'language_code': 'en',
              'name': 'name',
              'description': 'description',
              'hint': 'hint',
              'created_at': '2024-01-01',
              'updated_at': '2024-01-01',
            },
          ),
          FullItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => FullItemTranslation.fromJson(
              const {
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 1,
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 1,
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
                'created_at': 1,
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
        'throws FormatException if date is wrong format.',
        () {
          expect(
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              const {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
          FullItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ).toDomain(),
          FullItemTranslationEntity(
            id: 'id',
            itemId: 'itemId',
            languageCode: domain.LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        ),
      );
    });
  });
}
