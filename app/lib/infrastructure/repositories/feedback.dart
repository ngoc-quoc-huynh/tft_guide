import 'package:collection/collection.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

final class FeedbackRepository implements FeedbackApi {
  const FeedbackRepository();

  @override
  String getFeedback({required bool isCorrect}) => switch (isCorrect) {
        false => _wrongFeedback.sample(1),
        true => _correctTranslations.sample(1),
      }
          .first;

  TranslationsPagesGameFeedbackDe get _translations =>
      Injector.instance.translations.pages.game.feedback;

  List<String> get _correctTranslations => _translations.correct;

  List<String> get _wrongFeedback => _translations.wrong;
}
