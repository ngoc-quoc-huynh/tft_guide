part of 'bloc.dart';

@immutable
sealed class ItemMetasState extends Equatable {
  const ItemMetasState();

  @override
  List<Object?> get props => [];
}

final class ItemMetasLoadInProgress extends ItemMetasState {
  const ItemMetasLoadInProgress();
}

final class ItemMetasLoadOnSuccess extends ItemMetasState {
  const ItemMetasLoadOnSuccess(this.items);

  final List<ItemMeta> items;
}

final class ItemMetasLoadOnFailure extends ItemMetasState {
  const ItemMetasLoadOnFailure();
}
