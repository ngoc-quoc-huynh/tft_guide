import 'package:flutter_bloc/flutter_bloc.dart';

final class CorrectAnswersCubit extends Cubit<int> {
  CorrectAnswersCubit() : super(0);

  void increase() => emit(state + 1);
}
