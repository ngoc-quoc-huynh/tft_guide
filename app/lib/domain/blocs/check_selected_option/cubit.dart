import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';

final class CheckSelectedItemOptionCubit extends Cubit<bool?> {
  CheckSelectedItemOptionCubit(this._correctOption) : super(null);

  final QuestionItemOption _correctOption;

  void check(QuestionItemOption option) => emit(option == _correctOption);
}
