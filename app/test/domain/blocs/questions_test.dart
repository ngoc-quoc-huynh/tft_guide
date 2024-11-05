import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final questionsApi = MockQuestionsApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<QuestionsApi>(questionsApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<QuestionsApi>()
      ..unregister<Translations>(),
  );

  test(
    'initial state is QuestionsLoadInProgress',
    () => expect(
      QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
        otherOptionsAmount: 1,
      ).state,
      const QuestionsLoadInProgress(),
    ),
  );

  group('QuestionsInitializeEvent', () {
    blocTest<QuestionsBloc, QuestionsState>(
      'emits QuestionsLoadOnSuccess.',
      build: () => QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
        otherOptionsAmount: 1,
      ),
      act: (bloc) => bloc.add(const QuestionsInitializeEvent()),
      setUp: () {
        Injector.instance.registerSingleton<Random>(Random(0));
        when(
          () => questionsApi.generateBaseItemQuestions(
            amount: 1,
            otherOptionsAmount: 1,
            languageCode: LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [
            const TitleTextQuestion(
              correctOption: QuestionBaseItemOption(
                id: '1',
                name: 'name',
                description: 'description',
              ),
              otherOptions: <QuestionBaseItemOption>[
                QuestionBaseItemOption(
                  id: '2',
                  name: 'name',
                  description: 'description',
                ),
              ],
            ),
          ],
        );
        when(
          () => questionsApi.generateFullItemQuestions(
            amount: 1,
            otherOptionsAmount: 1,
            languageCode: LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [
            const TitleTextQuestion(
              correctOption: QuestionFullItemOption(
                id: '1',
                name: 'name',
                description: 'description',
                isSpecial: false,
                itemId1: '1',
                itemId2: '1',
              ),
              otherOptions: <QuestionFullItemOption>[
                QuestionFullItemOption(
                  id: '2',
                  name: 'name',
                  description: 'description',
                  isSpecial: false,
                  itemId1: '1',
                  itemId2: '2',
                ),
              ],
            ),
          ],
        );
      },
      tearDown: Injector.instance.unregister<Random>,
      expect: () => const [
        QuestionsLoadOnSuccess([
          TitleTextQuestion(
            correctOption: QuestionBaseItemOption(
              id: '1',
              name: 'name',
              description: 'description',
            ),
            otherOptions: <QuestionBaseItemOption>[
              QuestionBaseItemOption(
                id: '2',
                name: 'name',
                description: 'description',
              ),
            ],
          ),
          TitleTextQuestion(
            correctOption: QuestionFullItemOption(
              id: '1',
              name: 'name',
              description: 'description',
              isSpecial: false,
              itemId1: '1',
              itemId2: '1',
            ),
            otherOptions: <QuestionFullItemOption>[
              QuestionFullItemOption(
                id: '2',
                name: 'name',
                description: 'description',
                isSpecial: false,
                itemId1: '1',
                itemId2: '2',
              ),
            ],
          ),
        ]),
      ],
      verify: (_) => verifyInOrder(
        [
          () => questionsApi.generateBaseItemQuestions(
                amount: 1,
                otherOptionsAmount: 1,
                languageCode: LanguageCode.en,
              ),
          () => questionsApi.generateFullItemQuestions(
                amount: 1,
                otherOptionsAmount: 1,
                languageCode: LanguageCode.en,
              ),
        ],
      ),
    );

    blocTest<QuestionsBloc, QuestionsState>(
      'emits QuestionsLoadOnSuccess.',
      build: () => QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
        otherOptionsAmount: 1,
      ),
      act: (bloc) => bloc.add(const QuestionsInitializeEvent()),
      setUp: () {
        when(
          () => questionsApi.generateBaseItemQuestions(
            amount: 1,
            otherOptionsAmount: 1,
            languageCode: LanguageCode.en,
          ),
        ).thenThrow(const UnknownException());
      },
      expect: () => const [QuestionsLoadOnFailure()],
      verify: (_) {
        verify(
          () => questionsApi.generateBaseItemQuestions(
            amount: 1,
            otherOptionsAmount: 1,
            languageCode: LanguageCode.en,
          ),
        );
        verifyNever(
          () => questionsApi.generateFullItemQuestions(
            amount: 1,
            otherOptionsAmount: 1,
            languageCode: LanguageCode.en,
          ),
        );
      },
    );
  });
}
