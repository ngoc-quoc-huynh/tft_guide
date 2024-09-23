import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/check_selected_option/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';

void main() {
  const correctOption = QuestionBaseItemOption(
    id: 'id',
    name: 'name',
    description: 'description',
  );

  test(
    'initial state is null.',
    () => expect(CheckSelectedItemOptionCubit(correctOption).state, null),
  );

  group('check', () {
    blocTest<CheckSelectedItemOptionCubit, bool?>(
      'emits true when the correct option is selected.',
      build: () => CheckSelectedItemOptionCubit(correctOption),
      act: (cubit) => cubit.check(correctOption),
      expect: () => [true],
    );

    blocTest<CheckSelectedItemOptionCubit, bool?>(
      'emits false when the correct option is not selected.',
      build: () => CheckSelectedItemOptionCubit(correctOption),
      act: (cubit) => cubit.check(
        const QuestionBaseItemOption(
          id: 'otherId',
          name: 'name',
          description: 'description',
        ),
      ),
      expect: () => [false],
    );
  });
}
