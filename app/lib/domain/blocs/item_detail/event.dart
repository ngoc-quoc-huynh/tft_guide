part of 'bloc.dart';

@immutable
sealed class ItemDetailEvent {
  const ItemDetailEvent();
}

final class ItemDetailInitializeEvent extends ItemDetailEvent {
  const ItemDetailInitializeEvent(this.id);

  final String id;
}
