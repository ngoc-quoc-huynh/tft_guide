import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/admin.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/app_update.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/design.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/feedback.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/language.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/dialog.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/reset.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/update_elo.dart';

import 'robot.dart';

// ignore_for_file: avoid-non-ascii-symbols, since they are test data.

extension type SettingsPageRobot(WidgetTester _tester) implements Robot {
  Future<void> openSettings() async {
    await _tester.tap(find.byIcon(Icons.settings));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyAppUpdateDialog() async {
    await _tester.tap(find.byIcon(Icons.update));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsAppUpdateDialog>(), findsOneWidget);
    await _tester.tap(find.byIcon(Icons.close));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyDesignDialog() async {
    await _testDesignSelection('Bright', const Color(0xfffef7ff));
    await _testDesignSelection('Dark', const Color(0xff151218));
  }

  Future<void> verifyLanguageDialog() async {
    await _testLanguageSelection(
      language: 'German',
      german: 'German',
      english: 'English',
      deviceLanguage: 'Device language',
    );
    await _testLanguageSelection(
      language: 'Englisch',
      german: 'Deutsch',
      english: 'Englisch',
      deviceLanguage: 'Gerätesprache',
    );
  }

  Future<void> verifyCheckDialog() async {
    await _tester.tap(find.byIcon(Icons.checklist));
    await _tester.pumpAndSettle();
    await _tester.tap(find.text('Start check'));
    await _tester.pumpAndSettle();
    expect(find.byIcon(Icons.check), findsNWidgets(5));
    await _tester.tap(
      find.descendant(
        of: find.byType(FilledButton),
        matching: find.byIcon(Icons.check),
      ),
    );
    await _tester.pumpAndSettle();
  }

  Future<void> verifyRepairDialog() async {
    await _tester.tap(find.byIcon(Icons.build));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsRepairDialog>(), findsOneWidget);
    await _tester.tap(find.byIcon(Icons.close));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyResetDialog() async {
    await _tester.tap(find.byIcon(Icons.restart_alt));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsResetDialog>(), findsOneWidget);
    await _tester.tap(
      find.descendant(
        of: find.byType(TextButton),
        matching: find.text('Reset'),
      ),
    );
    await _tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('Progress has been successfully reset.'),
      ),
      findsOneWidget,
    );
  }

  Future<void> verifyFeedbackDialog() async {
    await _tester.tap(find.byIcon(Icons.feedback));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsFeedbackDialog>(), findsOneWidget);
    await _tester.tap(find.byIcon(Icons.close));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyLicensePage() async {
    await _tester.tap(find.byIcon(Icons.library_books));
    await _tester.pumpAndSettle();
    expect(find.byType(LicensePage), findsOneWidget);
    await _tester.tap(find.byType(BackButton));
    await _tester.pumpAndSettle();
  }

  Future<void> verifyAdminDialog() async {
    for (int i = 0; i < 7; i++) {
      await _tester.tap(find.text('1.0.0'));
    }
    await _tester.pump();
    expect(find.bySubtype<SettingsAdminDialog>(), findsOneWidget);
    await _tester.enterText(find.byType(EditableText), '123456');
    await _tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('You are now an admin!'),
      ),
      findsOneWidget,
    );
  }

  Future<void> verifyUpdateEloDialog() async {
    await _tester.tap(find.byIcon(Icons.edit));
    await _tester.pump();
    expect(find.bySubtype<SettingsUpdateEloDialog>(), findsOneWidget);
    await _tester.enterText(find.byType(TextFormField), '1');
    await _tester.tap(
      find.descendant(
        of: find.byType(TextButton),
        matching: find.text('Update'),
      ),
    );
    await _tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('Elo has been updated successfully.'),
      ),
      findsOneWidget,
    );
  }

  Future<void> goBackToRankedPage() async {
    await _tester.tap(find.byType(BackButton));
    await _tester.pumpAndSettle();
  }

  Future<void> _testDesignSelection(String design, Color expectedColor) async {
    await _tester.tap(find.byIcon(Icons.brightness_6_rounded));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsDesignDialog>(), findsOneWidget);
    await _tester.tap(find.text(design));
    await _tester.tap(find.text('OK'));
    await _tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('Design has been updated successfully.'),
      ),
      findsOneWidget,
    );
    expect(
      Theme.of(_tester.element(find.byType(Scaffold))).scaffoldBackgroundColor,
      expectedColor,
    );
  }

  Future<void> _testLanguageSelection({
    required String language,
    required String german,
    required String english,
    required String deviceLanguage,
  }) async {
    await _tester.tap(find.byIcon(Icons.flag_outlined));
    await _tester.pumpAndSettle();
    expect(find.bySubtype<SettingsLanguageDialog>(), findsOneWidget);
    expect(find.text(german), findsOneWidget);
    expect(find.text(english), findsOneWidget);
    expect(find.text(deviceLanguage), findsOneWidget);
    await _tester.tap(find.text(language));
    await _tester.tap(find.text('OK'));
    await _tester.pumpAndSettle();
  }
}
