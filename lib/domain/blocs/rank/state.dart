part of 'bloc.dart';

sealed class RankState extends Equatable {
  const RankState();

  @override
  List<Object?> get props => [];
}

final class RankLoadInProgress extends RankState {
  const RankLoadInProgress();
}

final class RankLoadOnSuccess extends RankState {
  const RankLoadOnSuccess({required this.rank, required this.lp});

  final Rank rank;
  final int lp;

  @override
  List<Object?> get props => [rank, lp];
}
