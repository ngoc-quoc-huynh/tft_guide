import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';

part 'event.dart';
part 'state.dart';

final class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required this.baseItems,
    required this.fullItems,
  }) : super(const QuestionsLoadInProgress()) {
    on<QuestionsInitializeEvent>(_onQuestionsInitializeEvent);
  }

  final List<BaseItem> baseItems;
  final List<FullItem> fullItems;

  void _onQuestionsInitializeEvent(
    QuestionsInitializeEvent event,
    Emitter<QuestionsState> emit,
  ) {
    final questions = <Question>[
      ..._generateQuestionsForBaseItems(),
      ..._generateQuestionsForFullItems(),
    ];
    emit(QuestionsLoadOnSuccess(questions));
  }

  List<Question> _generateQuestionsForBaseItems() {
    final questions = <Question>[];
    final randomBaseItems = baseItems.sample(3);
    for (final item in randomBaseItems) {
      final questionKind = [
        TitleQuestion.fromBaseItem,
        DescriptionQuestion.fromBaseItem,
      ].sample(1).first;
      final optionItems =
          baseItems.sampleWithoutElement(2, ignore: (e) => e == item);
      final namedArguments = {
        #type: QuestionType.random(),
        #correctOption: item,
        #options: optionItems,
      };

      final question = Function.apply(
        questionKind,
        null,
        namedArguments,
      ) as Question;
      questions.add(question);
    }

    return questions;
  }

  List<Question> _generateQuestionsForFullItems() {
    final questions = <Question>[];
    final randomFullItems = fullItems.sample(7);
    for (final item in randomFullItems) {
      final questionKinds = [
        TitleQuestion.fromFullItem,
        DescriptionQuestion.fromFullItem,
        if (!item.isSpecial) ...[
          BaseComponentsQuestion.build,
          FullItemQuestion.build,
        ],
      ];
      final questionKind = questionKinds.sample(1).first;
      final optionItems = fullItems.sampleWithoutElement(
        2,
        ignore: (e) =>
            e == item &&
            (e.component1 != item.component1 &&
                e.component2 != item.component1),
      );
      final namedArguments = {
        #type: QuestionType.random(),
        #correctOption: item,
        #option1: optionItems.first,
        #option2: optionItems[1],
      };

      final question = Function.apply(
        questionKind,
        null,
        namedArguments,
      ) as Question;
      questions.add(question);
    }

    return questions;
  }
}
