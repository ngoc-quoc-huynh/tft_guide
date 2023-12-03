part of 'bloc.dart';

sealed class RankEvent {
  const RankEvent();
}

final class RankUpdateEvent extends RankEvent {
  const RankUpdateEvent(this.elo);

  final int elo;
}
