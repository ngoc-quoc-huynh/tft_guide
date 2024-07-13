part of 'cubit.dart';

@immutable
sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object?> get props => [];
}

final class FeedbackInitial extends FeedbackState {
  const FeedbackInitial();
}
