import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();
  final random = MockRandom();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<Random>(random),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<Translations>()
      ..unregister<Random>(),
  );

  test(
    'initial state is QuestionsLoadInProgress',
    () => expect(
      QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
      ).state,
      const QuestionsLoadInProgress(),
    ),
  );

  group('QuestionsInitializeEvent', () {
    const correctBaseItemOption = QuestionBaseItemOption(
      id: '1',
      name: 'name',
      description: 'description',
    );
    const otherBaseItemOptions = [
      QuestionBaseItemOption(
        id: '2',
        name: 'name',
        description: 'description',
      ),
      QuestionBaseItemOption(
        id: '3',
        name: 'name',
        description: 'description',
      ),
    ];
    const correctFullItemOption = QuestionFullItemOption(
      id: '1',
      name: 'name',
      description: 'description',
      isSpecial: false,
      itemId1: '1',
      itemId2: '2',
    );
    const correctFullItemOptionSpecial = QuestionFullItemOption(
      id: '1',
      name: 'name',
      description: 'description',
      isSpecial: true,
      itemId1: '1',
      itemId2: '2',
    );
    const otherFullItemOptions = [
      QuestionFullItemOption(
        id: '2',
        name: 'name',
        description: 'description',
        isSpecial: false,
        itemId1: '1',
        itemId2: '3',
      ),
      QuestionFullItemOption(
        id: '3',
        name: 'name',
        description: 'description',
        isSpecial: false,
        itemId1: '1',
        itemId2: '4',
      ),
    ];

    blocTest<QuestionsBloc, QuestionsState>(
      'emits QuestionsLoadOnSuccess',
      setUp: () {
        when(
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctBaseItemOption],
        );
        when(
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctFullItemOption],
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            '1',
            2,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => otherBaseItemOptions,
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            '1',
            2,
            LanguageCode.en,
          ),
        ).thenAnswer((_) async => otherFullItemOptions);
      },
      build: () => QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
      )..add(const QuestionsInitializeEvent()),
      expect: () => [
        const QuestionsLoadOnSuccess(
          [
            TitleImageQuestion(
              correctOption: correctFullItemOption,
              otherOptions: otherFullItemOptions,
            ),
            DescriptionImageQuestion(
              correctOption: correctBaseItemOption,
              otherOptions: otherBaseItemOptions,
            ),
          ],
        ),
      ],
      verify: (_) => verifyInOrder(
        [
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
                1,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
                1,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
                '1',
                2,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
                '1',
                2,
                LanguageCode.en,
              ),
        ],
      ),
    );

    blocTest<QuestionsBloc, QuestionsState>(
      'emits QuestionsLoadOnSuccess when correct full item is special',
      setUp: () {
        when(
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
            0,
            LanguageCode.en,
          ),
        ).thenAnswer((_) async => []);
        when(
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctFullItemOptionSpecial],
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            '1',
            2,
            LanguageCode.en,
          ),
        ).thenAnswer((_) async => otherFullItemOptions);
      },
      build: () => QuestionsBloc(
        totalBaseItemQuestions: 0,
        totalFullItemQuestions: 1,
      )..add(const QuestionsInitializeEvent()),
      expect: () => [
        const QuestionsLoadOnSuccess(
          [
            DescriptionTextQuestion(
              correctOption: correctFullItemOptionSpecial,
              otherOptions: otherFullItemOptions,
            ),
          ],
        ),
      ],
      verify: (_) {
        verifyInOrder(
          [
            () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
                  0,
                  LanguageCode.en,
                ),
            () => localDatabaseApi.loadRandomQuestionFullItemOptions(
                  1,
                  LanguageCode.en,
                ),
            () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
                  '1',
                  2,
                  LanguageCode.en,
                ),
          ],
        );
        verifyNever(
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            any(),
            2,
            LanguageCode.en,
          ),
        );
      },
    );

    blocTest<QuestionsBloc, QuestionsState>(
      'emits QuestionsLoadOnFailure when an error occurs.',
      setUp: () {
        when(
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenThrow(const UnknownException());
      },
      build: () => QuestionsBloc(
        totalBaseItemQuestions: 1,
        totalFullItemQuestions: 1,
      )..add(const QuestionsInitializeEvent()),
      expect: () => [const QuestionsLoadOnFailure()],
      verify: (_) {
        verify(
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
            1,
            LanguageCode.en,
          ),
        ).called(1);
        verifyNever(
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
            1,
            LanguageCode.en,
          ),
        );
        verifyNever(
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            '1',
            2,
            LanguageCode.en,
          ),
        );
        verifyNever(
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            '1',
            2,
            LanguageCode.en,
          ),
        );
      },
    );
  });
}
