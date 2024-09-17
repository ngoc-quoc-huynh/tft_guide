import 'package:flutter/material.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';

sealed class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  const factory CustomIcon.warning({Key? key}) = _Warning;
}

final class _Warning extends CustomIcon {
  const _Warning({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.warning_amber,
      color: Theme.of(context).customColors.warning,
    );
  }
}
