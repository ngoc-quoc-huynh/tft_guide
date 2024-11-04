import 'package:alchemist/alchemist.dart';
import 'package:flutter/rendering.dart';
import 'package:tft_guide/ui/widgets/progress_bar.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'progress_bar',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
        columns: 1,
        children: [
          GoldenTestScenario(
            name: '0%',
            child: const ProgressBar(value: 0),
          ),
          GoldenTestScenario(
            name: '50%',
            child: const ProgressBar(value: 50),
          ),
          GoldenTestScenario(
            name: '100%',
            child: const ProgressBar(value: 100),
          ),
        ],
      ),
    );
