part of 'bloc.dart';

@immutable
sealed class ItemDetailState extends Equatable {
  const ItemDetailState();

  @override
  List<Object?> get props => [];
}

final class ItemDetailLoadInProgress extends ItemDetailState {
  const ItemDetailLoadInProgress();
}

final class ItemDetailLoadOnSuccess<Item extends ItemDetail>
    extends ItemDetailState {
  const ItemDetailLoadOnSuccess(this.item);

  final Item item;

  @override
  List<Object?> get props => [item];
}
