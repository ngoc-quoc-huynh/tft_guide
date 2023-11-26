part of 'bloc.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

final class ItemsLoadInProgress extends ItemsState {
  const ItemsLoadInProgress();
}

final class ItemsLoadOnSuccess extends ItemsState {
  const ItemsLoadOnSuccess(this.items);

  final List<Item> items;

  @override
  List<Object?> get props => [items];
}
