import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/patch_note.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/patch_note.dart';

void main() {
  group('PatchNote', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          PatchNote.fromJson(
            const {
              'text': 'text',
              'created_at': '2024-01-01',
            },
          ),
          PatchNote(
            text: 'text',
            createdAt: DateTime(2024),
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => PatchNote.fromJson(
              const {'text': 'text'},
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
            () => PatchNote.fromJson(
              const {'created_at': '2024-01-01'},
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
        'throws FormatException if created_at is wrong format.',
        () => expect(
          () => PatchNote.fromJson(
            const {
              'text': 'text',
              'created_at': 'createdAt',
            },
          ),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              'Invalid date format',
            ),
          ),
        ),
      );
    });

    group('toDomain', () {
      test(
        'returns correctly.',
        () => expect(
          PatchNote(
            text: 'text',
            createdAt: DateTime(2024),
          ).toDomain(),
          domain.PatchNote(
            text: 'text',
            createdAt: DateTime(2024),
          ),
        ),
      );
    });
  });

  group('PaginatedPatchNotes', () {
    group('fromJson', () {
      test('returns correctly.', () {
        expect(
          PaginatedPatchNotes.fromJson(
            pageSize: 1,
            count: 0,
            patchNotesJson: const [],
          ),
          const PaginatedPatchNotes(
            patchNotes: [],
            totalPages: 0,
          ),
        );
        expect(
          PaginatedPatchNotes.fromJson(
            pageSize: 1,
            count: 1,
            patchNotesJson: const [
              {
                'text': 'text',
                'created_at': '2024-01-01',
              },
            ],
          ),
          PaginatedPatchNotes(
            patchNotes: [
              PatchNote(
                text: 'text',
                createdAt: DateTime(2024),
              ),
            ],
            totalPages: 1,
          ),
        );
      });
    });

    group('toDomain', () {
      test('returns correctly.', () {
        expect(
          const PaginatedPatchNotes(
            patchNotes: [],
            totalPages: 0,
          ).toDomain(),
          const domain.PaginatedPatchNotes(
            totalPages: 0,
            patchNotes: [],
          ),
        );
        expect(
          PaginatedPatchNotes(
            patchNotes: [
              PatchNote(
                text: 'text',
                createdAt: DateTime(2024),
              ),
            ],
            totalPages: 0,
          ).toDomain(),
          domain.PaginatedPatchNotes(
            totalPages: 0,
            patchNotes: [
              domain.PatchNote(
                text: 'text',
                createdAt: DateTime(2024),
              ),
            ],
          ),
        );
      });
    });
  });
}
