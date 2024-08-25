part of '../bloc.dart';

final class QuestionBaseItemBloc extends QuestionItemBloc<QuestionBaseItem> {
  QuestionBaseItemBloc()
      : super(QuestionItemBloc.localDatabaseAPI.loadQuestionBaseItem);
}
