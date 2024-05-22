import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/old/item.dart';

// TODO: Maybe refactor to a value cubit
final class OptionSelectionCubit extends Cubit<Item?> {
  OptionSelectionCubit() : super(null);

  void select(Item newOption) => emit(newOption);
}
