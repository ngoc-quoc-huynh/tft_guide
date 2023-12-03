part of 'bloc.dart';

sealed class MasonMakeRankedState extends Equatable {
  const MasonMakeRankedState();

  @override
  List<Object?> get props => [];
}

final class MasonMakeRankedLoadInProgress extends MasonMakeRankedState {
  const MasonMakeRankedLoadInProgress();
}

final class MasonMakeRankedLoadOnSuccess extends MasonMakeRankedState {
  const MasonMakeRankedLoadOnSuccess();
}

final class MasonMakeRankedLoadOnFailure extends MasonMakeRankedState {
  const MasonMakeRankedLoadOnFailure();
}
