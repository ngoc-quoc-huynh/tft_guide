import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/ranked/body/rank_name.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
        .registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly',
    fileName: 'ranked_name',
    builder: () => GoldenTestGroup(
      columns: Division.values.length,
      children: Tier.values
          .expand(
            (tier) => Division.values.map(
              (division) => GoldenTestScenario(
                name: '${tier.name} ${division.name}',
                child: RankedRankName(
                  tier: tier,
                  division: division,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
