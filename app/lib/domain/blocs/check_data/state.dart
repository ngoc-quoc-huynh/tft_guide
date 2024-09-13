part of 'bloc.dart';

@immutable
sealed class CheckDataState extends Equatable {
  const CheckDataState();

  @override
  List<Object?> get props => [];
}

final class CheckDataInitial extends CheckDataState {
  const CheckDataInitial();
}

final class CheckDataLoadInProgress extends CheckDataState {
  const CheckDataLoadInProgress();
}

final class CheckDataLoadOnSuccess extends CheckDataState {
  const CheckDataLoadOnSuccess({required this.success});

  final bool success;

  @override
  List<Object?> get props => [success];
}
