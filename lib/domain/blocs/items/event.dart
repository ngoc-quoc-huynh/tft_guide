part of 'bloc.dart';

sealed class ItemsEvent {
  const ItemsEvent();
}

final class ItemsInitializeEvent extends ItemsEvent {
  const ItemsInitializeEvent();
}
