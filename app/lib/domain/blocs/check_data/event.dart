part of 'bloc.dart';

@immutable
sealed class CheckDataEvent {
  const CheckDataEvent();
}

final class CheckDataStartEvent extends CheckDataEvent {
  const CheckDataStartEvent();
}
