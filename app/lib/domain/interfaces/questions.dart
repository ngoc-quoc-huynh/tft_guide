import 'package:tft_guide/domain/models/question_item2.dart';

abstract interface class QuestionsApi {
  const QuestionsApi();

  Future<List<QuestionBaseItem>> loadRandomQuestionBaseItems(int amount);

  Future<List<QuestionFullItem>> loadRandomQuestionFullItems(int amount);
}
