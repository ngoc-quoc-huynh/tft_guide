part of 'bloc.dart';

@immutable
sealed class QuestionItemState extends Equatable {
  const QuestionItemState();

  @override
  List<Object?> get props => [];
}

final class QuestionItemLoadInProgress extends QuestionItemState {
  const QuestionItemLoadInProgress();
}

final class QuestionItemLoadOnSuccess<Item extends QuestionItem>
    extends QuestionItemState {
  const QuestionItemLoadOnSuccess(this.item);

  final QuestionItem item;

  @override
  List<Object?> get props => [item];
}
