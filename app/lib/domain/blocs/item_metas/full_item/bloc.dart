part of '../bloc.dart';

final class FullItemMetasBloc extends ItemMetasBloc {
  FullItemMetasBloc() : super(ItemMetasBloc.localDatabaseAPI.loadFullItemMetas);
}
