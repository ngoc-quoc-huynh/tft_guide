import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/domain/models/question_item2.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

// TODO: Refactor and maybe the API should return also other items.
final class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(const QuestionsLoadInProgress()) {
    on<QuestionsInitializeEvent>(_onQuestionsInitializeEvent);
  }

  final _questionsApi = Injector.instance.questionsApi;

  Future<void> _onQuestionsInitializeEvent(
    QuestionsInitializeEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    final baseItems = await _questionsApi.loadRandomQuestionBaseItems(3);
    final baseItemQuestions =
        await baseItems.map(_buildQuestionsForBaseItem).wait;
    final fullItems = await _questionsApi.loadRandomQuestionFullItems(7);
    final fullItemQuestions =
        await fullItems.map(_buildQuestionsForFullItem).wait;
    final questions = [...baseItemQuestions, ...fullItemQuestions]..shuffle();
    emit(QuestionsLoadOnSuccess(questions));
  }

  Future<Question> _buildQuestionsForBaseItem(QuestionBaseItem item) async {
    final questionKind = _baseQuestionKinds.random();
    return Function.apply(
      questionKind,
      null,
      {
        #correctItem: item,
        #otherItems: await _questionsApi.loadRandomQuestionBaseItems(2),
      },
    ) as Question;
  }

  Future<Question> _buildQuestionsForFullItem(QuestionFullItem item) async {
    final questionKind = switch (item.isSpecial) {
      false => _fullQuestionKinds.random(),
      true => _baseQuestionKinds.random(),
    };

    return Function.apply(
      questionKind,
      null,
      {
        #correctItem: item,
        #otherItems: await _questionsApi.loadRandomQuestionFullItems(2),
      },
    ) as Question;
  }

  static const _baseQuestionKinds = [
    TitleTextQuestion.new,
    TitleImageQuestion.new,
    DescriptionTextQuestion.new,
    DescriptionImageQuestion.new,
  ];

  static const _fullQuestionKinds = [
    ..._baseQuestionKinds,
    BaseItemsTextQuestion.new,
    BaseItemsImageQuestion.new,
    FullItemTextQuestion.new,
    FullItemImageQuestion.new,
  ];
}
