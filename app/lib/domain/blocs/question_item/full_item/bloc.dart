part of '../bloc.dart';

final class QuestionFullItemBloc extends QuestionItemBloc<QuestionFullItem> {
  QuestionFullItemBloc()
      : super(QuestionItemBloc.localDatabaseAPI.loadQuestionFullItem);
}
