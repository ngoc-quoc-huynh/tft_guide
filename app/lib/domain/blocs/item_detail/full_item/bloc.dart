part of '../bloc.dart';

final class FullItemDetailBloc extends ItemDetailBloc {
  FullItemDetailBloc()
      : super(ItemDetailBloc.localDatabaseAPI.loadFullItemDetail);
}
