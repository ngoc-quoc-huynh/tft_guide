part of 'bloc.dart';

@immutable
sealed class QuestionEvaluationEvent {
  const QuestionEvaluationEvent();
}

final class QuestionEvaluationSubmitEvent extends QuestionEvaluationEvent {
  const QuestionEvaluationSubmitEvent(this.option);

  final Item option;
}
