import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/button.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/dialog.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

Future<void> main() async {
  final fileStorageApi = MockFileStorageApi();
  final localDatabaseApi = MockLocalDatabaseApi();
  final remoteDatabaseApi = MockRemoteDatabaseApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<FileStorageApi>(fileStorageApi)
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<RemoteDatabaseApi>(remoteDatabaseApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<FileStorageApi>()
      ..unregister<LocalDatabaseApi>()
      ..unregister<RemoteDatabaseApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'check',
    builder: () => const SettingsCheckDialog(),
  );

  await goldenTest(
    'renders valid correctly.',
    fileName: 'check_valid',
    whilePerforming: (tester) async {
      await tap(find.byType(SettingsCheckStartButton))?.call(tester);
      await tester.longPress(find.byIcon(Icons.check).first);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(fileStorageApi.loadAssetsCount).thenReturn(1);
      when(remoteDatabaseApi.loadAssetsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadBaseItemsCount).thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadBaseItemsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadBaseItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadBaseItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(localDatabaseApi.loadFullItemsCount).thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadFullItemsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadFullItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadFullItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(localDatabaseApi.loadPatchNotesCount).thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadPatchNotesCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadPatchNoteTranslationsCount)
          .thenAnswer((_) async => 1);
      when(remoteDatabaseApi.loadPatchNoteTranslationsCount)
          .thenAnswer((_) async => 1);

      return const SettingsCheckDialog();
    },
  );

  await goldenTest(
    'renders invalid correctly.',
    fileName: 'check_invalid',
    whilePerforming: (tester) async {
      await tap(find.byType(SettingsCheckStartButton))?.call(tester);
      await tester.longPress(find.byIcon(Icons.close).last);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(fileStorageApi.loadAssetsCount).thenReturn(0);
      when(remoteDatabaseApi.loadAssetsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadBaseItemsCount).thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadBaseItemsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadBaseItemTranslationsCount)
          .thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadBaseItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(localDatabaseApi.loadFullItemsCount).thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadFullItemsCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadFullItemTranslationsCount)
          .thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadFullItemTranslationsCount)
          .thenAnswer((_) async => 1);
      when(localDatabaseApi.loadPatchNotesCount).thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadPatchNotesCount).thenAnswer((_) async => 1);
      when(localDatabaseApi.loadPatchNoteTranslationsCount)
          .thenAnswer((_) async => 0);
      when(remoteDatabaseApi.loadPatchNoteTranslationsCount)
          .thenAnswer((_) async => 1);

      return const SettingsCheckDialog();
    },
  );

  await goldenTest(
    'renders warning correctly.',
    fileName: 'check_warning',
    whilePerforming: (tester) async {
      await tap(find.byType(SettingsCheckStartButton))?.call(tester);
      await tester.longPress(find.byIcon(Icons.warning_amber).last);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(fileStorageApi.loadAssetsCount).thenThrow(const UnknownException());
      when(localDatabaseApi.loadBaseItemsCount)
          .thenThrow(const UnknownException());
      when(localDatabaseApi.loadFullItemsCount)
          .thenThrow(const UnknownException());
      when(localDatabaseApi.loadPatchNotesCount)
          .thenThrow(const UnknownException());

      return const SettingsCheckDialog();
    },
  );
}
