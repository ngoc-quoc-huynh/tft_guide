part of 'bloc.dart';

@immutable
sealed class QuestionsEvent {
  const QuestionsEvent();
}

final class QuestionsInitializeEvent extends QuestionsEvent {
  const QuestionsInitializeEvent();
}
