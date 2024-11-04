import 'dart:math';

import 'package:alchemist/alchemist.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/page.dart';
import 'package:tft_guide/ui/pages/game/selection_item/chip.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final questionsApi = MockQuestionsApi();
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<QuestionsApi>(questionsApi)
      ..registerSingleton<int>(1, instanceName: 'totalBaseItemQuestions')
      ..registerSingleton<int>(1, instanceName: 'totalFullItemQuestions')
      ..registerSingleton<int>(1, instanceName: 'otherOptionsAmount')
      ..registerSingleton<Random>(Random(0))
      ..registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<QuestionsApi>()
      ..unregister<int>(instanceName: 'totalBaseItemQuestions')
      ..unregister<int>(instanceName: 'totalFullItemQuestions')
      ..unregister<int>(instanceName: 'otherOptionsAmount')
      ..unregister<Random>()
      ..unregister<FileStorageApi>(),
  );

  when(() => fileStorageApi.loadFile(any()))
      .thenReturn(MemoryFileSystem().file('test.webp'));

  const baseItemQuestions = [
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
  ];
  const fullItemQuestions = [
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
  ];

  await goldenTest(
    'renders correctly.',
    fileName: 'page',
    constraints: pageConstraints(),
    builder: () {
      when(
        () => questionsApi.generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer((_) async => baseItemQuestions);
      when(
        () => questionsApi.generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer((_) async => fullItemQuestions);
      return const GamePage();
    },
  );

  await goldenTest(
    'renders selected correctly.',
    fileName: 'page_selected',
    constraints: pageConstraints(),
    whilePerforming: (tester) async {
      await tester.tap(find.byType(SelectionChip).first);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(
        () => questionsApi.generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer((_) async => baseItemQuestions);
      when(
        () => questionsApi.generateFullItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer((_) async => fullItemQuestions);
      return const GamePage();
    },
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'page_error',
    constraints: pageConstraints(),
    builder: () {
      when(
        () => questionsApi.generateBaseItemQuestions(
          amount: 1,
          otherOptionsAmount: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenThrow(const UnknownException());
      return const GamePage();
    },
  );
}
