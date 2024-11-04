import 'dart:io';
import 'dart:math';

import 'package:file/file.dart' hide Directory;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  AdminApi get adminApi => get<AdminApi>();

  AppApi get appApi => get<AppApi>();

  Directory get appDir => get<Directory>(instanceName: 'appDir');

  FeedbackApi get feedbackApi => get<FeedbackApi>();

  FileStorageApi get fileStorageApi => get<FileStorageApi>();

  FileSystem get fileSystem => get<FileSystem>();

  LanguageCode get languageCode =>
      LanguageCode.values.byName(translations.$meta.locale.languageCode);

  LocalDatabaseApi get localDatabaseApi => get<LocalDatabaseApi>();

  LocalStorageApi get localStorageApi => get<LocalStorageApi>();

  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NativeApi get nativeApi => get<NativeApi>();

  int get otherOptionsAmount => get<int>(instanceName: 'otherOptionsAmount');

  PackageInfo get packageInfo => get<PackageInfo>();

  int get patchNotesPageSize => get<int>(instanceName: 'patchNotesPageSize');

  QuestionsApi get questionsApi => get<QuestionsApi>();

  RankApi get rankApi => get<RankApi>();

  Random get random => get<Random>();

  RemoteDatabaseApi get remoteDatabaseApi => get<RemoteDatabaseApi>();

  SharedPreferencesWithCache get sharedPrefs =>
      get<SharedPreferencesWithCache>();

  ThemeApi get themeApi => get<ThemeApi>();

  Directory get tmpDir => get<Directory>(instanceName: 'tmpDir');

  int get totalBaseItemQuestions =>
      get<int>(instanceName: 'totalBaseItemQuestions');

  int get totalFullItemQuestions =>
      get<int>(instanceName: 'totalFullItemQuestions');

  Translations get translations => get<Translations>();

  WidgetsBindingApi get widgetsBindingApi => get<WidgetsBindingApi>();
}
