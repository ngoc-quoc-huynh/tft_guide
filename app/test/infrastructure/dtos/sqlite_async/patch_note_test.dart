import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/patch_note.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/patch_note.dart';

void main() {
  final createdAt = DateTime.utc(2024);
  final createdAtString = createdAt.toIso8601String();

  group('PatchNote', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          PatchNote.fromJson(
            {
              'text': 'text',
              'created_at': createdAtString,
            },
          ),
          PatchNote(
            text: 'text',
            createdAt: createdAt,
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
              {'created_at': createdAtString},
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
            createdAt: createdAt,
          ).toDomain(),
          domain.PatchNote(
            text: 'text',
            createdAt: createdAt,
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
            patchNotesJson: [
              {
                'text': 'text',
                'created_at': createdAtString,
              },
            ],
          ),
          PaginatedPatchNotes(
            patchNotes: [
              PatchNote(
                text: 'text',
                createdAt: createdAt,
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
                createdAt: createdAt,
              ),
            ],
            totalPages: 0,
          ).toDomain(),
          domain.PaginatedPatchNotes(
            totalPages: 0,
            patchNotes: [
              domain.PatchNote(
                text: 'text',
                createdAt: createdAt,
              ),
            ],
          ),
        );
      });
    });
  });
}
