import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'action',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'Cancel',
          child: const AlertDialogAction.cancel(),
        ),
        GoldenTestScenario(
          name: 'Confirm',
          child: AlertDialogAction.confirm(result: () => 0),
        ),
        GoldenTestScenario(
          name: 'Custom',
          child: AlertDialogAction.custom(
            text: 'Custom',
            onPressed: () {
              return;
            },
          ),
        ),
      ],
    ),
  );
}
