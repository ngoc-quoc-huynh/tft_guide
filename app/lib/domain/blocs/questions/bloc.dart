import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState>
    with BlocMixin {
  QuestionsBloc({
    required this.totalBaseItemQuestions,
    required this.totalFullItemQuestions,
  }) : super(const QuestionsLoadInProgress()) {
    on<QuestionsInitializeEvent>(
      _onQuestionsInitializeEvent,
      transformer: droppable(),
    );
  }

  final int totalBaseItemQuestions;
  final int totalFullItemQuestions;

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static LanguageCode get _languageCode => Injector.instance.languageCode;

  Future<void> _onQuestionsInitializeEvent(
    QuestionsInitializeEvent event,
    Emitter<QuestionsState> emit,
  ) =>
      executeSafely(
        methodName: 'QuestionsBloc._onQuestionsInitializeEvent',
        function: () async {
          final [baseItemOptions, fullItemOptions] =
              await _loadRandomQuestionItems();
          final (baseItemQuestions, fullItemQuestions) = await (
            _buildQuestionsForBaseItem(
              baseItemOptions as List<QuestionBaseItemOption>,
            ),
            _buildQuestionsForFullItem(
              fullItemOptions as List<QuestionFullItemOption>,
            ),
          ).wait;
          final questions = [...baseItemQuestions, ...fullItemQuestions]
            ..shuffle(Injector.instance.random);
          emit(QuestionsLoadOnSuccess(questions));
        },
        onError: () => emit(const QuestionsLoadOnFailure()),
      );

  Future<List<List<QuestionItemOption>>> _loadRandomQuestionItems() =>
      Future.wait(
        [
          _localDatabaseApi.loadRandomQuestionBaseItemOptions(
            totalBaseItemQuestions,
            _languageCode,
          ),
          _localDatabaseApi.loadRandomQuestionFullItemOptions(
            totalFullItemQuestions,
            _languageCode,
          ),
        ],
        eagerError: true,
      );

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
      Future.wait(
        itemOptions.map(
          (option) => _localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            option.id,
            2,
            _languageCode,
          ),
        ),
        eagerError: true,
      );

  Future<List<List<QuestionFullItemOption>>> _loadOtherRandomFUllItemOptions(
    List<QuestionFullItemOption> itemOptions,
  ) =>
      Future.wait(
        itemOptions.map(
          (option) => _localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            option.id,
            2,
            _languageCode,
          ),
        ),
        eagerError: true,
      );

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
