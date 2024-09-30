import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note_translation.dart';

void main() {
  final dateTime = DateTime.utc(2024);
  final dateTimeString = dateTime.toIso8601String();

  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNoteTranslation.fromJson(
          {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
            'created_at': dateTimeString,
            'updated_at': dateTimeString,
          },
        ),
        PatchNoteTranslation(
          id: 'id',
          patchNoteId: 'patchNoteId',
          languageCode: LanguageCode.en,
          text: 'text',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
      ),
    );

    test(
      'throws TypeError if key is not found.',
      () {
        expect(
          () => PatchNoteTranslation.fromJson(
            {
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 1,
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 1,
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 1,
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 1,
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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

    test('throws FormatException if date is invalid.', () {
      expect(
        () => PatchNoteTranslation.fromJson(
          {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
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
        () => PatchNoteTranslation.fromJson(
          {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
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
    });
  });

  group('toDomain', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNoteTranslation(
          id: 'id',
          patchNoteId: 'patchNoteId',
          languageCode: LanguageCode.en,
          text: 'text',
          createdAt: dateTime,
          updatedAt: dateTime,
        ).toDomain(),
        PatchNoteTranslationEntity(
          id: 'id',
          patchNoteId: 'patchNoteId',
          languageCode: LanguageCode.en,
          text: 'text',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
      ),
    );
  });
}
