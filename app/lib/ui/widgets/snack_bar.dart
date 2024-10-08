import 'package:flutter/material.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';

final class CustomSnackBar extends SnackBar {
  const CustomSnackBar({
    required super.content,
    required super.backgroundColor,
    super.key,
  }) : super(
          behavior: SnackBarBehavior.floating,
        );

  static void showSuccess(
    BuildContext context,
    String text,
  ) =>
      _show(
        context: context,
        text: text,
        color: Theme.of(context).customColors.success,
      );

  static void showInfo(
    BuildContext context,
    String text,
  ) =>
      _show(
        context: context,
        text: text,
        color: Theme.of(context).colorScheme.primary,
      );

  static void _show({
    required BuildContext context,
    required Color color,
    required String text,
  }) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          CustomSnackBar(
            content: Text(text),
            backgroundColor: color,
          ),
        );
}
