import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required this.totalBaseItemQuestions,
    required this.totalFullItemQuestions,
  }) : super(const QuestionsLoadInProgress()) {
    on<QuestionsInitializeEvent>(_onQuestionsInitializeEvent);
  }

  final int totalBaseItemQuestions;
  final int totalFullItemQuestions;

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static const _baseItemQuestionAmount = 3;
  static const _fullItemQuestionAmount = 7;

  static LanguageCode get _languageCode => Injector.instance.languageCode;

  Future<void> _onQuestionsInitializeEvent(
    QuestionsInitializeEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    final (baseItemOptions, fullItemOptions) = await _loadRandomQuestionItems();
    final (baseItemQuestions, fullItemQuestions) = await (
      _buildQuestionsForBaseItem(baseItemOptions),
      _buildQuestionsForFullItem(fullItemOptions),
    ).wait;
    final questions = [...baseItemQuestions, ...fullItemQuestions]..shuffle();
    emit(QuestionsLoadOnSuccess(questions));
  }

  Future<(List<QuestionBaseItemOption>, List<QuestionFullItemOption>)>
      _loadRandomQuestionItems() => (
            _localDatabaseApi.loadRandomQuestionBaseItemOptions(
              _baseItemQuestionAmount,
              _languageCode,
            ),
            _localDatabaseApi.loadRandomQuestionFullItemOptions(
              _fullItemQuestionAmount,
              _languageCode,
            ),
          ).wait;

  Future<List<Question>> _buildQuestionsForBaseItem(
    List<QuestionBaseItemOption> itemOptions,
  ) async {
    final questionKind = _baseItemQuestionKinds.random();
    final other = await _loadOtherRandomBaseItemOptions(itemOptions);
    return itemOptions
        .mapIndexed(
          (index, correctOption) => Function.apply(
            questionKind,
            null,
            {
              #correctOption: correctOption,
              #otherOptions: other[index],
            },
          ) as Question,
        )
        .toList();
  }

  Future<List<Question>> _buildQuestionsForFullItem(
    List<QuestionFullItemOption> itemOptions,
  ) async {
    final other = await _loadOtherRandomFUllItemOptions(itemOptions);
    return itemOptions
        .mapIndexed(
          (index, correctOption) => Function.apply(
            switch (correctOption.isSpecial) {
              false => _fullItemQuestionKinds.random(),
              true => _baseItemQuestionKinds.random(),
            },
            null,
            {
              #correctOption: correctOption,
              #otherOptions: other[index],
            },
          ) as Question,
        )
        .toList();
  }

  Future<List<List<QuestionBaseItemOption>>> _loadOtherRandomBaseItemOptions(
    List<QuestionBaseItemOption> itemOptions,
  ) =>
      itemOptions
          .map(
            (option) =>
                _localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
              option.id,
              2,
              _languageCode,
            ),
          )
          .wait;

  Future<List<List<QuestionFullItemOption>>> _loadOtherRandomFUllItemOptions(
    List<QuestionFullItemOption> itemOptions,
  ) =>
      itemOptions
          .map(
            (option) =>
                _localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
              option.id,
              2,
              _languageCode,
            ),
          )
          .wait;

  static const _baseItemQuestionKinds = [
    TitleTextQuestion.new,
    TitleImageQuestion.new,
    DescriptionTextQuestion.new,
    DescriptionImageQuestion.new,
  ];

  static const _fullItemQuestionKinds = [
    ..._baseItemQuestionKinds,
    BaseItemsTextQuestion.new,
    BaseItemsImageQuestion.new,
    FullItemTextQuestion.new,
    FullItemImageQuestion.new,
  ];
}
