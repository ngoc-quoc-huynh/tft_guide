import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  FeedbackAPI get feedbackAPI => get<FeedbackAPI>();

  ItemsAPI get itemsAPI => get<ItemsAPI>();

  QuestionsAPI get questionsAPI => get<QuestionsAPI>();

  RankRepository get rankRepository => get<RankRepository>();

  Translations get translations => get<Translations>();
}
