import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';

Future<void> main() async {
  test(
    'has correctsize.',
    () => expect(
      const CustomAppBar().preferredSize,
      const Size(double.infinity, kToolbarHeight),
    ),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'custom_app_bar',
    builder: () => GoldenTestGroup(
      scenarioConstraints: const BoxConstraints(minWidth: 200),
      children: [
        GoldenTestScenario(
          name: 'Default',
          child: const CustomAppBar(),
        ),
        GoldenTestScenario(
          name: 'Force material transparency',
          child: const CustomAppBar(
            forceMaterialTransparency: true,
          ),
        ),
        GoldenTestScenario(
          name: 'With title',
          child: const CustomAppBar(
            title: Text('Title'),
          ),
        ),
        GoldenTestScenario(
          name: 'Center title',
          child: const CustomAppBar(
            title: Text('Title'),
            centerTitle: true,
          ),
        ),
        GoldenTestScenario(
          name: 'With parameters',
          child: const CustomAppBar(
            leading: Icon(Icons.menu),
            title: Text('Title'),
            actions: [Icon(Icons.settings)],
          ),
        ),
        GoldenTestScenario(
          name: 'TFT',
          child: CustomAppBar.tft(),
        ),
      ],
    ),
  );
}
