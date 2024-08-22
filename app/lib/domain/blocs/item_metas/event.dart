part of 'bloc.dart';

@immutable
sealed class ItemMetasEvent {
  const ItemMetasEvent();
}

final class ItemMetasInitializeEvent extends ItemMetasEvent {
  const ItemMetasInitializeEvent();
}
