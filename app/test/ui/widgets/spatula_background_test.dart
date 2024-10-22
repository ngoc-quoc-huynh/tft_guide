import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'spatula_background',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'Without a child',
            child: const SpatulaBackground(),
          ),
          GoldenTestScenario(
            name: 'With a child',
            child: SpatulaBackground(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
