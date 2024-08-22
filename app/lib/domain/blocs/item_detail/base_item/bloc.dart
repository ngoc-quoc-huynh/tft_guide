part of '../bloc.dart';

final class BaseItemDetailBloc extends ItemDetailBloc {
  BaseItemDetailBloc()
      : super(ItemDetailBloc.localDatabaseAPI.loadBaseItemDetail);
}
