import 'package:alchemist/alchemist.dart';
import 'package:flutter/rendering.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'error_text',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(minWidth: 100),
        children: [
          GoldenTestScenario(
            name: 'Default',
            child: const ErrorText(text: 'Error'),
          ),
          GoldenTestScenario(
            name: 'Centered',
            child: const ErrorText(
              text: 'Error',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
