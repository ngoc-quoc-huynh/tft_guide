import 'dart:io';
import 'dart:math';

import 'package:file/file.dart' hide Directory, File;
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/admin.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/infrastructure/repositories/feedback.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/infrastructure/repositories/logger.dart';
import 'package:tft_guide/infrastructure/repositories/material_theme.dart';
import 'package:tft_guide/infrastructure/repositories/native.dart';
import 'package:tft_guide/infrastructure/repositories/rank.dart';
import 'package:tft_guide/infrastructure/repositories/shared_preferences.dart';
import 'package:tft_guide/infrastructure/repositories/widgets_binding.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/config.dart';

import 'mocks/admin.dart';
import 'mocks/app.dart';
import 'mocks/hydrated_storage.dart';
import 'mocks/local_database.dart';
import 'mocks/questions.dart';
import 'mocks/remote_database.dart';

final class TestInjector {
  const TestInjector._();

  static Future<void> setUp() async {
    Injector.instance
      ..registerLazySingleton<AdminApi>(MockAdminApi.new)
      ..registerLazySingleton<AppApi>(MockAppApi.new)
      ..registerSingletonAsync<Directory>(
        getApplicationDocumentsDirectory,
        instanceName: 'appDir',
      )
      ..registerLazySingleton<FeedbackApi>(FeedbackRepository.new)
      ..registerLazySingleton<FileStorageApi>(LocalFileStorageRepository.new)
      ..registerLazySingleton<FileSystem>(MemoryFileSystem.new)
      ..registerLazySingleton<LocalDatabaseApi>(MockLocalDatabaseApi.new)
      ..registerLazySingleton<LocalStorageApi>(SharedPreferencesRepository.new)
      ..registerLazySingleton<Logger>(() => Logger(level: Level.off))
      ..registerLazySingleton<LoggerApi>(LoggerRepository.new)
      ..registerLazySingleton<NativeApi>(NativeRepository.new)
      ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
      ..registerLazySingleton<QuestionsApi>(MockQuestionsApi.new)
      ..registerLazySingleton<Random>(() => Random(0))
      ..registerLazySingleton<RankApi>(LocalRankRepository.new)
      ..registerLazySingleton<RemoteDatabaseApi>(MockRemoteDatabaseApi.new)
      ..registerSingletonAsync<SharedPreferencesWithCache>(
        () => SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(),
        ),
      )
      ..registerLazySingleton<ThemeApi>(MaterialThemeRepository.new)
      ..registerLazySingleton<WidgetsBindingApi>(WidgetsBindingRepository.new)
      ..registerLazySingleton<int>(
        () => Config.patchNotesPageSize,
        instanceName: 'patchNotesPageSize',
      )
      ..registerLazySingleton<int>(
        () => Config.totalBaseItemQuestions,
        instanceName: 'totalBaseItemQuestions',
      )
      ..registerLazySingleton<int>(
        () => Config.totalFullItemQuestions,
        instanceName: 'totalFullItemQuestions',
      )
      ..registerLazySingleton<int>(
        () => Config.otherOptionsAmount,
        instanceName: 'otherOptionsAmount',
      );
    await Injector.instance.allReady();
    HydratedBloc.storage = const MockHydratedStorage();
  }

  static Future<void> tearDown() async {
    await Injector.instance.reset();
    HydratedBloc.storage = null;
  }
}
