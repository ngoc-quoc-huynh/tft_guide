import 'dart:math';

import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/body.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<Random>(Random(0))
      ..registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<FileStorageApi>(),
  );

  when(() => fileStorageApi.loadFile(any()))
      .thenReturn(MemoryFileSystem().file('test.webp'));

  final gameProgressBloc = MockGameProgressBloc();
  whenListen<GameProgressState>(
    gameProgressBloc,
    const Stream<GameProgressState>.empty(),
    initialState: const GameProgressInProgress(0),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'body',
    builder: () => GoldenTestGroup(
      scenarioConstraints: pageConstraints(),
      children: [
        GoldenTestScenario(
          name: 'BaseItemsTextQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const BaseItemsTextQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'BaseItemsImageQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const BaseItemsImageQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'FullItemTextQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const FullItemTextQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'FullItemImageQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const FullItemImageQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'TitleTextQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const TitleTextQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'TitleImageQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const TitleImageQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'DescriptionTextQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const DescriptionTextQuestion(
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
          ),
        ),
        GoldenTestScenario(
          name: 'DescriptionImageQuestion',
          child: _TestWidget(
            gameProgressBloc: gameProgressBloc,
            question: const DescriptionImageQuestion(
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
          ),
        ),
      ],
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget({
    required this.gameProgressBloc,
    required this.question,
  });

  final GameProgressBloc gameProgressBloc;
  final Question question;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameProgressBloc>.value(
      value: gameProgressBloc,
      child: GameBody(
        questions: [question],
      ),
    );
  }
}
