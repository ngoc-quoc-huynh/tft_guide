part of '../bloc.dart';

final class BaseItemMetasBloc extends ItemMetasBloc {
  BaseItemMetasBloc() : super(ItemMetasBloc.localDatabaseAPI.loadBaseItemMetas);
}
