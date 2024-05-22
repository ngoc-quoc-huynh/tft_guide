import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/old/item.dart';
import 'package:tft_guide/domain/models/old/question.dart';

part 'event.dart';
part 'state.dart';

// TODO: Refactor states maybe to boolean
final class QuestionEvaluationBloc
    extends Bloc<QuestionEvaluationEvent, QuestionEvaluationState> {
  QuestionEvaluationBloc(this._question)
      : super(const QuestionEvaluationInitial()) {
    on<QuestionEvaluationSubmitEvent>(_onQuestionEvaluationSubmitEvent);
  }

  final Question _question;

  void _onQuestionEvaluationSubmitEvent(
    QuestionEvaluationSubmitEvent event,
    Emitter<QuestionEvaluationState> emit,
  ) {
    if (event.option == _question.correctOption) {
      emit(const QuestionEvaluationCorrectOption());
    } else {
      emit(const QuestionEvaluationWrongOption());
    }
  }
}
