import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question_item2.dart';

final class CheckSelectedItemCubit extends Cubit<bool?> {
  CheckSelectedItemCubit(this._correctItem) : super(null);

  final QuestionItem _correctItem;

  void check(QuestionItem item) => emit(item == _correctItem);
}
