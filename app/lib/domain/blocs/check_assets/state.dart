part of 'bloc.dart';

@immutable
sealed class CheckAssetsState extends Equatable {
  const CheckAssetsState();

  @override
  List<Object?> get props => [];
}

final class CheckAssetsInitial extends CheckAssetsState {
  const CheckAssetsInitial();
}

final class CheckAssetsLoadInProgress extends CheckAssetsState {
  const CheckAssetsLoadInProgress();
}

final class CheckAssetsLoadOnSuccess extends CheckAssetsState {
  const CheckAssetsLoadOnSuccess({required this.success});

  final bool success;

  @override
  List<Object?> get props => [success];
}
