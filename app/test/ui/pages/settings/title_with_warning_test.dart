import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/title_with_warning.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'title_with_warning',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario.builder(
          name: 'Without error',
          builder: (_) => const SettingsTitleWithWarning(
            title: 'Title',
            hasError: false,
          ),
        ),
        GoldenTestScenario.builder(
          name: 'With error',
          builder: (_) => const SettingsTitleWithWarning(
            title: 'Title',
            hasError: true,
          ),
        ),
      ],
    ),
  );
}
