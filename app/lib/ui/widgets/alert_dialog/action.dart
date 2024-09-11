import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

sealed class AlertDialogAction<T> extends StatelessWidget {
  const AlertDialogAction({
    super.key,
  });

  const factory AlertDialogAction.cancel({
    Key? key,
  }) = _Cancel<T>;

  const factory AlertDialogAction.confirm({
    required T result,
    Key? key,
  }) = _Confirm<T>;

  const factory AlertDialogAction.custom({
    required String text,
    required T result,
    Key? key,
  }) = _Custom<T>;

  @protected
  TranslationsGeneralEn get translations =>
      Injector.instance.translations.general;
}

final class _Cancel<T> extends AlertDialogAction<T> {
  const _Cancel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(),
      child: Text(translations.cancel),
    );
  }
}

final class _Confirm<T> extends AlertDialogAction<T> {
  const _Confirm({
    required this.result,
    super.key,
  });

  final T result;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(result),
      child: Text(translations.confirm),
    );
  }
}

final class _Custom<T> extends AlertDialogAction<T> {
  const _Custom({
    required this.text,
    required this.result,
    super.key,
  });

  final String text;
  final T result;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(result),
      child: Text(text),
    );
  }
}
