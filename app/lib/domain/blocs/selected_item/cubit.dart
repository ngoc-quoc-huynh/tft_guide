import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';

final class SelectedItemOptionCubit extends Cubit<QuestionItemOption?> {
  SelectedItemOptionCubit() : super(null);

  void select(QuestionItemOption option) => emit(
        switch (state == option) {
          true => null,
          false => option,
        },
      );
}
