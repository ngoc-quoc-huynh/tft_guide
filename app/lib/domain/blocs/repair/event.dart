part of 'bloc.dart';

@immutable
sealed class RepairEvent {
  const RepairEvent();
}

final class RepairStartEvent extends RepairEvent {
  const RepairStartEvent();
}
