import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/icon.dart';

class SettingsTitleWithWarning extends StatelessWidget {
  const SettingsTitleWithWarning({
    required this.title,
    required this.hasError,
    super.key,
  });

  final String title;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Tooltip(
              message: Injector.instance.translations.general.errors.network,
              child: const CustomIcon.warning(),
            ),
          ),
      ],
    );
  }
}
