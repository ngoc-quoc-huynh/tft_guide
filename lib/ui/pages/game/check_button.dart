import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.verticalPadding / 2,
        bottom: Sizes.verticalPadding,
      ),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: FilledButton(
          onPressed: () => unawaited(
            FeedbackBottomSheet.show(context),
          ),
          child: const Text('Check'),
        ),
      ),
    );
  }
}
