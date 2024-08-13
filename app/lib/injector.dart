import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/infrastructure/repositories/items.dart';
import 'package:tft_guide/infrastructure/repositories/questions.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static void setupDependencies() => instance
    ..registerLazySingleton<ItemsAPI>(LocalItemsRepository.new)
    ..registerLazySingleton<RankRepository>(LocalRankRepository.new)
    ..registerLazySingleton<FeedbackAPI>(FeedbackRepository.new)
    ..registerLazySingleton<QuestionsAPI>(QuestionsRepository.new);
}
