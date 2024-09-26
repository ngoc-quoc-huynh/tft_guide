import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note_translation.dart';

void main() {
  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNoteTranslation.fromJson(
          const {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
            'created_at': '2024-01-01',
            'updated_at': '2024-01-01',
          },
        ),
        PatchNoteTranslation(
          id: 'id',
          patchNoteId: 'patchNoteId',
          languageCode: LanguageCode.en,
          text: 'text',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ),
    );

    test(
      'throws TypeError if key is not found.',
      () {
        expect(
          () => PatchNoteTranslation.fromJson(
            const {
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 1,
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 1,
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 1,
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 1,
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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
          () => PatchNoteTranslation.fromJson(
            const {
              'id': 'id',
              'patch_note_id': 'patchNoteId',
              'language_code': 'en',
              'text': 'text',
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

    test('throws FormatException if date is invalid.', () {
      expect(
        () => PatchNoteTranslation.fromJson(
          const {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
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
        () => PatchNoteTranslation.fromJson(
          const {
            'id': 'id',
            'patch_note_id': 'patchNoteId',
            'language_code': 'en',
            'text': 'text',
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
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ).toDomain(),
        PatchNoteTranslationEntity(
          id: 'id',
          patchNoteId: 'patchNoteId',
          languageCode: LanguageCode.en,
          text: 'text',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ),
    );
  });
}
