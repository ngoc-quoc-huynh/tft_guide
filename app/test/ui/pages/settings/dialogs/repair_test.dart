import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/button.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/dialog.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

Future<void> main() async {
  final fileStorageApi = MockFileStorageApi();
  final localDatabaseApi = MockLocalDatabaseApi();
  final remoteDatabaseApi = MockRemoteDatabaseApi();
  final nativeApi = MockNativeApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<FileStorageApi>(fileStorageApi)
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<RemoteDatabaseApi>(remoteDatabaseApi)
      ..registerSingleton<NativeApi>(nativeApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<FileStorageApi>()
      ..unregister<LocalDatabaseApi>()
      ..unregister<RemoteDatabaseApi>()
      ..unregister<NativeApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'repair',
    builder: () => const SettingsRepairDialog(),
  );

  await goldenTest(
    'renders success correctly.',
    fileName: 'repair_success',
    whilePerforming: (tester) async {
      await tap(find.byType(SettingsRepairStartButton))?.call(tester);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(fileStorageApi.clear).thenAnswer((_) => Future.value());
      when(localDatabaseApi.clear).thenAnswer((_) => Future.value());
      when(() => remoteDatabaseApi.loadAssetNames(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadBaseItems(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadFullItems(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadPatchNotes(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadBaseItemTranslations(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadFullItemTranslations(null))
          .thenAnswer((_) async => []);
      when(() => remoteDatabaseApi.loadPatchNoteTranslations(null))
          .thenAnswer((_) async => []);
      when(() => localDatabaseApi.saveBaseItems([]))
          .thenAnswer((_) => Future.value());
      when(() => localDatabaseApi.saveFullItems([]))
          .thenAnswer((_) => Future.value());
      when(() => localDatabaseApi.savePatchNotes([]))
          .thenAnswer((_) => Future.value());
      when(() => localDatabaseApi.saveBaseItemTranslations([]))
          .thenAnswer((_) => Future.value());
      when(() => localDatabaseApi.saveFullItemTranslations([]))
          .thenAnswer((_) => Future.value());
      when(() => localDatabaseApi.savePatchNoteTranslations([]))
          .thenAnswer((_) => Future.value());
      when(nativeApi.restartApp).thenAnswer((_) => Future.value());

      return const SettingsRepairDialog();
    },
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'repair_error',
    whilePerforming: (tester) async {
      await tap(find.byType(SettingsRepairStartButton))?.call(tester);
      await tester.longPress(find.byIcon(Icons.warning_amber));
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      when(fileStorageApi.clear).thenThrow(const UnknownException());

      return const SettingsRepairDialog();
    },
  );
}
