part of '../bloc.dart';

final class BaseItemDetailBloc extends ItemDetailBloc<BaseItemDetail> {
  BaseItemDetailBloc()
      : super(ItemDetailBloc.localDatabaseAPI.loadBaseItemDetail);
}
