import 'package:flutter/foundation.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/question.dart';

abstract interface class QuestionsApi {
  const QuestionsApi();

  Future<List<Question>> generateBaseItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  });

  Future<List<Question>> generateFullItemQuestions({
    required int amount,
    required int otherOptionsAmount,
    required LanguageCode languageCode,
  });

  @protected
  static const baseItemQuestionKinds = [
    TitleTextQuestion.new,
    TitleImageQuestion.new,
    DescriptionTextQuestion.new,
    DescriptionImageQuestion.new,
  ];

  @protected
  static const fullItemQuestionKinds = [
    ...baseItemQuestionKinds,
    BaseItemsTextQuestion.new,
    BaseItemsImageQuestion.new,
    FullItemTextQuestion.new,
    FullItemImageQuestion.new,
  ];
}
