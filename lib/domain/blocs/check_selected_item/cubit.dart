import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item.dart';

final class CheckSelectedItemCubit extends Cubit<bool?> {
  CheckSelectedItemCubit(this._correctItem) : super(null);
  final Item _correctItem;

  void check(Item item) => emit(item == _correctItem);
}
