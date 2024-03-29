part of 'bloc.dart';

@immutable
sealed class QuestionEvaluationState {
  const QuestionEvaluationState();
}

final class QuestionEvaluationInitial extends QuestionEvaluationState {
  const QuestionEvaluationInitial();
}

final class QuestionEvaluationCorrectOption extends QuestionEvaluationState {
  const QuestionEvaluationCorrectOption();
}

final class QuestionEvaluationWrongOption extends QuestionEvaluationState {
  const QuestionEvaluationWrongOption();
}
