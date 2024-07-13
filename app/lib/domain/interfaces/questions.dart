import 'package:tft_guide/domain/models/question_item.dart';

abstract interface class QuestionsAPI {
  const QuestionsAPI();

  Future<List<QuestionBaseItem>> loadRandomQuestionBaseItems(int amount);

  Future<List<QuestionFullItem>> loadRandomQuestionFullItems(int amount);
}
