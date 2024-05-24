part of 'bloc.dart';

@immutable
sealed class GameProgressState extends Equatable {
  const GameProgressState(this.currentProgress);

  final int currentProgress;

  @override
  List<Object?> get props => [currentProgress];
}

final class GameProgressInProgress extends GameProgressState {
  const GameProgressInProgress(super.currentProgress);
}

final class GameProgressFinished extends GameProgressState {
  const GameProgressFinished(super.currentProgress);
}
