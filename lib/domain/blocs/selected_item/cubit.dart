import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/item.dart';

final class SelectedItemCubit extends Cubit<Item?> {
  SelectedItemCubit() : super(null);

  void select(Item item) => emit(
        switch (state == item) {
          true => null,
          false => item,
        },
      );
}
