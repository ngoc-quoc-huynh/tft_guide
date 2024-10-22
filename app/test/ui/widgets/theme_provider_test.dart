import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/theme_provider.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'theme_provider',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxHeight: 100),
        children: [
          GoldenTestScenario(
            name: 'ThemeData is null',
            child: ThemeProvider(
              data: null,
              builder: (context) => Container(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'ThemeData is not null',
            child: ThemeProvider(
              data: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              ),
              builder: (context) => Container(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
