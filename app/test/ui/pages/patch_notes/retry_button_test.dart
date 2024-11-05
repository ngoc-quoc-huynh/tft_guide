import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/patch_notes/retry_button.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(
        AppLocale.en.buildSync(),
      ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'retry_button',
    constraints: BoxConstraints.tight(const Size(300, 120)),
    builder: () => const CustomScrollView(
      slivers: [PatchNotesRetryButton()],
    ),
  );
}
