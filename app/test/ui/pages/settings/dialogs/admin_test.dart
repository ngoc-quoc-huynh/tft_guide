import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/admin.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/admin.dart';

import '../../../../mocks.dart';

Future<void> main() async {
  final adminApi = MockAdminApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(TranslationsEn.build())
      ..registerSingleton<AdminApi>(adminApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<AdminApi>(),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'admin',
    pumpBeforeTest: (tester) => tester.pump(),
    builder: () => const SettingsAdminDialog(),
  );

  await goldenTest(
    'renders empty correctly.',
    fileName: 'admin_empty',
    pumpBeforeTest: (tester) => tester.pump(),
    whilePerforming: (tester) async {
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () => const SettingsAdminDialog(),
  );

  await goldenTest(
    'renders filled correctly.',
    fileName: 'admin_filled',
    pumpBeforeTest: (tester) => tester.pump(),
    whilePerforming: (tester) async {
      await tester.enterText(find.byType(EditableText), '12345');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      return null;
    },
    builder: () => const SettingsAdminDialog(),
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'admin_error',
    pumpBeforeTest: (tester) => tester.pump(),
    whilePerforming: (tester) async {
      when(() => adminApi.checkPassword('123456')).thenReturn(false);
      await tester.enterText(find.byType(EditableText), '123456');
      await tester.pumpAndSettle();
      return null;
    },
    builder: () => const SettingsAdminDialog(),
  );

  final adminCubit = MockValueCubit<bool>();
  whenListen(
    adminCubit,
    Stream.value(true),
    initialState: false,
  );
}
