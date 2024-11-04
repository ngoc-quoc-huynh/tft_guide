import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/item_detail/error.dart';

import '../../../utils.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      TranslationsEn.build(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'error',
    builder: () => GoldenTestGroup(
      scenarioConstraints: pageConstraints(),
      children: [
        GoldenTestScenario(
          name: 'BaseItemDetail',
          child: const ItemDetailErrorPage<BaseItemDetail>(
            id: 'id',
          ),
        ),
        GoldenTestScenario(
          name: 'FullItemDetail',
          child: const ItemDetailErrorPage<FullItemDetail>(
            id: 'id',
          ),
        ),
      ],
    ),
  );
}
