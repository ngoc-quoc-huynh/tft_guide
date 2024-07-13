part of 'bloc.dart';

@immutable
sealed class ItemsEvent {
  const ItemsEvent();
}

final class ItemsInitializeEvent extends ItemsEvent {
  const ItemsInitializeEvent();
}
