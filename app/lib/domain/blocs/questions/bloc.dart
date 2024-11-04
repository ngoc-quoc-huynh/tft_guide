import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState>
    with BlocMixin {
  QuestionsBloc({
    required this.totalBaseItemQuestions,
    required this.totalFullItemQuestions,
    required this.otherOptionsAmount,
  }) : super(const QuestionsLoadInProgress()) {
    on<QuestionsInitializeEvent>(
      _onQuestionsInitializeEvent,
      transformer: droppable(),
    );
  }

  final int totalBaseItemQuestions;
  final int totalFullItemQuestions;
  final int otherOptionsAmount;

  static final _questionsApi = Injector.instance.questionsApi;

  Future<void> _onQuestionsInitializeEvent(
    QuestionsInitializeEvent event,
    Emitter<QuestionsState> emit,
  ) =>
      executeSafely(
        methodName: 'QuestionsBloc._onQuestionsInitializeEvent',
        function: () async {
          final languageCode = Injector.instance.languageCode;
          final [baseItemQuestions, fullItemQuestions] = await Future.wait(
            [
              _questionsApi.generateBaseItemQuestions(
                amount: totalBaseItemQuestions,
                otherOptionsAmount: otherOptionsAmount,
                languageCode: languageCode,
              ),
              _questionsApi.generateFullItemQuestions(
                amount: totalFullItemQuestions,
                otherOptionsAmount: otherOptionsAmount,
                languageCode: languageCode,
              ),
            ],
            eagerError: true,
          );

          final questions = [...baseItemQuestions, ...fullItemQuestions]
            ..shuffle(Injector.instance.random);
          emit(QuestionsLoadOnSuccess(questions));
        },
        onError: () => emit(const QuestionsLoadOnFailure()),
      );
}
