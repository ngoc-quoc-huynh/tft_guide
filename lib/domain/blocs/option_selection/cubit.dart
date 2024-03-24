import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item.dart';

final class OptionSelectionCubit extends Cubit<Item?> {
  OptionSelectionCubit() : super(null);

  void select(Item newOption) {
    if (state == newOption) {
      emit(null);
    } else {
      emit(newOption);
    }
  }

  void clear() => emit(null);
}
