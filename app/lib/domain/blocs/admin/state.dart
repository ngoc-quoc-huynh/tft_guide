part of 'cubit.dart';

@immutable
sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

final class AdminDisabled extends AdminState {
  const AdminDisabled();
}

final class AdminLoadInProgress extends AdminState {
  const AdminLoadInProgress(this.amountOfClicks);

  final int amountOfClicks;

  @override
  List<Object?> get props => [amountOfClicks];
}

final class AdminEnabled extends AdminState {
  const AdminEnabled();
}
