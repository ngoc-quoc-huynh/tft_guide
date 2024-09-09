part of 'bloc.dart';

@immutable
sealed class RankEvent {
  const RankEvent();
}

final class RankInitializeEvent extends RankEvent {
  const RankInitializeEvent(this.elo);

  final int elo;
}
