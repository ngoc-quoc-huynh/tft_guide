import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note.dart';

void main() {
  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNote.fromJson(
          const {
            'id': 'id',
            'created_at': '2024-01-01',
            'updated_at': '2024-01-01',
          },
        ),
        PatchNote(
          id: 'id',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ),
    );

    test(
      'throws TypeError if key is not found.',
      () {
        expect(
          () => PatchNote.fromJson(
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
          () => PatchNote.fromJson(
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
          () => PatchNote.fromJson(
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
          () => PatchNote.fromJson(
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
          () => PatchNote.fromJson(
            const {
              'id': 'id',
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
          () => PatchNote.fromJson(
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

    test('throws FormatException if date is wrong format.', () {
      expect(
        () => PatchNote.fromJson(
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
        () => PatchNote.fromJson(
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
    });
  });

  group('toDomain', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNote(
          id: 'id',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ).toDomain(),
        PatchNoteEntity(
          id: 'id',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ),
    );
  });
}
