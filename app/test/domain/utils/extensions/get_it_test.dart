import 'dart:io';
import 'dart:math';

import 'package:file/file.dart' hide Directory;
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/admin.dart';
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
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';

import '../../../mocks.dart';

void main() {
  test('returns AdminApi.', () {
    Injector.instance.registerSingleton<AdminApi>(MockAdminApi());
    addTearDown(Injector.instance.unregister<AdminApi>);

    expect(
      Injector.instance.adminApi,
      isA<AdminApi>(),
    );
  });

  test('returns ApplicationDocumentsDirectory.', () {
    Injector.instance.registerSingleton<Directory>(
      MockDirectory(),
      instanceName: 'appDir',
    );
    addTearDown(
      () async =>
          Injector.instance.unregister<Directory>(instanceName: 'appDir'),
    );

    expect(
      Injector.instance.appDir,
      isA<Directory>(),
    );
  });

  test('returns FeedbackApi.', () {
    Injector.instance.registerSingleton<FeedbackApi>(MockFeedbackApi());
    addTearDown(Injector.instance.unregister<FeedbackApi>);

    expect(
      Injector.instance.feedbackApi,
      isA<FeedbackApi>(),
    );
  });

  test('returns FileStorageApi.', () {
    Injector.instance.registerSingleton<FileStorageApi>(MockFileStorageApi());
    addTearDown(Injector.instance.unregister<FileStorageApi>);

    expect(
      Injector.instance.fileStorageApi,
      isA<FileStorageApi>(),
    );
  });

  test('returns FileSystem.', () {
    Injector.instance.registerSingleton<FileSystem>(MemoryFileSystem());
    addTearDown(Injector.instance.unregister<FileSystem>);

    expect(
      Injector.instance.fileSystem,
      isA<FileSystem>(),
    );
  });

  test('returns LanguageCode.', () {
    Injector.instance.registerSingleton<Translations>(AppLocale.en.buildSync());
    addTearDown(Injector.instance.unregister<Translations>);

    expect(
      Injector.instance.languageCode,
      isA<LanguageCode>(),
    );
  });

  test('returns LocalDatabaseApi.', () {
    Injector.instance
        .registerSingleton<LocalDatabaseApi>(MockLocalDatabaseApi());
    addTearDown(Injector.instance.unregister<LocalDatabaseApi>);

    expect(
      Injector.instance.localDatabaseApi,
      isA<LocalDatabaseApi>(),
    );
  });

  test('returns LocalStorageApi.', () {
    Injector.instance.registerSingleton<LocalStorageApi>(MockLocalStorageApi());
    addTearDown(Injector.instance.unregister<LocalStorageApi>);

    expect(
      Injector.instance.localStorageApi,
      isA<LocalStorageApi>(),
    );
  });

  test('returns Logger.', () {
    Injector.instance.registerSingleton<Logger>(MockLogger());
    addTearDown(Injector.instance.unregister<Logger>);

    expect(
      Injector.instance.logger,
      isA<Logger>(),
    );
  });

  test('returns LoggerApi.', () {
    Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi());
    addTearDown(Injector.instance.unregister<LoggerApi>);

    expect(
      Injector.instance.loggerApi,
      isA<LoggerApi>(),
    );
  });

  test('returns NativeApi.', () {
    Injector.instance.registerSingleton<NativeApi>(MockNativeApi());
    addTearDown(Injector.instance.unregister<NativeApi>);

    expect(
      Injector.instance.nativeApi,
      isA<NativeApi>(),
    );
  });

  test('returns other options amount.', () {
    Injector.instance
        .registerSingleton<int>(1, instanceName: 'otherOptionsAmount');
    addTearDown(
      () async =>
          Injector.instance.unregister<int>(instanceName: 'otherOptionsAmount'),
    );

    expect(
      Injector.instance.otherOptionsAmount,
      1,
    );
  });

  test('returns patch notes page size.', () {
    Injector.instance.registerSingleton<int>(
      1,
      instanceName: 'patchNotesPageSize',
    );
    addTearDown(
      () async => Injector.instance.unregister<int>(
        instanceName: 'patchNotesPageSize',
      ),
    );

    expect(
      Injector.instance.patchNotesPageSize,
      1,
    );
  });

  test('returns PackageInfo.', () {
    Injector.instance.registerSingleton<PackageInfo>(MockPackageInfo());
    addTearDown(Injector.instance.unregister<PackageInfo>);

    expect(
      Injector.instance.packageInfo,
      isA<PackageInfo>(),
    );
  });

  test('returns QuestionsApi.', () {
    Injector.instance.registerSingleton<QuestionsApi>(MockQuestionsApi());
    addTearDown(Injector.instance.unregister<QuestionsApi>);

    expect(
      Injector.instance.questionsApi,
      isA<QuestionsApi>(),
    );
  });

  test('returns RankApi.', () {
    Injector.instance.registerSingleton<RankApi>(MockRankApi());
    addTearDown(Injector.instance.unregister<RankApi>);

    expect(
      Injector.instance.rankApi,
      isA<RankApi>(),
    );
  });

  test('returns Random.', () {
    Injector.instance.registerSingleton<Random>(Random(0));
    addTearDown(Injector.instance.unregister<Random>);

    expect(
      Injector.instance.random,
      isA<Random>(),
    );
  });

  test('returns RemoteDatabaseApi.', () {
    Injector.instance
        .registerSingleton<RemoteDatabaseApi>(MockRemoteDatabaseApi());
    addTearDown(Injector.instance.unregister<RemoteDatabaseApi>);

    expect(
      Injector.instance.remoteDatabaseApi,
      isA<RemoteDatabaseApi>(),
    );
  });

  test('returns SharedPreferencesWithCache.', () {
    Injector.instance.registerSingleton<SharedPreferencesWithCache>(
      MockSharedPreferencesWithCache(),
    );
    addTearDown(Injector.instance.unregister<SharedPreferencesWithCache>);

    expect(
      Injector.instance.sharedPrefs,
      isA<SharedPreferencesWithCache>(),
    );
  });

  test('returns ThemeApi.', () {
    Injector.instance.registerSingleton<ThemeApi>(MockThemeApi());
    addTearDown(Injector.instance.unregister<ThemeApi>);

    expect(
      Injector.instance.themeApi,
      isA<ThemeApi>(),
    );
  });

  test('returns TemporaryDirectory.', () {
    Injector.instance.registerSingleton<Directory>(
      MockDirectory(),
      instanceName: 'tmpDir',
    );
    addTearDown(
      () async =>
          Injector.instance.unregister<Directory>(instanceName: 'tmpDir'),
    );

    expect(
      Injector.instance.tmpDir,
      isA<Directory>(),
    );
  });

  test('returns total base item questions.', () {
    Injector.instance.registerSingleton<int>(
      1,
      instanceName: 'totalBaseItemQuestions',
    );
    addTearDown(
      () async => Injector.instance
          .unregister<int>(instanceName: 'totalBaseItemQuestions'),
    );

    expect(
      Injector.instance.totalBaseItemQuestions,
      1,
    );
  });

  test('returns total full item questions.', () {
    Injector.instance.registerSingleton<int>(
      1,
      instanceName: 'totalFullItemQuestions',
    );
    addTearDown(
      () async => Injector.instance
          .unregister<int>(instanceName: 'totalFullItemQuestions'),
    );

    expect(
      Injector.instance.totalFullItemQuestions,
      1,
    );
  });

  test('returns Translations.', () {
    Injector.instance.registerSingleton<Translations>(AppLocale.en.buildSync());
    addTearDown(Injector.instance.unregister<Translations>);
    expect(
      Injector.instance.translations,
      isA<Translations>(),
    );
  });

  test('returns WidgetsBindingApi.', () {
    Injector.instance
        .registerSingleton<WidgetsBindingApi>(MockWidgetsBindingApi());
    addTearDown(Injector.instance.unregister<WidgetsBindingApi>);

    expect(
      Injector.instance.widgetsBindingApi,
      isA<WidgetsBindingApi>(),
    );
  });
}
