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

sealed class CheckDataLoadOnSuccess extends CheckDataState {
  const CheckDataLoadOnSuccess();
}

sealed class CheckDataLoadOnValid extends CheckDataLoadOnSuccess {
  const CheckDataLoadOnValid();
}

sealed class CheckDataLoadOnInvalid extends CheckDataLoadOnSuccess {
  const CheckDataLoadOnInvalid();
}

final class CheckDataLoadOnFailure extends CheckDataState {
  const CheckDataLoadOnFailure();
}
