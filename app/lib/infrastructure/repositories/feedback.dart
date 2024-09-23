import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

@immutable
final class FeedbackRepository with LoggerMixin implements FeedbackApi {
  const FeedbackRepository();

  @override
  String getFeedback({required bool isCorrect}) {
    final feedback = switch (isCorrect) {
      false => _wrongFeedback.sample(1),
      true => _correctTranslations.sample(1),
    }
        .first;
    logInfo(
      'FeedbackRepository.getFeedback',
      'Retrieved feedback: $feedback',
      parameters: {'isCorrect': isCorrect.toString()},
      stackTrace: StackTrace.current,
    );
    return feedback;
  }

  static TranslationsPagesGameFeedbackEn get _translations =>
      Injector.instance.translations.pages.game.feedback;

  static List<String> get _correctTranslations => _translations.correct;

  static List<String> get _wrongFeedback => _translations.wrong;
}
