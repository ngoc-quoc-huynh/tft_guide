import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'dialog',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'Default',
            child: const CustomDialog(
              title: Text('Title'),
              content: Text('Content'),
            ),
          ),
          GoldenTestScenario(
            name: 'With action',
            child: const CustomDialog(
              title: Text('Title'),
              content: Text('Content'),
              action: Text('Action'),
            ),
          ),
        ],
      ),
    );
