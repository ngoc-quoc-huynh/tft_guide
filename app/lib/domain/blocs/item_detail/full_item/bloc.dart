part of '../bloc.dart';

final class FullItemDetailBloc extends ItemDetailBloc<FullItemDetail> {
  FullItemDetailBloc()
      : super(ItemDetailBloc.localDatabaseAPI.loadFullItemDetail);
}
