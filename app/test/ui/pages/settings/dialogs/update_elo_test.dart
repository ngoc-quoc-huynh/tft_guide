import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/update_elo.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'update_elo',
    builder: () => const SettingsUpdateEloDialog(),
  );
}
