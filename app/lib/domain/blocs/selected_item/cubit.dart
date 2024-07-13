import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question_item.dart';

final class SelectedItemCubit extends Cubit<QuestionItem?> {
  SelectedItemCubit() : super(null);

  void select(QuestionItem item) => emit(
        switch (state == item) {
          true => null,
          false => item,
        },
      );
}
