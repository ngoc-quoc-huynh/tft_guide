import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Sizes.maxWidgetWith),
      child: SizedBox(
        width: double.infinity,
        child: Card.filled(
          child: child,
        ),
      ),
    );
  }
}
