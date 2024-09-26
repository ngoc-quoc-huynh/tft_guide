import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/question/item_option.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/sqlite_async/question_item_option.dart';

void main() {
  group('QuestionBaseItemOption', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          QuestionBaseItemOption.fromJson(
            const {
              'id': 'id',
              'name': 'name',
              'description': 'description',
            },
          ),
          const QuestionBaseItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => QuestionBaseItemOption.fromJson(
              const {
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
          expect(
            () => QuestionBaseItemOption.fromJson(
              const {
                'id': 'id',
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
          expect(
            () => QuestionBaseItemOption.fromJson(
              const {
                'id': 'id',
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
        },
      );

      test(
        'throws TypeError if value is wrong type.',
        () {
          expect(
            () => QuestionBaseItemOption.fromJson(
              const {
                'id': 1,
                'name': 'name',
                'description': 'description',
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
            () => QuestionBaseItemOption.fromJson(
              const {
                'id': 'id',
                'name': 1,
                'description': 'description',
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
            () => QuestionBaseItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 1,
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
          const QuestionBaseItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
          ).toDomain(),
          const domain.QuestionBaseItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
          ),
        ),
      );
    });
  });

  group('QuestionFullItemOption', () {
    group('fromJson', () {
      test(
        'returns correctly.',
        () => expect(
          QuestionFullItemOption.fromJson(
            const {
              'id': 'id',
              'name': 'name',
              'description': 'description',
              'is_special': 0,
              'item_id_1': 'itemId1',
              'item_id_2': 'itemId2',
            },
          ),
          const QuestionFullItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        ),
      );

      test(
        'throws TypeError if key is not found.',
        () {
          expect(
            () => QuestionFullItemOption.fromJson(
              const {
                'name': 'name',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
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
                "type 'Null' is not a subtype of type 'int' in type cast",
              ),
            ),
          );
          expect(
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 1,
                'name': 'name',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 1,
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 1,
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'is_special': 'isSpecial',
                'item_id_1': 'itemId1',
                'item_id_2': 'itemId2',
              },
            ),
            throwsA(
              isA<TypeError>().having(
                (e) => e.toString(),
                'toString',
                "type 'String' is not a subtype of type 'int' in type cast",
              ),
            ),
          );
          expect(
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 'description',
                'is_special': 0,
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
            () => QuestionFullItemOption.fromJson(
              const {
                'id': 'id',
                'name': 'name',
                'description': 1,
                'is_special': 0,
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
      test(
        'returns correctly.',
        () => expect(
          const QuestionFullItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ).toDomain(),
          const domain.QuestionFullItemOption(
            id: 'id',
            name: 'name',
            description: 'description',
            isSpecial: false,
            itemId1: 'itemId1',
            itemId2: 'itemId2',
          ),
        ),
      );
    });
  });
}
