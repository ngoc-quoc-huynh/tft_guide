import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/items.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/questions.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

extension GetItExtension on GetIt {
  Directory get appDir => get<Directory>();

  FeedbackAPI get feedbackAPI => get<FeedbackAPI>();

  FileStorageAPI get fileStorageAPI => get<FileStorageAPI>();

  ItemsAPI get itemsAPI => get<ItemsAPI>();

  LanguageCode get languageCode =>
      LanguageCode.values.byName(translations.$meta.locale.languageCode);

  LocalDatabaseAPI get localDatabaseAPI => get<LocalDatabaseAPI>();

  QuestionsAPI get questionsAPI => get<QuestionsAPI>();

  RankRepository get rankRepository => get<RankRepository>();

  RemoteDatabaseAPI get remoteDatabaseAPI => get<RemoteDatabaseAPI>();

  Translations get translations => get<Translations>();
}
