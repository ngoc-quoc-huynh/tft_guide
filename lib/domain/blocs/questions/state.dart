part of 'bloc.dart';

@immutable
sealed class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object?> get props => [];
}

final class QuestionsLoadInProgress extends QuestionsState {
  const QuestionsLoadInProgress();
}

final class QuestionsLoadOnSuccess extends QuestionsState {
  const QuestionsLoadOnSuccess(this.questions);

  final List<Question> questions;

  @override
  List<Object?> get props => [questions];
}

final class QuestionsLoadOnFailure extends QuestionsState {
  const QuestionsLoadOnFailure();
}
