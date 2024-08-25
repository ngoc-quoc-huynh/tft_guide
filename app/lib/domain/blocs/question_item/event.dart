part of 'bloc.dart';

@immutable
sealed class QuestionItemEvent {
  const QuestionItemEvent();
}

final class QuestionItemInitializeEvent extends QuestionItemEvent {
  const QuestionItemInitializeEvent(this.id);

  final String id;
}
