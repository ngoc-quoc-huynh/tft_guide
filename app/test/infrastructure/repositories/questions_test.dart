import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/infrastructure/repositories/questions.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';
import '../../utils.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<LoggerApi>(),
  );

  group('generateBaseItemQuestions', () {
    const correctOption = QuestionBaseItemOption(
      id: '1',
      name: 'name',
      description: 'description',
    );
    const otherOptions = [
      QuestionBaseItemOption(
        id: '2',
        name: 'name',
        description: 'description',
      ),
    ];

    group('Success', () {
      setUp(() {
        when(
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctOption],
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
            '1',
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => otherOptions,
        );
      });

      tearDown(
        () => verifyInOrder([
          () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
                1,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
                '1',
                1,
                LanguageCode.en,
              ),
        ]),
      );

      test('returns TitleTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(1));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns TitleImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(2));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(4));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(0));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });
    });

    test('throws UnknownException.', () async {
      when(
        () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
          1,
          LanguageCode.en,
        ),
      ).thenThrow(const UnknownException());

      await expectLater(
        const QuestionsRepository().generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
        throwsA(isA<UnknownException>()),
      );

      verify(
        () => localDatabaseApi.loadRandomQuestionBaseItemOptions(
          1,
          LanguageCode.en,
        ),
      ).called(1);
      verifyNever(
        () => localDatabaseApi.loadOtherRandomQuestionBaseItemOptions(
          '1',
          1,
          LanguageCode.en,
        ),
      );
    });
  });

  group('generateFullItemQuestions', () {
    const otherOptions = [
      QuestionFullItemOption(
        id: '2',
        name: 'name',
        description: 'description',
        isSpecial: false,
        itemId1: '2',
        itemId2: '3',
      ),
    ];

    group('is special item', () {
      const correctOption = QuestionFullItemOption(
        id: '1',
        name: 'name',
        description: 'description',
        isSpecial: true,
        itemId1: '1',
        itemId2: '2',
      );

      setUp(() {
        when(
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctOption],
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            '1',
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => otherOptions,
        );
      });

      tearDown(
        () => verifyInOrder([
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
                1,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
                '1',
                1,
                LanguageCode.en,
              ),
        ]),
      );

      test('returns TitleTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(5));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns TitleImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(6));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(11));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(9));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });
    });

    group('is not a special item', () {
      const correctOption = QuestionFullItemOption(
        id: '1',
        name: 'name',
        description: 'description',
        isSpecial: false,
        itemId1: '1',
        itemId2: '2',
      );

      setUp(() {
        when(
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => [correctOption],
        );
        when(
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
            '1',
            1,
            LanguageCode.en,
          ),
        ).thenAnswer(
          (_) async => otherOptions,
        );
      });

      tearDown(
        () => verifyInOrder([
          () => localDatabaseApi.loadRandomQuestionFullItemOptions(
                1,
                LanguageCode.en,
              ),
          () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
                '1',
                1,
                LanguageCode.en,
              ),
        ]),
      );

      when(
        () => localDatabaseApi.loadRandomQuestionFullItemOptions(
          1,
          LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => [correctOption],
      );
      when(
        () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
          '1',
          1,
          LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => otherOptions,
      );

      test('returns TitleTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(24));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns TitleImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(12));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const TitleImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(11));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns DescriptionImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(20));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const DescriptionImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns BaseItemsTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(19));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const BaseItemsTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns BaseItemsImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(13));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const BaseItemsImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns FullItemTextQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(17));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const FullItemTextQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });

      test('returns FullItemImageQuestion.', () async {
        Injector.instance.registerSingleton<Random>(Random(14));
        addTearDown(Injector.instance.unregister<Random>);

        final result =
            await const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        );

        expectList(
          result,
          [
            const FullItemImageQuestion(
              correctOption: correctOption,
              otherOptions: otherOptions,
            ),
          ],
        );
      });
    });

    test('throws UnknownException.', () async {
      when(
        () => localDatabaseApi.loadRandomQuestionFullItemOptions(
          1,
          LanguageCode.en,
        ),
      ).thenThrow(const UnknownException());

      await expectLater(
        const QuestionsRepository().generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
        throwsA(isA<UnknownException>()),
      );

      verify(
        () => localDatabaseApi.loadRandomQuestionFullItemOptions(
          1,
          LanguageCode.en,
        ),
      ).called(1);
      verifyNever(
        () => localDatabaseApi.loadOtherRandomQuestionFullItemOptions(
          '1',
          1,
          LanguageCode.en,
        ),
      );
    });
  });
}
