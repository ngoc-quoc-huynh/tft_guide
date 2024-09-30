import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note.dart';

void main() {
  final dateTime = DateTime.utc(2024);
  final dateTimeString = dateTime.toIso8601String();

  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        PatchNote.fromJson(
          {
            'id': 'id',
            'created_at': dateTimeString,
            'updated_at': dateTimeString,
          },
        ),
        PatchNote(
          id: 'id',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
      ),
    );

    test(
      'throws TypeError if key is not found.',
      () {
        expect(
          () => PatchNote.fromJson(
            {
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
          () => PatchNote.fromJson(
            {
              'id': 'id',
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
          () => PatchNote.fromJson(
            {
              'id': 'id',
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
          () => PatchNote.fromJson(
            {
              'id': 1,
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
          () => PatchNote.fromJson(
            {
              'id': 'id',
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
          () => PatchNote.fromJson(
            {
              'id': 'id',
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

    test('throws FormatException if date is wrong format.', () {
      expect(
        () => PatchNote.fromJson(
          {
            'id': 'id',
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
        () => PatchNote.fromJson(
          {
            'id': 'id',
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
        PatchNote(
          id: 'id',
          createdAt: dateTime,
          updatedAt: dateTime,
        ).toDomain(),
        PatchNoteEntity(
          id: 'id',
          createdAt: dateTime,
          updatedAt: dateTime,
        ),
      ),
    );
  });
}
