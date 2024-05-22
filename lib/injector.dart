import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/infrastructure/repositories/items.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static void setupDependencies() => instance
    ..registerLazySingleton<Translations>(_createTranslations)
    ..registerLazySingleton<ItemsAPI>(LocalItemsRepository.new)
    ..registerLazySingleton<RankRepository>(LocalRankRepository.new);

  static Translations _createTranslations() =>
      LocaleSettings.instance.currentTranslations;
}
