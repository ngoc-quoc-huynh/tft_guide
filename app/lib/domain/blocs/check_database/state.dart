part of 'bloc.dart';

@immutable
sealed class CheckDatabaseState extends Equatable {
  const CheckDatabaseState();

  @override
  List<Object?> get props => [];
}

final class CheckDatabaseInitial extends CheckDatabaseState {
  const CheckDatabaseInitial();
}

final class CheckDatabaseLoadInProgress extends CheckDatabaseState {
  const CheckDatabaseLoadInProgress();
}

final class CheckDatabaseLoadOnSuccess extends CheckDatabaseState {
  const CheckDatabaseLoadOnSuccess({required this.success});

  final bool success;

  @override
  List<Object?> get props => [success];
}
