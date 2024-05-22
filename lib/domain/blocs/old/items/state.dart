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
  const ItemsLoadOnSuccess({required this.baseItems, required this.fullItems});

  final List<BaseItem> baseItems;
  final List<FullItem> fullItems;

  @override
  List<Object?> get props => [baseItems, fullItems];
}
