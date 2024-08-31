import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  Directory get appDir => get<Directory>();

  FeedbackApi get feedbackApi => get<FeedbackApi>();

  FileStorageApi get fileStorageApi => get<FileStorageApi>();

  LanguageCode get languageCode =>
      LanguageCode.values.byName(translations.$meta.locale.languageCode);

  LocalDatabaseApi get localDatabaseApi => get<LocalDatabaseApi>();

  RankRepository get rankRepository => get<RankRepository>();

  RemoteDatabaseApi get remoteDatabaseApi => get<RemoteDatabaseApi>();

  ThemeApi get themeApi => get<ThemeApi>();

  Translations get translations => get<Translations>();
}
