part of 'bloc.dart';

@immutable
sealed class CheckBaseItemsEvent {
  const CheckBaseItemsEvent();
}

final class CheckDatabaseStartEvent extends CheckBaseItemsEvent {
  const CheckDatabaseStartEvent();
}
