import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/infrastructure/repositories/app_logger.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/infrastructure/repositories/hydrated_storage.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/infrastructure/repositories/material_theme.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';
import 'package:tft_guide/infrastructure/repositories/shared_preferences.dart';
import 'package:tft_guide/infrastructure/repositories/sqlite_async.dart';
import 'package:tft_guide/infrastructure/repositories/supabase.dart';
import 'package:tft_guide/infrastructure/repositories/widgets_binding.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    instance
      ..registerLazySingleton<FeedbackApi>(FeedbackRepository.new)
      ..registerLazySingleton<RemoteDatabaseApi>(SupabaseRepository.new)
      ..registerSingletonAsync(getApplicationDocumentsDirectory)
      ..registerLazySingleton<LocalDatabaseApi>(SqliteAsyncRepository.new)
      ..registerLazySingleton<FileStorageApi>(LocalFileStorageRepository.new)
      ..registerLazySingleton<ThemeApi>(MaterialThemeRepository.new)
      ..registerLazySingleton<WidgetsBindingApi>(WidgetsBindingRepository.new)
      ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
      ..registerSingletonAsync<SharedPreferencesWithCache>(
        () => SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(),
        ),
      )
      ..registerLazySingleton<LocalStorageApi>(SharedPreferencesRepository.new)
      ..registerLazySingleton<RankApi>(LocalRankRepository.new)
      ..registerLazySingleton<LoggerApi>(AppLogger.new);
    await instance.allReady();
    HydratedBloc.storage = const SharedPrefsHydratedStorage();
  }
}
