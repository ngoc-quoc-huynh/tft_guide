import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/badge_counter.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'badge_counter',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'Count is 0',
            child: const BadgeCounter(count: 0),
          ),
          GoldenTestScenario(
            name: 'Count is less or equal than 9',
            child: const BadgeCounter(count: 9),
          ),
          GoldenTestScenario(
            name: 'Count is greater than 9',
            child: const BadgeCounter(count: 10),
          ),
          GoldenTestScenario(
            name: 'With child',
            child: const BadgeCounter(
              count: 1,
              child: Text('Text'),
            ),
          ),
        ],
      ),
    );
