part of 'bloc.dart';

@immutable
sealed class GameProgressEvent {
  const GameProgressEvent();
}

final class GameProgressNextEvent extends GameProgressEvent {
  const GameProgressNextEvent();
}
