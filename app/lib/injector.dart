import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/infrastructure/repositories/material_theme.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';
import 'package:tft_guide/infrastructure/repositories/sqlite_async.dart';
import 'package:tft_guide/infrastructure/repositories/supabase.dart';
import 'package:tft_guide/infrastructure/repositories/widgets_binding.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    instance
      ..registerLazySingleton<RankRepository>(LocalRankRepository.new)
      ..registerLazySingleton<FeedbackApi>(FeedbackRepository.new)
      ..registerSingletonAsync<RemoteDatabaseApi>(
        const SupabaseRepository().initialize,
        dispose: (api) => api.close(),
      )
      ..registerSingletonAsync(getApplicationDocumentsDirectory)
      ..registerSingletonAsync<LocalDatabaseApi>(
        SQLiteAsyncRepository().initialize,
        dispose: (api) => api.close(),
        dependsOn: [Directory],
      )
      ..registerLazySingleton<FileStorageApi>(LocalFileStorageRepository.new)
      ..registerLazySingleton<ThemeApi>(MaterialThemeRepository.new)
      ..registerLazySingleton<WidgetsBindingApi>(WidgetsBindingRepository.new);
    await instance.allReady();
  }
}
