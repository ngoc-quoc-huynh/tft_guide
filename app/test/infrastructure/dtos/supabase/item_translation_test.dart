import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/supabase/item_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/language_code.dart';

void main() {
  final dateTime = DateTime.utc(2024);
  final dateTimeString = dateTime.toIso8601String();

  group('BaseItemTranslation', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          BaseItemTranslation.fromJson(
            {
              'id': 'id',
              'item_id': 'itemId',
              'language_code': 'en',
              'name': 'name',
              'description': 'description',
              'hint': 'hint',
              'created_at': dateTimeString,
              'updated_at': dateTimeString,
            },
          ),
          BaseItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => BaseItemTranslation.fromJson(
              {
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 1,
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 1,
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
                'created_at': 1,
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
        'throws FormatException if date is wrong format.',
        () {
          expect(
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => BaseItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
          BaseItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
          ).toDomain(),
          BaseItemTranslationEntity(
            id: 'id',
            itemId: 'itemId',
            languageCode: domain.LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
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
            {
              'id': 'id',
              'item_id': 'itemId',
              'language_code': 'en',
              'name': 'name',
              'description': 'description',
              'hint': 'hint',
              'created_at': dateTimeString,
              'updated_at': dateTimeString,
            },
          ),
          FullItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => FullItemTranslation.fromJson(
              {
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 1,
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 1,
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 1,
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 1,
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 1,
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 1,
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
                'created_at': 1,
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
        'throws FormatException if date is wrong format.',
        () {
          expect(
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
            () => FullItemTranslation.fromJson(
              {
                'id': 'id',
                'item_id': 'itemId',
                'language_code': 'en',
                'name': 'name',
                'description': 'description',
                'hint': 'hint',
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
          FullItemTranslation(
            id: 'id',
            itemId: 'itemId',
            languageCode: LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
          ).toDomain(),
          FullItemTranslationEntity(
            id: 'id',
            itemId: 'itemId',
            languageCode: domain.LanguageCode.en,
            name: 'name',
            description: 'description',
            hint: 'hint',
            createdAt: dateTime,
            updatedAt: dateTime,
          ),
        ),
      );
    });
  });
}
