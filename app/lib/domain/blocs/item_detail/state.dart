part of 'bloc.dart';

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
  const ItemDetailLoadOnSuccess({
    required this.item,
    required this.themeData,
  });

  final Item item;
  final ThemeData? themeData;

  @override
  List<Object?> get props => [
        item,
        themeData,
      ];
}

final class ItemDetailLoadOnFailure extends ItemDetailState {
  const ItemDetailLoadOnFailure();
}
