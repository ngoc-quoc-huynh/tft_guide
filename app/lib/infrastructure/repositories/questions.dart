import 'package:collection/collection.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/domain/utils/extensions/list.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

final class QuestionsRepository with LoggerMixin implements QuestionsApi {
  const QuestionsRepository();

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  @override
  Future<List<Question>> generateBaseItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  }) async {
    const methodName = 'QuestionsRepository.generateBaseItemQuestions';
    final parameters = {
      'amount': amount.toString(),
      'languageCode': languageCode.name,
    };

    try {
      final correctOptions =
          await _localDatabaseApi.loadRandomQuestionBaseItemOptions(
        amount,
        languageCode,
      );
      final otherOptions = await _loadOtherOptionsForBaseItems(
        correctOptions,
        otherOptionsAmount,
        languageCode,
      );

      final questions =
          _buildQuestionForBaseItems(correctOptions, otherOptions);
      logInfo(
        methodName,
        'Generated ${questions.length} questions for base items.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return questions;
    } on Exception catch (e, stackTrace) {
      logException(
        methodName,
        exception: e,
        parameters: parameters,
        stackTrace: stackTrace,
      );
      Error.throwWithStackTrace(const UnknownException(), stackTrace);
    }
  }

  @override
  Future<List<Question>> generateFullItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  }) async {
    const methodName = 'QuestionsRepository.generateFullItemQuestions';
    final parameters = {
      'amount': amount.toString(),
      'languageCode': languageCode.name,
    };

    try {
      final correctOptions =
          await _localDatabaseApi.loadRandomQuestionFullItemOptions(
        amount,
        languageCode,
      );
      final otherOptions = await _loadOtherOptionsForFullItems(
        correctOptions,
        otherOptionsAmount,
        languageCode,
      );

      final questions =
          _buildQuestionsForFullItems(correctOptions, otherOptions);
      logInfo(
        methodName,
        'Generated ${questions.length} questions for full items.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return questions;
    } on Exception catch (e, stackTrace) {
      logException(
        methodName,
        exception: e,
        parameters: parameters,
        stackTrace: stackTrace,
      );
      Error.throwWithStackTrace(const UnknownException(), stackTrace);
    }
  }

  Future<List<List<QuestionItemOption>>> _loadOtherOptionsForBaseItems(
    List<QuestionBaseItemOption> options,
    int amount,
    LanguageCode languageCode,
  ) =>
      Future.wait(
        options.map(
          (option) => _localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            option.id,
            amount,
            languageCode,
          ),
        ),
      );

  Future<List<List<QuestionItemOption>>> _loadOtherOptionsForFullItems(
    List<QuestionFullItemOption> options,
    int amount,
    LanguageCode languageCode,
  ) =>
      Future.wait(
        options.map(
          (option) => _localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            option.id,
            amount,
            languageCode,
          ),
        ),
      );

  List<Question> _buildQuestionForBaseItems(
    List<QuestionBaseItemOption> correctOptions,
    List<List<QuestionItemOption>> otherOptions,
  ) =>
      correctOptions
          .mapIndexed(
            (index, option) => Function.apply(
              QuestionsApi.baseItemQuestionKinds.random,
              null,
              {
                #correctOption: option,
                #otherOptions: otherOptions[index],
              },
            ) as Question,
          )
          .toList();

  List<Question> _buildQuestionsForFullItems(
    List<QuestionFullItemOption> correctOptions,
    List<List<QuestionItemOption>> otherOptions,
  ) =>
      correctOptions
          .mapIndexed(
            (index, correctOption) => Function.apply(
              switch (correctOption.isSpecial) {
                false => QuestionsApi.fullItemQuestionKinds.random,
                true => QuestionsApi.baseItemQuestionKinds.random,
              },
              null,
              {
                #correctOption: correctOption,
                #otherOptions: otherOptions[index],
              },
            ) as Question,
          )
          .toList();
}
