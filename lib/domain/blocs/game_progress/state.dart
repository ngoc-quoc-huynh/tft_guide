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

final class GameProgressOnLastLevel extends GameProgressState {
  const GameProgressOnLastLevel(super.currentProgress);
}
