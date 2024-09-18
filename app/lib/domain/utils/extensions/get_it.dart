import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  Directory get appDir => get<Directory>();

  FeedbackApi get feedbackApi => get<FeedbackApi>();

  FileStorageApi get fileStorageApi => get<FileStorageApi>();

  LanguageCode get languageCode =>
      LanguageCode.values.byName(translations.$meta.locale.languageCode);

  LocalDatabaseApi get localDatabaseApi => get<LocalDatabaseApi>();

  LocalStorageApi get localStorageApi => get<LocalStorageApi>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NativeApi get nativeApi => get<NativeApi>();

  PackageInfo get packageInfo => get<PackageInfo>();

  RankApi get rankApi => get<RankApi>();

  RemoteDatabaseApi get remoteDatabaseApi => get<RemoteDatabaseApi>();

  SharedPreferencesWithCache get sharedPrefs =>
      get<SharedPreferencesWithCache>();

  ThemeApi get themeApi => get<ThemeApi>();

  Translations get translations => get<Translations>();

  WidgetsBindingApi get widgetsBindingApi => get<WidgetsBindingApi>();
}
