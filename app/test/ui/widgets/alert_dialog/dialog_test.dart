import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      TranslationsEn.build(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'dialog',
    builder: () => CustomAlertDialog(
      title: 'Title',
      content: const Text('Content'),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(result: () => 0),
      ],
    ),
  );
}
