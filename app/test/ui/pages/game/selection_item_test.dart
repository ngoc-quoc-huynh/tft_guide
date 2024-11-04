import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/check_selected_option/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

import '../../../mocks.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
        .registerSingleton<Translations>(TranslationsEn.build()),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders unselected correctly.',
    fileName: 'selection_item',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario.builder(
          name: 'Unselected 1',
          builder: (context) {
            final checkSelectedItemOptionCubit =
                MockCheckSelectedItemOptionCubit();
            final selectedItemOptionValueCubit =
                MockSelectionValueCubit<QuestionItemOption>();
            whenListen<bool?>(
              checkSelectedItemOptionCubit,
              const Stream<bool?>.empty(),
            );
            whenListen<QuestionItemOption?>(
              selectedItemOptionValueCubit,
              const Stream<QuestionItemOption?>.empty(),
            );
            return _TestWidget(
              checkSelectedItemOptionCubit: checkSelectedItemOptionCubit,
              selectedItemOptionValueCubit: selectedItemOptionValueCubit,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'Unselected 2',
          builder: (context) {
            final checkSelectedItemOptionCubit =
                MockCheckSelectedItemOptionCubit();
            final selectedItemOptionValueCubit =
                MockSelectionValueCubit<QuestionItemOption>();
            whenListen<bool?>(
              checkSelectedItemOptionCubit,
              const Stream<bool?>.empty(),
              initialState: false,
            );
            whenListen<QuestionItemOption?>(
              selectedItemOptionValueCubit,
              const Stream<QuestionItemOption?>.empty(),
              initialState: const QuestionBaseItemOption(
                id: 'otherId',
                name: 'name',
                description: 'description',
              ),
            );
            return _TestWidget(
              checkSelectedItemOptionCubit: checkSelectedItemOptionCubit,
              selectedItemOptionValueCubit: selectedItemOptionValueCubit,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'Selected',
          builder: (context) {
            final checkSelectedItemOptionCubit =
                MockCheckSelectedItemOptionCubit();
            final selectedItemOptionValueCubit =
                MockSelectionValueCubit<QuestionItemOption>();
            whenListen<bool?>(
              checkSelectedItemOptionCubit,
              const Stream<bool?>.empty(),
            );
            whenListen<QuestionItemOption?>(
              selectedItemOptionValueCubit,
              const Stream<QuestionItemOption?>.empty(),
              initialState: const QuestionBaseItemOption(
                id: 'id',
                name: 'name',
                description: 'description',
              ),
            );
            return _TestWidget(
              checkSelectedItemOptionCubit: checkSelectedItemOptionCubit,
              selectedItemOptionValueCubit: selectedItemOptionValueCubit,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'Correct',
          builder: (context) {
            final checkSelectedItemOptionCubit =
                MockCheckSelectedItemOptionCubit();
            final selectedItemOptionValueCubit =
                MockSelectionValueCubit<QuestionItemOption>();
            whenListen<bool?>(
              checkSelectedItemOptionCubit,
              const Stream<bool?>.empty(),
              initialState: true,
            );
            whenListen<QuestionItemOption?>(
              selectedItemOptionValueCubit,
              const Stream<QuestionItemOption?>.empty(),
              initialState: const QuestionBaseItemOption(
                id: 'id',
                name: 'name',
                description: 'description',
              ),
            );
            return _TestWidget(
              checkSelectedItemOptionCubit: checkSelectedItemOptionCubit,
              selectedItemOptionValueCubit: selectedItemOptionValueCubit,
              isCorrectOption: true,
            );
          },
        ),
        GoldenTestScenario.builder(
          name: 'Wrong',
          builder: (context) {
            final checkSelectedItemOptionCubit =
                MockCheckSelectedItemOptionCubit();
            final selectedItemOptionValueCubit =
                MockSelectionValueCubit<QuestionItemOption>();
            whenListen<bool?>(
              checkSelectedItemOptionCubit,
              const Stream<bool?>.empty(),
              initialState: false,
            );
            whenListen<QuestionItemOption?>(
              selectedItemOptionValueCubit,
              const Stream<QuestionItemOption?>.empty(),
              initialState: const QuestionBaseItemOption(
                id: 'id',
                name: 'name',
                description: 'description',
              ),
            );
            return _TestWidget(
              checkSelectedItemOptionCubit: checkSelectedItemOptionCubit,
              selectedItemOptionValueCubit: selectedItemOptionValueCubit,
            );
          },
        ),
      ],
    ),
  );
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({
    required this.checkSelectedItemOptionCubit,
    required this.selectedItemOptionValueCubit,
    this.isCorrectOption = false,
  });

  final CheckSelectedItemOptionCubit checkSelectedItemOptionCubit;
  final SelectedItemOptionValueCubit selectedItemOptionValueCubit;
  final bool isCorrectOption;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckSelectedItemOptionCubit>.value(
          value: checkSelectedItemOptionCubit,
        ),
        BlocProvider<SelectedItemOptionValueCubit>.value(
          value: selectedItemOptionValueCubit,
        ),
      ],
      child: SelectionItem.text(
        index: 0,
        isCorrectOption: isCorrectOption,
        option: const QuestionBaseItemOption(
          id: 'id',
          name: 'name',
          description: 'description',
        ),
      ),
    );
  }
}
