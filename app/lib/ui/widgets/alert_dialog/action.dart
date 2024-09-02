import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

sealed class AlertDialogAction extends StatelessWidget {
  const AlertDialogAction({
    super.key,
  });

  const factory AlertDialogAction.cancel({
    VoidCallback? onPressed,
    Key? key,
  }) = _Cancel;

  const factory AlertDialogAction.confirm({
    required VoidCallback onPressed,
    Key? key,
  }) = _Confirm;

  const factory AlertDialogAction.custom({
    required String text,
    required VoidCallback onPressed,
    Key? key,
  }) = _Custom;

  @protected
  TranslationsGeneralEn get translations =>
      Injector.instance.translations.general;
}

final class _Cancel extends AlertDialogAction {
  const _Cancel({
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => context.pop(),
      child: Text(translations.cancel),
    );
  }
}

final class _Confirm extends AlertDialogAction {
  const _Confirm({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(translations.confirm),
    );
  }
}

final class _Custom extends AlertDialogAction {
  const _Custom({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
