import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/item_detail/stats.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'stats',
    constraints: const BoxConstraints(
      maxHeight: 100,
      maxWidth: 350,
      minWidth: 350,
    ),
    builder: () => const ItemDetailStats(
      item: BaseItemDetail(
        id: 'id',
        name: 'name',
        description: 'description',
        hint: 'hint',
      ),
    ),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'stats_filled',
    whilePerforming: (tester) async {
      await tester.longPress(find.byType(Icon).first);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () => GoldenTestGroup(
      scenarioConstraints: const BoxConstraints(
        maxHeight: 200,
        maxWidth: 350,
        minWidth: 350,
      ),
      children: [
        GoldenTestScenario(
          name: 'Half',
          child: const ItemDetailStats(
            item: BaseItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
              abilityPower: 1,
              armor: 2,
              attackDamage: 3,
              attackSpeed: 4,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'Full',
          child: const ItemDetailStats(
            item: BaseItemDetail(
              id: 'id',
              name: 'name',
              description: 'description',
              hint: 'hint',
              abilityPower: 1,
              armor: 2,
              attackDamage: 3,
              attackSpeed: 4,
              crit: 5,
              health: 6,
              magicResist: 7,
              mana: 8,
            ),
          ),
        ),
      ],
    ),
  );
}
