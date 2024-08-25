import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/infrastructure/repositories/items.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/infrastructure/repositories/questions.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';
import 'package:tft_guide/infrastructure/repositories/sqlite_async.dart';
import 'package:tft_guide/infrastructure/repositories/supabase.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    instance
      ..registerLazySingleton<ItemsAPI>(LocalItemsRepository.new)
      ..registerLazySingleton<RankRepository>(LocalRankRepository.new)
      ..registerLazySingleton<FeedbackAPI>(FeedbackRepository.new)
      ..registerLazySingleton<QuestionsAPI>(QuestionsRepository.new)
      ..registerSingletonAsync<RemoteDatabaseAPI>(
        const SupabaseRepository().initialize,
        dispose: (api) => api.close(),
      )
      ..registerSingletonAsync(getApplicationDocumentsDirectory)
      ..registerSingletonAsync<LocalDatabaseAPI>(
        SQLiteAsyncRepository().initialize,
        dispose: (api) => api.close(),
        dependsOn: [Directory],
      )
      ..registerLazySingleton<FileStorageAPI>(LocalFileStorageRepository.new);
    await instance.allReady();
  }
}
