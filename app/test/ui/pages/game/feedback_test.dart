import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';

import '../../../mocks.dart';

Future<void> main() async {
  final feedbackApi = MockFeedbackApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<FeedbackApi>(feedbackApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<FeedbackApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'feedback',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario.builder(
          name: 'Correct',
          builder: (context) {
            when(() => feedbackApi.getFeedback(isCorrect: true))
                .thenReturn('Correct');
            return const FeedbackBottomSheet(isCorrect: true);
          },
        ),
        GoldenTestScenario.builder(
          name: 'Wrong',
          builder: (context) {
            when(() => feedbackApi.getFeedback(isCorrect: false))
                .thenReturn('Wrong');
            return const FeedbackBottomSheet(isCorrect: false);
          },
        ),
      ],
    ),
  );
}
